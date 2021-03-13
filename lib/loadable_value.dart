import 'package:freezed_annotation/freezed_annotation.dart';

part 'loadable_value.freezed.dart';

@freezed
class LoadableValue<T> with _$LoadableValue<T> {
  const factory LoadableValue.loading() = LoadingValue;

  const factory LoadableValue.loaded(T value) = LoadedValue;

  const factory LoadableValue.error(String errorMessage) = ErrorValue;
}
