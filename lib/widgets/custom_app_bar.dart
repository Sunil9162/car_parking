import 'package:car_parking/providers/auth_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String docId = '';

  @override
  void initState() {
    super.initState();
    getDocId();
  }

  Future<void> getDocId() async {
    final prefs = await SharedPreferences.getInstance();
    var number = prefs.getString('number');
    FirebaseFirestore.instance
        .collection("Users")
        .where("number", isEqualTo: number)
        .get()
        .then((value) {
      setState(() {
        docId = value.docs[0].id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.5),
          ),
          child: const Icon(Icons.person),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, ',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              docId == ""
                  ? const Text("")
                  : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(docId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData
                              ? snapshot.data!.data()!['name']
                              : '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Provider.of<AuthProvider>(context, listen: false).signOut(context);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.5),
            ),
            child: const Icon(Icons.logout_rounded),
          ),
        ),
      ],
    );
  }
}
