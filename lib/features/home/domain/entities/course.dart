import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String id;
  final String title;
  final String imageUrl;

  const Course({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, imageUrl];
}
