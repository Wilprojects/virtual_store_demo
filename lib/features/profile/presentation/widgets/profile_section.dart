import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store_demo/common/widgets/buttons/primary_button.dart';
import 'package:virtual_store_demo/common/widgets/screens/loading_screen.dart';
import 'package:virtual_store_demo/features/auth/presentation/screens/login_screen.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Correo no disponible';

    if (isLoading) {
      return const LoadingScreen();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 24),

          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: AppColors.neutralColor.withValues(alpha: 0.30),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              size: 70,
              color: AppColors.secondaryColor,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Mi Perfil',
            style: AppTextStyles.titleTextStyle,
          ),

          const SizedBox(height: 32),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.neutralColor.withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: AppColors.secondaryColor,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correo',
                        style: AppTextStyles.descriptionTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        email,
                        style: AppTextStyles.descriptionTextStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          PrimaryButton(
            text: 'CERRAR SESIÓN',
            onTap: () {
              logoutUser();
            },
          ),
        ],
      ),
    );
  }

  Future<void> logoutUser() async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
          (route) => false,
    );
  }
}