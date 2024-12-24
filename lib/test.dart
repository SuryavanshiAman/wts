import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Open WhatsApp Button'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _openWhatsApp,
            child: Text('Send Hello Message on WhatsApp'),
          ),
        ),
      ),
    );
  }

  void _openWhatsApp() async {
    // Replace <message> with the message you want to send
    String message = "Hello!";

    // Encode message to handle special characters properly
    String encodedMessage = Uri.encodeComponent(message);

    // Construct the WhatsApp URL with message
    String url = "https://wa.me/?text=$encodedMessage";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
///
// import 'package:flutter/material.dart';
// import 'package:in_app_update/in_app_update.dart';
//
// class UpdateCheckScreen extends StatefulWidget {
//   @override
//   _UpdateCheckScreenState createState() => _UpdateCheckScreenState();
// }
//
// class _UpdateCheckScreenState extends State<UpdateCheckScreen> {
//   AppUpdateInfo? _updateInfo;
//   bool _isUpdateAvailable = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkForUpdate();
//   }
//
//   // Check for updates
//   Future<void> _checkForUpdate() async {
//     try {
//       final updateInfo = await InAppUpdate.checkForUpdate();
//       setState(() {
//         _updateInfo = updateInfo;
//         _isUpdateAvailable = updateInfo.updateAvailability == UpdateAvailability.updateAvailable;
//       });
//
//       if (_isUpdateAvailable) {
//         _showUpdateDialog();
//       }
//     } catch (e) {
//       debugPrint("Failed to check for updates: $e");
//     }
//   }
//
//   // Show Update Dialog
//   void _showUpdateDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Update Available'),
//           content: Text('A new version of the app is available. Please update to the latest version.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Later'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _startFlexibleUpdate();
//               },
//               child: Text('Update Now'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Start the update process
//   Future<void> _startFlexibleUpdate() async {
//     try {
//       Navigator.pop(context); // Close the dialog
//       await InAppUpdate.performImmediateUpdate();
//     } catch (e) {
//       debugPrint("Failed to perform update: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Checker'),
//       ),
//       body: Center(
//         child: Text(
//           _isUpdateAvailable
//               ? 'A new update is available!'
//               : 'Your app is up to date.',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: UpdateCheckScreen(),
//   ));
// }
