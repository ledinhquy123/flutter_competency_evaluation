import 'package:flutter/material.dart';
import 'package:task2/presentation/form/pages/form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _taskTitle(),
            const SizedBox(
              height: 10,
            ),
            _taskDes(),
            const SizedBox(
              height: 20,
            ),
            _continueBtn(context)
          ],
        ),
      ),
    );
  }

  Widget _taskTitle() {
    return const Text('Task 2',
        style: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold));
  }

  Widget _taskDes() {
    return const Text('Nhập giao dịch cho cửa hàng bán xăng',
        style: TextStyle(
            color: Colors.black45, fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget _continueBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormPage()));
      },
      child: Container(
          width: 150,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
          child: const Text(
            textAlign: TextAlign.center,
            'Bắt đầu',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
