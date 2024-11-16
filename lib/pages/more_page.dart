import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Dev')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.face,
              size: 96,
            ),
            const SizedBox(height: 16),
            const Text(
              'Irwan Phan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Play, Code, Cuan Enthusiast',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                onTap: () => _launchURL('https://linkedin.com/in/irwanphan'),
                child: Icon(
                  TablerIcons.brand_linkedin,
                  color: Colors.blue,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _launchURL('https://instagram.com/irwanphan'),
                child: Icon(
                  TablerIcons.brand_instagram,
                  color: Colors.purple,
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _launchURL('https://irwanphan.github.io'),
                child: Icon(
                  TablerIcons.world_www,
                  color: Colors.green,
                  size: 36,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
