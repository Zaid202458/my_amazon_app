import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/providers/user_provider.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userProvider = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 114, 226, 221),
          Color.fromARGB(255, 162, 236, 233),
        ]),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: l10n.greeting,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black87,
                        ),
                    children: [
                      TextSpan(
                        text: userProvider.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.black87.withOpacity(0.8),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${l10n.deliveryTo} ${userProvider.address}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black87.withOpacity(0.8),
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => Scaffold.of(context).openEndDrawer(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.1),
                child: Text(
                  userProvider.name[0].toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
