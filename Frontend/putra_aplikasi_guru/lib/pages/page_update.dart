import 'package:flutter/material.dart';

class PageUpdate extends StatelessWidget{
  const PageUpdate({super.key});
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(100),
          child: Column(
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 50,
              ),

              const Text('Update Data', style:TextStyle(fontSize: 50)),


              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),

                ),
              ),

              const SizedBox(height: 20),


              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    height: 45,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Update Data'),
                  ),
                  ),

                  const SizedBox(width: 20),

                  SizedBox(
                    width: 130,
                  height: 45,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Batal'),
                  ),
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}