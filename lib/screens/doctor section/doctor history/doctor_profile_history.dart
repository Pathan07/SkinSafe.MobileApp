import 'package:flutter/material.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_buttons.dart';
import 'package:skin_safe_app/components/custom_widgets/custom_text.dart';
import 'package:skin_safe_app/components/routes/route_name.dart';
import 'package:skin_safe_app/components/utilities/color.dart';
import 'package:skin_safe_app/components/utilities/images.dart';

class DoctorProfileHistory extends StatelessWidget {
  final String docName;
  const DoctorProfileHistory({super.key, required this.docName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textSize20(text: docName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(ImageRes.doctorLogo),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textSize20(
                              text: docName,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSeconderyColor),
                          textSize16(text: "Specialist in Dermatology"),
                          textSize14(
                              text: "10+ years of experience",
                              color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                child: customButton(
                    text: "Message",
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.doctorChat);
                    },
                    textColor: AppColors.textPrimaryColor),
              ),
              // History Section
              const Text(
                "History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              textSize16(
                  text:
                      "$docName has been providing exceptional dermatology services for over a decade. "
                      "With a focus on early detection of skin issues, $docName has helped numerous patients achieve healthier skin.",
                  fontWeight: FontWeight.normal,
                  align: TextAlign.justify),
              const SizedBox(height: 20),

              // Certifications Section
              textSize18(
                  text: "Certifications", color: AppColors.textSeconderyColor),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.check_circle, color: Colors.green),
                    title: textSize16(
                        text: "Certified Dermatologist",
                        fontWeight: FontWeight.normal),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.check_circle, color: Colors.green),
                    title: textSize16(
                        text: "Skin Cancer Specialist Certification",
                        fontWeight: FontWeight.normal),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.check_circle, color: Colors.green),
                    title: textSize16(
                        text: "Advanced Training in Cosmetic Procedures",
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Degrees Section
              textSize18(text: "Degrees", color: AppColors.textSeconderyColor),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.school, color: Colors.blue),
                    title: textSize16(
                        text: "MBBS - King Edward Medical University",
                        fontWeight: FontWeight.normal),
                  ),
                  ListTile(
                    leading: const Icon(Icons.school, color: Colors.blue),
                    title: textSize16(
                        text: "FCPS in Dermatology",
                        fontWeight: FontWeight.normal),
                  ),
                  ListTile(
                    leading: const Icon(Icons.school, color: Colors.blue),
                    title: textSize16(
                        text: "Diploma in Skin Cancer Surgery",
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              textSize18(
                  text: "Contact Details", color: AppColors.textSeconderyColor),

              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.teal),
                  const SizedBox(width: 10),
                  textSize16(text: "+123 456 7890"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.email, color: Colors.teal),
                  const SizedBox(width: 10),
                  textSize16(text: "$docName@gmail.com"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.teal),
                  const SizedBox(width: 10),
                  textSize16(text: "Lahore Punjab, Pakistan"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
