import 'package:flutter/material.dart';

// Bottom navigation personalizzata
class BottomBar extends StatelessWidget {
  const BottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: SafeArea(
        top: false,
        child: Row(
          children: const [
            _NavItem(label: 'Home'),
            _NavItem(label: 'Attività', selected: true),
            _NavItem(label: 'Impostazioni'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool selected;

  const _NavItem({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          //color: selected ? AttivitaPage.greyBox : Colors.transparent,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.stars_outlined,
              size: 22,
              //color: selected ? AttivitaPage.textDark : Colors.black54,
              color: Colors.black54,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                //color: selected ? AttivitaPage.textDark : AttivitaPage.textGrey,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}