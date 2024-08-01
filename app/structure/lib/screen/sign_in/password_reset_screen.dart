import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/loading_screen.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/config/palette.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_input_field.dart';
import 'package:structure/viewModel/sign_in/password_reset_view_model.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    PasswordResetViewModel passwordResetViewModel =
        context.watch<PasswordResetViewModel>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: '비밀번호 재설정',
          backButton: true,
          closeButton: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: passwordResetViewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24.h),

                    // 이메일
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Text('이메일', style: Palette.h5SemiBoldSecondary),
                    ),
                    SizedBox(height: 16.h),

                    // 이메일 입력 input field
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      child: MainInputField(
                        width: double.infinity,
                        formKey: passwordResetViewModel.formKey,
                        controller: passwordResetViewModel.email,
                        validateFunc: (value) =>
                            passwordResetViewModel.emailValidate(value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 재설정 버튼
            Container(
              margin: EdgeInsets.fromLTRB(40.w, 0, 40.w, 40.h),
              alignment: Alignment.bottomCenter,
              child: MainButton(
                width: double.infinity,
                height: 96.h,
                onPressed: passwordResetViewModel.isValid()
                    ? () async =>
                        passwordResetViewModel.sendResetPassword(context)
                    : null,
                text: '비밀번호 재설정',
              ),
            ),
            passwordResetViewModel.isLoading
                ? const Center(child: LoadingScreen())
                : Container(),
          ],
        ),
      ),
    );
  }
}
