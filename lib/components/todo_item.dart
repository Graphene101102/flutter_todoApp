import 'package:flutter/material.dart';
import '../resources/app_color.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    this.onTap,
    this.onDeleted,
    required this.text,
    required this.status,
    this.restore,
  });

  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final VoidCallback? restore;
  final String text;
  final int status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.6)
            .copyWith(left: 14.0, right: 8.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              offset: Offset(0.0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              () {
                if (status == 3) {
                  return null;
                } else if (status == 2) {
                  return Icons.check_box_outlined;
                } else {
                  return Icons.check_box_outline_blank;
                }
              }(),
              size: 16.8,
              color: AppColor.blue,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.6, right: 4.6),
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: status == 2
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            InkWell(
              onTap: onDeleted,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: CircleAvatar(
                  backgroundColor: AppColor.orange,
                  radius: 12.0,
                  child: Icon(Icons.delete, size: 14.0, color: AppColor.white),
                ),
              ),
            ),
            Visibility(
              visible: status == 3,
              child: InkWell(
                onTap: restore,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: CircleAvatar(
                    backgroundColor: AppColor.orange,
                    radius: 12.0,
                    child:
                        Icon(Icons.restore, size: 14.0, color: AppColor.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
