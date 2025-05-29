import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:album/features/albums/domain/entities/album.dart';
import 'package:album/features/albums/domain/entities/photo.dart';

/// A [Converter] that encodes and decodes JSON objects.
final JsonToTypeConverter jsonToTypeConverter = JsonToTypeConverter({
  Album: (jsonData) => Album.fromJson(
        jsonData as Map<String, dynamic>,
      ),
  Photo: (jsonData) => Photo.fromJson(
        jsonData as Map<String, dynamic>,
      ),
});

/// A [Converter] that encodes and decodes JSON objects.
/// This converter is added by default to the [ChopperClient].
/// It uses the dart:convert [jsonDecode] and [jsonEncode].
/// You can override the default [jsonDecode] and [jsonEncode] by
/// passing your own to the constructor.
class JsonToTypeConverter extends JsonConverter {
  /// [typeToJsonFactoryMap] is a map which is used to store the
  const JsonToTypeConverter(this.typeToJsonFactoryMap);

  /// [typeToJsonFactoryMap] is a map which is used to store the
  final Map<Type, Function> typeToJsonFactoryMap;

  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    /// [encodeJson] is a method which is used to encode the request body.
    return encodeJson(req);
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(
        response.body as String,
        typeToJsonFactoryMap[InnerType]!,
      ),
    );
  }

  /// [fromJsonData] is a method which is used to convert the json
  /// data to the
  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    final dynamic jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap
          .map((item) => jsonParser(item as Map<String, dynamic>) as InnerType)
          .toList() as T;
    }

    /// [jsonParser] is a method which is used to parse the json data.
    return jsonParser(jsonMap) as T;
  }

  @override
  Response convertError<BodyType, InnerType>(Response response) {
    return response.copyWith<BodyType>(
      body: fromJsonData<BodyType, InnerType>(
        response.body as String,
        typeToJsonFactoryMap[InnerType]!,
      ),
    );
  }

  /// [encodeJson] is a method which is used to encode the request body.
  /// This method is used to encode the request body.
  @override
  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }

    return request;
  }
} 