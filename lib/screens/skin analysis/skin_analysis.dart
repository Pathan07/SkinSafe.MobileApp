import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

// Model to store scan history
class ScanResult {
  final String id;
  final String date;
  final double percentage;
  final String diagnosis;
  final String imagePath;

  ScanResult({
    required this.id,
    required this.date,
    required this.percentage,
    required this.diagnosis,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'percentage': percentage,
      'diagnosis': diagnosis,
      'imagePath': imagePath,
    };
  }

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      id: json['id'],
      date: json['date'],
      percentage: json['percentage'],
      diagnosis: json['diagnosis'],
      imagePath: json['imagePath'],
    );
  }
}

class MelanomaDetector extends StatefulWidget {
  const MelanomaDetector({Key? key}) : super(key: key);

  @override
  _MelanomaDetectorState createState() => _MelanomaDetectorState();
}

class _MelanomaDetectorState extends State<MelanomaDetector> {
  Interpreter? _interpreter;
  bool _isLoaded = false;
  String modelInfo = "Loading model...";
  List<int>? _inputShape;
  List<int>? _outputShape;
  String inputTypeStr = "";
  String outputTypeStr = "";

  File? _selectedImage;
  final picker = ImagePicker();
  String _prediction = "";
  double _predictionPercentage = 0.0;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  // Function to load and inspect the model
  Future<void> _loadModel() async {
    try {
      // Initialize interpreter with the model file path
      _interpreter = await Interpreter.fromAsset(
          'assets/dataset/melanoma_detection_model.tflite');

      // Get input and output details
      var inputTensor = _interpreter!.getInputTensor(0);
      var outputTensor = _interpreter!.getOutputTensor(0);

      _inputShape = inputTensor.shape;
      _outputShape = outputTensor.shape;

      // Store type information as strings
      inputTypeStr = inputTensor.type.toString();
      outputTypeStr = outputTensor.type.toString();

      setState(() {
        _isLoaded = true;
        modelInfo = "Model loaded successfully";
      });
    } catch (e) {
      print('Error loading model: $e');
      setState(() {
        modelInfo = "Error loading model: $e";
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      // Auto-scan when image is selected
      _processSkinImage();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      // Auto-scan when image is selected
      _processSkinImage();
    }
  }

  // Validate if image contains skin
  Future<bool> _validateSkinImage(img.Image image) {
    // Count skin-tone pixels
    int skinPixels = 0;
    int totalSampledPixels = 0;

    // Sample pixels throughout the image (checking every 5th pixel to save processing time)
    for (int y = 0; y < image.height; y += 5) {
      for (int x = 0; x < image.width; x += 5) {
        final pixel = image.getPixel(x, y);
        totalSampledPixels++;

        // RGB values
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        // Simple skin tone detection
        // Based on RGB ratios typical in skin tones
        if (r > 60 &&
            g > 40 &&
            b > 20 &&
            r > g &&
            g > b &&
            (r - g) > 15 &&
            (r - g) < 100) {
          skinPixels++;
        }
      }
    }

    // Calculate percentage of skin pixels
    double skinPercentage = (skinPixels / totalSampledPixels) * 100;
    print('Skin percentage detected: $skinPercentage%');

    // Return true if enough skin is detected (adjust threshold as needed)
    return Future.value(skinPercentage > 30);
  }

  // Save scan result to history
  Future<void> _saveScanToHistory(
      String diagnosis, double percentage, File imageFile) async {
    try {
      // Create a unique ID for this scan
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      String date =
          DateTime.now().toString().split(' ')[0]; // YYYY-MM-DD format

      // Copy image to app documents directory for persistent storage
      final directory = await getApplicationDocumentsDirectory();
      final String imagePath = '${directory.path}/scan_$id.jpg';
      await imageFile.copy(imagePath);

      // Create scan result object
      final scanResult = ScanResult(
        id: id,
        date: date,
        percentage: percentage,
        diagnosis: diagnosis,
        imagePath: imagePath,
      );

      // Get stored history
      final prefs = await SharedPreferences.getInstance();
      List<String> historyJson = prefs.getStringList('scan_history') ?? [];

      // Add new scan to history
      historyJson.add(jsonEncode(scanResult.toJson()));

      // Save updated history
      await prefs.setStringList('scan_history', historyJson);

      print('Scan saved to history successfully');
    } catch (e) {
      print('Error saving scan to history: $e');
    }
  }

  // Process the image and make prediction
  Future<void> _processSkinImage() async {
    if (_interpreter == null ||
        _selectedImage == null ||
        _inputShape == null ||
        _outputShape == null) {
      setState(() {
        _prediction =
            "Cannot process image: Model not loaded properly or no image selected";
      });
      return;
    }

    setState(() {
      _isProcessing = true;
      _prediction = "Processing image...";
    });

    try {
      // Read the image using the correct Command approach
      final command = img.Command()..decodeImageFile(_selectedImage!.path);
      final decodedImage = await command.getImage();

      if (decodedImage == null) {
        setState(() {
          _isProcessing = false;
          _prediction = "Failed to decode image";
        });
        return;
      }

      // Add validation to check if this is a skin image
      bool isValidSkinImage = await _validateSkinImage(decodedImage);
      if (!isValidSkinImage) {
        setState(() {
          _isProcessing = false;
          _prediction = "Please upload a clear image of skin or a skin lesion";
        });
        return;
      }

      // Resize image to match model input
      final inputHeight = _inputShape![1]; // Assuming NHWC format
      final inputWidth = _inputShape![2];

      // Use the correct resize syntax
      final resizeCommand = img.Command()
        ..image(decodedImage)
        ..copyResize(width: inputWidth, height: inputHeight);
      final resizedImage = await resizeCommand.getImage();

      if (resizedImage == null) {
        setState(() {
          _isProcessing = false;
          _prediction = "Failed to resize image";
        });
        return;
      }

      // Create properly shaped input tensor
      var inputBuffer = List.generate(
          1,
          (_) => List.generate(
              inputHeight,
              (_) => List.generate(inputWidth, (_) => List.filled(3, 0.0),
                  growable: false),
              growable: false),
          growable: false);

      // Extract pixel data correctly
      for (int y = 0; y < inputHeight; y++) {
        for (int x = 0; x < inputWidth; x++) {
          final pixel = resizedImage.getPixel(x, y);
          final r = pixel.r / 255.0;
          final g = pixel.g / 255.0;
          final b = pixel.b / 255.0;

          inputBuffer[0][y][x][0] = r;
          inputBuffer[0][y][x][1] = g;
          inputBuffer[0][y][x][2] = b;
        }
      }

      // Prepare output buffer with the correct shape [1,1]
      var outputBuffer = List.generate(
          _outputShape![0], (_) => List.filled(_outputShape![1], 0.0),
          growable: false);

      // Run inference
      _interpreter!.run(inputBuffer, outputBuffer);

      // Process the output
      _predictionPercentage = outputBuffer[0][0] * 100;

      // Add a delay to show scanning effect (1 second)
      await Future.delayed(const Duration(seconds: 1));

      // Determine diagnosis based on percentage
      String diagnosis;
      bool isSafe = false;

      if (_predictionPercentage < 20) {
        diagnosis = "You don't have cancer";
        isSafe = true;
      } else if (_predictionPercentage > 50) {
        diagnosis = "High risk of melanoma";
      } else {
        diagnosis = "Low risk of melanoma ";
      }

      // Save scan to history
      await _saveScanToHistory(
          diagnosis, _predictionPercentage, _selectedImage!);

      setState(() {
        _isProcessing = false;
        _prediction = diagnosis;
      });

      // Navigate based on diagnosis
      if (isSafe) {
        // Navigate to safe screen after brief delay
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SafeResultScreen(
                percentage: _predictionPercentage,
                image: _selectedImage!,
              ),
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _prediction = "Error processing image: $e";
      });
      print('Error processing image: $e');
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define colors to match new theme
    final Color logoColor = Colors.lightGreen.shade300;
    final Color textPrimaryColor = Colors.white;
    final Color textSecondaryColor = Colors.black87;
    final Color whiteColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Skin Analysis',
          style: TextStyle(fontSize: 20, color: AppColors.textPrimaryColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.logoColor,
        actions: const [
          // Added history button in app bar
          // IconButton(
          //   icon: Icon(Icons.history),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => HistoryScreen1(),
          //       ),
          //     );
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.info),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
              child: Text(
                "Upload Skin Photo",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textSecondaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: Text(
                "Please upload a clear photo of skin for analysis. Ensure good lighting and focus on the area of concern.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _selectedImage != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                            if (_isProcessing)
                              Container(
                                color: Colors.black54,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "Scanning...",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        )
                      : const Center(
                          child: Text('No image selected.'),
                        ),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Accepted file types: JPG, PNG",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10, left: 10, bottom: 20),
              child: Text(
                "Our melanoma detection process uses advanced AI to analyze your skin photo and provide a detailed report.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            // Only show prediction if available and image is selected and not processing
            if (_prediction.isNotEmpty &&
                _selectedImage != null &&
                !_isProcessing &&
                !_prediction.contains("You don't have cancer"))
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _prediction,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _prediction.contains("High risk")
                            ? Colors.red
                            : _prediction.contains("Low risk")
                                ? Colors.orange
                                : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    if (_prediction.contains("risk"))
                      Text(
                        'Melanoma probability: ${_predictionPercentage.toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),

                    const SizedBox(height: 20),

                    // Progress indicator for the prediction percentage
                    if (_prediction.contains("risk"))
                      LinearProgressIndicator(
                        value: _predictionPercentage / 100,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _predictionPercentage > 50
                              ? Colors.red
                              : Colors.orange,
                        ),
                        minHeight: 10,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed:
                  _isLoaded && !_isProcessing ? _pickImageFromGallery : null,
              icon: Icon(Icons.image, color: whiteColor),
              label: const Text("Gallery"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.logoColor,
                foregroundColor: whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            ElevatedButton.icon(
              onPressed:
                  _isLoaded && !_isProcessing ? _pickImageFromCamera : null,
              icon: Icon(Icons.camera_alt, color: whiteColor),
              label: const Text("Camera"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.logoColor,
                foregroundColor: whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Safe result screen
class SafeResultScreen extends StatelessWidget {
  final double percentage;
  final File image;

  const SafeResultScreen(
      {Key? key, required this.percentage, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Results'),
        backgroundColor: Colors.lightGreen.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightGreen.shade100,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "You don't have cancer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Your skin analysis shows normal results with a very low risk factor of ${percentage.toStringAsFixed(2)}%.",
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recommendations:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.wb_sunny, color: Colors.orange),
                      title: Text("Use sunscreen daily"),
                      dense: true,
                    ),
                    ListTile(
                      leading: Icon(Icons.health_and_safety,
                          color: Colors.lightGreen),
                      title: Text("Perform regular skin self-exams"),
                      dense: true,
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.blue),
                      title: Text(
                          "Schedule annual skin check-ups with a dermatologist"),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Show the analyzed image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Analyzed Image:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen.shade300,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Back to Scanner"),
        ),
      ),
    );
  }
}

// History screen to show past scans
class HistoryScreen1 extends StatefulWidget {
  const HistoryScreen1({Key? key}) : super(key: key);

  @override
  _HistoryScreenState1 createState() => _HistoryScreenState1();
}

class _HistoryScreenState1 extends State<HistoryScreen1> {
  List<ScanResult> _scanHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> historyJson = prefs.getStringList('scan_history') ?? [];

      List<ScanResult> history = [];
      for (String item in historyJson) {
        try {
          Map<String, dynamic> json = jsonDecode(item);
          history.add(ScanResult.fromJson(json));
        } catch (e) {
          print('Error parsing history item: $e');
        }
      }

      // Sort by date (newest first)
      history.sort((a, b) => b.id.compareTo(a.id));

      setState(() {
        _scanHistory = history;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading history: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan History',
          style: TextStyle(color: AppColors.textPrimaryColor),
        ),
        backgroundColor: AppColors.logoColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _scanHistory.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.history,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No scan history found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your scan results will appear here',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _scanHistory.length,
                  itemBuilder: (context, index) {
                    final scan = _scanHistory[index];
                    final bool isSafe =
                        scan.diagnosis.contains("don't have cancer");
                    final Color statusColor = isSafe
                        ? Colors.green
                        : scan.diagnosis.contains("High risk")
                            ? Colors.red
                            : Colors.orange;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isSafe ? Icons.check_circle : Icons.warning,
                            color: statusColor,
                          ),
                        ),
                        title: Text(
                          scan.date,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scan.diagnosis),
                            Text(
                              'Risk: ${scan.percentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Show detailed view when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ScanDetailScreen(scan: scan),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

class ScanDetailScreen extends StatelessWidget {
  final ScanResult scan;

  const ScanDetailScreen({Key? key, required this.scan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSafe = scan.diagnosis.contains("don't have cancer");
    final Color statusColor = isSafe
        ? Colors.green
        : scan.diagnosis.contains("High risk")
            ? Colors.red
            : Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Details'),
        backgroundColor: Colors.lightGreen.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image at the top
            Container(
              width: double.infinity,
              height: 250,
              child: Image.file(
                File(scan.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 64,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            // Date and result
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isSafe ? Icons.check_circle : Icons.warning,
                        color: statusColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        scan.diagnosis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${scan.date}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Risk assessment
                  const Text(
                    'Risk Assessment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: scan.percentage / 100,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      scan.percentage > 50
                          ? Colors.red
                          : scan.percentage > 20
                              ? Colors.orange
                              : Colors.green,
                    ),
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Melanoma probability: ${scan.percentage.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recommendations
                  const Text(
                    'Recommendations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.wb_sunny, color: Colors.orange),
                          title: Text("Use sunscreen daily"),
                          dense: true,
                        ),
                        const ListTile(
                          leading: Icon(Icons.health_and_safety,
                              color: Colors.lightGreen),
                          title: Text("Perform regular skin self-exams"),
                          dense: true,
                        ),
                        if (scan.percentage > 20)
                          const ListTile(
                            leading:
                                Icon(Icons.local_hospital, color: Colors.red),
                            title: Text("Consult a dermatologist soon"),
                            dense: true,
                          )
                        else
                          const ListTile(
                            leading:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            title: Text("Schedule annual skin check-ups"),
                            dense: true,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Back to History"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen.shade300,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
