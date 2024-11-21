import 'package:concentric_transition/concentric_transition.dart';
import 'package:edu/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class Onboardscreens extends StatefulWidget {
  const Onboardscreens({super.key});

  @override
  State<Onboardscreens> createState() => _OnboardscreensState();
}

class _OnboardscreensState extends State<Onboardscreens> {

  List<Map<String, String>> pages = [
    {
      'image':
      'https://ouch-cdn2.icons8.com/qLwkLBjIt5rjnTjksT-reemr3Rc7m8fsCWCy9VwmyKY/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMjcv/MjJmNTg3NWYtNTA5/Yy00ZjhmLTg0Njgt/YjUxMjkxOWExMGI4/LnBuZw.png',
    },
    {
      'image':
      'https://ouch-cdn2.icons8.com/aOecyQToTzM0aHNXxIeeu5hIHzPK6Nf6xpXAdEJtEgY/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMjA2/LzBhNzFhMzg1LTQ5/YmYtNDUyNS05OWNm/LTNkOWQ1MmYxYWZh/NC5wbmc.png'
    },
    {
      'image':
      'https://ouch-cdn2.icons8.com/df0oDP28LtBPZxjK2SeUi36rz3yCwv9yVfB6S-OFT5M/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvOTE0/LzgzNjk5MTdkLWE0/N2ItNGE2NC05OGI2/LTdlMmRkYjNjMTE1/OS5wbmc.png'
    }
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
       body: ConcentricPageView(
           radius: 20,
           verticalPosition: 0.85,
           itemCount: pages.length,
           nextButtonBuilder: (context) => Padding(padding: const EdgeInsets.only(left: 3),
           child: IconButton(
             icon: Icon(
               Icons.navigate_next,
               size: screenWidth * 0.08,
             ), onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
           },

           ),
           ),
           itemBuilder: (index){
           return Container(
             width: 300,
             height: 300,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Image.network(pages[index]['image']!,
                 ),
               ],

             ),

           );
           },
           colors: const [Colors.white, Colors.greenAccent, Colors.teal]),
    );
  }
}
