import 'package:equatable/equatable.dart';

class PlaylistModelPlaylistItemEntity extends Equatable {

  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;

  const PlaylistModelPlaylistItemEntity({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl];
}