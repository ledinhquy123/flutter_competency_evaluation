import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:task2/common/constants/app_constant.dart';
import 'package:task2/common/data/fake_data.dart';
import 'package:task2/common/heplers/no_leading_zero_formatter.dart';
import 'package:task2/common/heplers/show_loading_dialog.dart';
import 'package:task2/common/heplers/show_snackbar.dart';
import 'package:task2/common/widgets/basic_app_bar/basic_app_bar.dart';
import 'package:task2/common/widgets/basic_date_field/basic_date_field.dart';
import 'package:task2/common/widgets/basic_dropdown_field/basic_dropdown_field.dart';
import 'package:task2/common/widgets/basic_text_field/basic_text_field.dart';
import 'package:task2/data/models/form_req.dart';
import 'package:task2/presentation/form/blocs/update_button/update_button_cubit.dart';
import 'package:task2/presentation/form/blocs/update_button/update_button_state.dart';

class FormPage extends StatelessWidget {
  FormPage({super.key});

  final TextEditingController _dateCon = TextEditingController();
  final TextEditingController _pumpCon = TextEditingController();
  final TextEditingController _quantityCon = TextEditingController();
  final TextEditingController _revenueCon = TextEditingController();
  final TextEditingController _unitPriceCon = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.only(top: screenHeight * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _appbar(),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _datetimeField(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      _quantityField(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      _petrolPumpFiled(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      _revenueField(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      _unitPriceField()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appbar() {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => UpdateButtonCubit(),
        child: BlocBuilder<UpdateButtonCubit, UpdateButtonState>(
          builder: (context, state) {
            return BlocListener<UpdateButtonCubit, UpdateButtonState>(
              listener: (context, state) {
                if (state is UpdateButtonLoading) {
                  showLoadingDialog(context);
                } else if (state is UpdateButtonLoaded) {
                  Navigator.pop(context);
                  showSnackbar(
                      context: context,
                      content: state.successMess,
                      bgColor: Colors.green);
                } else if (state is UpdateButtonFailure) {
                  Navigator.pop(context);
                  showSnackbar(context: context, content: state.errorMess);
                }
              },
              child: BasicAppBar(onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.read<UpdateButtonCubit>().excute(
                      formReq: FormReq(
                          dateTime: DateTime.parse(_dateCon.text),
                          quantity: _quantityCon.text == ''
                              ? null
                              : double.parse(_quantityCon.text),
                          pump: _pumpCon.text,
                          revenue: _revenueCon.text == ''
                              ? null
                              : double.parse(_revenueCon.text),
                          unitPrice: _unitPriceCon.text == ''
                              ? null
                              : double.parse(_unitPriceCon.text)));
                }
              }),
            );
          },
        ),
      );
    });
  }

  Widget _datetimeField() {
    return BasicDateField(
      title: "Thời gian",
      controller: _dateCon,
      hintText: "Chọn thời gian",
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Không được bỏ trống"),
        FormBuilderValidators.dateTime(
            errorText: "Vui lòng chọn ngày giờ hợp lệ"),
      ]),
    );
  }

  Widget _quantityField() {
    return BasicTextField(
      title: "Số lượng",
      controller: _quantityCon,
      hintText: "Nhập số lượng",
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      onPress: () {},
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        NoLeadingZeroFormatter(),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Không được bỏ trống"),
        FormBuilderValidators.min(1, errorText: "Giá trị phải lơn hơn 0"),
        FormBuilderValidators.numeric(errorText: "Vui lòng nhập số hợp lệ")
      ]),
    );
  }

  Widget _petrolPumpFiled() {
    return BasicDropdownField(
        controller: _pumpCon,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: "Không được bỏ trống"),
        ]),
        hintText: "Chọn trụ",
        items: FakeData.pumps
            .map((el) => DropdownMenuItem(
                alignment: Alignment.centerLeft, value: el, child: Text(el)))
            .toList(),
        title: "Trụ");
  }

  Widget _revenueField() {
    return BasicTextField(
        title: "Doanh thu",
        controller: _revenueCon,
        hintText: "Nhập doanh thu",
        textInputType: const TextInputType.numberWithOptions(decimal: true),
        onPress: () {},
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
          NoLeadingZeroFormatter(),
        ],
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: "Không được bỏ trống"),
          FormBuilderValidators.min(1, errorText: "Giá trị phải lơn hơn 0"),
          FormBuilderValidators.numeric(errorText: "Vui lòng nhập số hợp lệ")
        ]));
  }

  Widget _unitPriceField() {
    return BasicTextField(
      title: "Đơn giá",
      controller: _unitPriceCon,
      hintText: "Nhập đơn giá",
      textInputType: const TextInputType.numberWithOptions(decimal: true),
      onPress: () {},
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        NoLeadingZeroFormatter(),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Không được bỏ trống"),
        FormBuilderValidators.min(1, errorText: "Giá trị phải lơn hơn 0"),
        FormBuilderValidators.numeric(errorText: "Vui lòng nhập số hợp lệ")
      ]),
    );
  }
}
