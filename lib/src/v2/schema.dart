import 'package:codable_plus/cast.dart' as cast;
import 'package:codable_plus/codable.dart';
import 'package:open_api_plus/src/v2/property.dart';

/// Represents a schema object in the OpenAPI specification.
class APISchemaObject extends APIProperty {
  APISchemaObject();

  String? title;
  String? description;
  String? example;
  List<String?>? required = [];
  bool readOnly = false;

  /// Valid when type == array
  APISchemaObject? items;

  /// Valid when type == null
  Map<String, APISchemaObject?>? properties;

  /// Valid when type == object
  APISchemaObject? additionalProperties;

  @override
  APISchemaRepresentation get representation {
    if (properties != null) {
      return APISchemaRepresentation.structure;
    }

    return super.representation;
  }

  @override
  Map<String, cast.Cast> get castMap => {"required": cast.List(cast.String)};

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    title = object.decode("title");
    description = object.decode("description");
    required = object.decode("required");
    example = object.decode("example");
    readOnly = object.decode("readOnly") ?? false;

    items = object.decodeObject("items", () => APISchemaObject());
    additionalProperties =
        object.decodeObject("additionalProperties", () => APISchemaObject());
    properties = object.decodeObjectMap("properties", () => APISchemaObject());
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);

    object.encode("title", title);
    object.encode("description", description);
    object.encode("required", required);
    object.encode("example", example);
    object.encode("readOnly", readOnly);

    object.encodeObject("items", items);
    object.encodeObject("additionalProperties", additionalProperties);
    object.encodeObjectMap("properties", properties);
  }
}
