import 'client.dart';
import 'package:flutter/material.dart';
import 'button_mode.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  Client client = Client('ipaddress', 1234);
  late String status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = "connecting";
    client.establish();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection setup'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue, // Set background color
                foregroundColor: Colors.white, // Set text color on press
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust for desired roundness
                ),
              ),
              onPressed: () async {
                //maybe need await
                //print('Connect clicked');
                await client.connect();
                setState(() {
                  status = client.status_give();
                });
              },
              child: const Text(
                "Connect",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Status: $status",
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20.0),

            LoadingAnimationWidget.threeArchedCircle(
              color: Colors.blue,
              size: 200,
            ),
            const SizedBox(height: 20.0),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // Set background color
                foregroundColor: Colors.white, // Set text color on press
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust for desired roundness
                ),
              ),
              onPressed: () {
                print('Next clicked');
                if (status == "connected") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: "Button Mode")));
                }
                setState(() {
                  status = "Not connected";
                });
                //sendMessage("Down");
              },
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
