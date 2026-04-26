import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String title;
  final String iconPath;

  const Category({
    required this.id,
    required this.title,
    required this.iconPath,
  });

  @override
  List<Object?> get props => [id, title, iconPath];
}
