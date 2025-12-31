import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slovingo/models/user.dart' as local_user;
import 'package:slovingo/services/auth_service.dart';
import 'package:slovingo/services/firestore_user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (!_isLogin && name.isEmpty) {
      setState(() => _error = 'Vnesite ime.');
      return;
    }
    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Vnesite e-pošto in geslo.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final auth = AuthService();
    final fsUser = FirestoreUserService();
    try {
      if (_isLogin) {
        await auth.signIn(email, password);
      } else {
        final cred = await auth.register(email, password);
        // Update display name for convenience.
        await cred.user?.updateDisplayName(name);
        final uid = cred.user?.uid;
        if (uid != null) {
          final now = DateTime.now();
          await fsUser.upsertUser(local_user.User(
            id: uid,
            name: name,
            email: email,
            currentLevel: 1,
            totalPoints: 0,
            streak: 0,
            lastActive: now,
            createdAt: now,
            updatedAt: now,
          ));
        }
      }
      if (!mounted) return;
      context.go('/');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isLogin ? 'Prijava' : 'Registracija',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-pošta',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Geslo',
                ),
              ),
              if (!_isLogin) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ime',
                  ),
                ),
              ],
              const SizedBox(height: 16),
              if (_error != null)
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(_isLogin ? 'Prijava' : 'Registracija'),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    _error = null;
                  });
                },
                child: Text(_isLogin
                    ? 'Nimate računa? Registrirajte se'
                    : 'Že imate račun? Prijava'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
