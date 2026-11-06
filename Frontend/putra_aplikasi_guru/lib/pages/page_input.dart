import 'package:flutter/material.dart';
import 'package:putra_aplikasi_guru/pages/page_dashboard.dart';

class PageInput extends StatelessWidget{
  const PageInput({super.key});
      @override
  Widget build (BuildContext context) {
    return Scaffold(
 backgroundColor: Colors.green,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(100),
          child: Column(
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 50,
              ),

const Text('Input Data', style:TextStyle(fontSize: 50)),


              TextField(
                decoration: InputDecoration(
                    labelText: 'Nama',
                        border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                    labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),

                ),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Simpan Data')),

                  const SizedBox(width: 50),

                  ElevatedButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Dashboard()));
                  },
                      child: const Text('Batal')),
                ],
              ),


              
            ],
          ),
        ),
      ),
    );
      }
}