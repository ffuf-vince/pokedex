import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistic_model.freezed.dart';
part 'statistic_model.g.dart';

@freezed
class Statistic with _$Statistic {
  factory Statistic({String? name, int? value}) = _Statistic;

  factory Statistic.fromJson(Map<String, dynamic> json) => _$StatisticFromJson(json);
}
