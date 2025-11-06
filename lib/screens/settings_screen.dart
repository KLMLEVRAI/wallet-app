import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/wallet_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F23),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Settings',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    _buildSettingsSection(
                      title: 'Wallet',
                      children: [
                        _buildSettingsItem(
                          icon: Icons.account_balance_wallet,
                          title: 'Wallet Address',
                          subtitle: 'View and copy your wallet address',
                          onTap: () {
                            final walletProvider = context.read<WalletProvider>();
                            final address = walletProvider.wallet?.address ?? 'No wallet';
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFF1A1A2E),
                                title: Text(
                                  'Wallet Address',
                                  style: GoogleFonts.inter(color: Colors.white),
                                ),
                                content: SelectableText(
                                  address,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Close',
                                      style: GoogleFonts.inter(color: const Color(0xFF6366F1)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        _buildSettingsItem(
                          icon: Icons.refresh,
                          title: 'Clear Wallet',
                          subtitle: 'Remove current wallet from device',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFF1A1A2E),
                                title: Text(
                                  'Clear Wallet',
                                  style: GoogleFonts.inter(color: Colors.white),
                                ),
                                content: Text(
                                  'This will remove your wallet from this device. Make sure you have backed up your private key.',
                                  style: GoogleFonts.inter(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.inter(color: Colors.white70),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<WalletProvider>().clearWallet();
                                      Navigator.pop(context);
                                      Navigator.pop(context); // Go back to home
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Wallet cleared'),
                                          backgroundColor: Color(0xFF10B981),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Clear',
                                      style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSettingsSection(
                      title: 'Security',
                      children: [
                        _buildSettingsItem(
                          icon: Icons.security,
                          title: 'Backup Private Key',
                          subtitle: 'Export your private key for backup',
                          onTap: () {
                            final walletProvider = context.read<WalletProvider>();
                            final privateKey = walletProvider.wallet?.privateKey ?? 'No wallet';
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFF1A1A2E),
                                title: Text(
                                  'Private Key',
                                  style: GoogleFonts.inter(color: Colors.white),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '⚠️ Never share this with anyone!',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFFEF4444),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SelectableText(
                                      privateKey,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontFamily: 'monospace',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Close',
                                      style: GoogleFonts.inter(color: const Color(0xFF6366F1)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSettingsSection(
                      title: 'About',
                      children: [
                        _buildSettingsItem(
                          icon: Icons.info,
                          title: 'Version',
                          subtitle: '1.0.0',
                          onTap: null,
                        ),
                        _buildSettingsItem(
                          icon: Icons.code,
                          title: 'Source Code',
                          subtitle: 'View on GitHub',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('GitHub link not configured'),
                                backgroundColor: Color(0xFF6366F1),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6366F1),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.inter(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
      trailing: onTap != null
          ? const Icon(
              Icons.chevron_right,
              color: Colors.white38,
            )
          : null,
      onTap: onTap,
    );
  }
}