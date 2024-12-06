import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_amazon_app/shared/providers/cart_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem item;

  const CartItemCard({
    super.key,
    required this.productId,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: Image.network(
            item.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
          title: Text(item.name),
          subtitle: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                tooltip: l10n.removeItem,
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .removeSingleItem(productId);
                },
              ),
              Text('${item.quantity}'),
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: l10n.addItem,
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .addItem(productId, item.name, item.price, item.image);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: l10n.deleteItem,
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .removeItem(productId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
