import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:albums_service/dto/photo/photo_dto.dart';

part 'photo.freezed.dart';

part 'photo.g.dart';

@freezed
abstract class Photo with _$Photo {
  factory Photo({
    @required int albumId,
    @required int id,
    @required String title,
    @required String url,
    @required String thumbnailUrl,
  }) = _Photo;

  const Photo._();

  factory Photo.fromPhotoDTO(PhotoDTO dto) => Photo(
        albumId: dto.albumId,
        id: dto.id,
        thumbnailUrl: dto.thumbnailUrl,
        title: dto.title,
        url: dto.url,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  PhotoDTO toPhotoDTO() => PhotoDTO(
        albumId: albumId,
        id: id,
        title: title,
        url: url,
        thumbnailUrl: thumbnailUrl,
      );
}
