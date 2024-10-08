import 'form_field_model.dart';
import 'model_constants.dart';

class FieldAnswer extends FormFieldModel {
  final String answer;

  FieldAnswer({
    required super.id,
    required super.label,
    required super.type,
    required super.index,
    required super.required,
    required this.answer,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'answer': answer,
    };
  }

  factory FieldAnswer.fromMap(Map<String, dynamic> map) {
    return FieldAnswer(
      id: map[ModelConsts.id],
      label: map[ModelConsts.label],
      type: FieldType.values[map[ModelConsts.type]],
      required: map[ModelConsts.isRequired],
      index: map[ModelConsts.index],
      answer: map[ModelConsts.answer],
    );
  }

  factory FieldAnswer.fromField(FormFieldModel field, String answer) {
    return FieldAnswer(
      id: field.id,
      label: field.label,
      type: field.type,
      index: field.index,
      required: field.required,
      answer: answer,
    );
  }

  FieldAnswer copyWith({String? answer}) {
    return FieldAnswer(
      id: id,
      label: label,
      type: type,
      index: index,
      required: required,
      answer: answer ?? this.answer,
    );
  }
}
