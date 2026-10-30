import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  final bool register = true;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _password = TextEditingController();
  bool _hidden = true;
  bool _confirmHidden = true;
  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_form.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Thông tin hợp lệ. Chức năng xác thực sẽ được kết nối API sau.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final register = widget.register;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _form,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      register ? 'Đăng ký tài khoản' : 'Chào mừng trở lại!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      register
                          ? 'Điền thông tin để đăng kí'
                          : 'Đăng nhập để tiếp tục.',
                      style: const TextStyle(
                        color: Color(0xFF68796F),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 36),
                    if (register) ...[
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Họ và tên',
                        ),
                        validator: (value) => (value ?? '').trim().length < 2
                            ? 'Vui lòng nhập họ và tên'
                            : null,
                      ),
                      const SizedBox(height: 18),
                    ],
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                      ),
                      validator: (value) =>
                          RegExp(
                            r'^(0[35789]\d{8}|\+84[35789]\d{8})$',
                          ).hasMatch(
                            (value ?? '').replaceAll(RegExp(r'\s'), ''),
                          )
                          ? null
                          : 'Số điện thoại Việt Nam chưa hợp lệ',
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _password,
                      obscureText: _hidden,
                      enableSuggestions: false,
                      autocorrect: false,
                      textInputAction: register
                          ? TextInputAction.next
                          : TextInputAction.done,
                      onFieldSubmitted: register ? null : (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        helperText: register ? 'Sử dụng ít nhất 8 ký tự' : null,
                        suffixIcon: IconButton(
                          tooltip: _hidden ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
                          onPressed: () => setState(() => _hidden = !_hidden),
                          icon: Icon(
                            _hidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                      validator: (value) => (value ?? '').isEmpty
                          ? 'Vui lòng nhập mật khẩu'
                          : register && value!.length < 8
                          ? 'Mật khẩu cần ít nhất 8 ký tự'
                          : null,
                    ),
                    if (register) ...[
                      const SizedBox(height: 18),
                      TextFormField(
                        obscureText: _confirmHidden,
                        enableSuggestions: false,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu',
                          suffixIcon: IconButton(
                            tooltip: _confirmHidden
                                ? 'Hiện mật khẩu xác nhận'
                                : 'Ẩn mật khẩu xác nhận',
                            onPressed: () => setState(
                              () => _confirmHidden = !_confirmHidden,
                            ),
                            icon: Icon(
                              _confirmHidden
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        validator: (value) => (value ?? '').isEmpty
                            ? 'Vui lòng xác nhận mật khẩu'
                            : value != _password.text
                            ? 'Mật khẩu xác nhận chưa khớp'
                            : null,
                      ),
                    ],
                    const SizedBox(height: 24),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                        register ? 'Tạo tài khoản' : 'Đăng nhập',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          register
                              ? 'Bạn đã có tài khoản?'
                              : 'Bạn chưa có tài khoản?',
                        ),
                        TextButton(
                          onPressed: () {
                            if (register) {
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            }
                          },
                          child: Text(
                            register ? 'Đăng nhập ngay' : 'Đăng ký ngay',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
