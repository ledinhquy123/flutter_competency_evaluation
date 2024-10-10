import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/domain/entities/input_entity.dart';
import 'package:task4/presentation/complete/blocs/send_data_cubit.dart';
import 'package:task4/presentation/complete/blocs/send_data_state.dart';
import 'package:task4/presentation/complete/pages/complete_page.dart';
import 'package:task4/presentation/home/blocs/execute/execute_cubit.dart';
import 'package:task4/presentation/home/blocs/execute/execute_state.dart';
import 'package:task4/presentation/home/blocs/get_data/get_data_cubit.dart';
import 'package:task4/presentation/home/blocs/get_data/get_data_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _title(),
          const SizedBox(
            height: 30,
          ),
          _getDataBtn(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Task 4",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _getDataBtn() {
    return BlocProvider(
      create: (context) => GetDataCubit(),
      child: BlocBuilder<GetDataCubit, GetDataState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state is GetDataLoaded
                    ? _executeBtn(inputEntity: state.inputEntity)
                    : GestureDetector(
                        onTap: state is GetDataLoading
                            ? null
                            : () {
                                context.read<GetDataCubit>().getData();
                              },
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                          ),
                          child: state is GetDataLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  textAlign: TextAlign.center,
                                  'Lấy dữ liệu input',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                        )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _executeBtn({required InputEntity inputEntity}) {
    return BlocProvider(
      create: (context) => ExecuteCubit(),
      child: BlocBuilder<ExecuteCubit, ExecuteState>(
        builder: (context, state) {
          return state is ExecuteLoaded
              ? _sendDataBtn(data: state.data)
              : GestureDetector(
                  onTap: state is ExecuteLoading
                      ? null
                      : () {
                          context.read<ExecuteCubit>().execute(inputEntity);
                        },
                  child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: state is ExecuteLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              textAlign: TextAlign.center,
                              'Giải',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )));
        },
      ),
    );
  }

  Widget _sendDataBtn({required List<Map<String, int>> data}) {
    return BlocProvider(
      create: (context) => SendDataCubit(),
      child: BlocBuilder<SendDataCubit, SendDataState>(
        builder: (context, state) {
          return BlocListener<SendDataCubit, SendDataState>(
            listener: (context, state) {
              if (state is SendDataLoaded) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompletePage()));
              }
            },
            child: GestureDetector(
                onTap: state is SendDataLoading
                    ? null
                    : () {
                        context.read<SendDataCubit>().send(data: data);
                      },
                child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: state is SendDataLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            textAlign: TextAlign.center,
                            'Gửi kết quả',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ))),
          );
        },
      ),
    );
  }
}
