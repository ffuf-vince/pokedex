import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_model.freezed.dart';
part 'about_model.g.dart';

@freezed
class About with _$About {
  factory About({String? name, String? value}) = _About;

  factory About.fromJson(Map<String, dynamic> json) => _$AboutFromJson(json);
}
