import 'dart:convert';
import 'dart:io';

void main() async {
  stdout.write('Enter JSON file path (e.g. assets/user.json): ');
  final path = stdin.readLineSync();

  if (path == null || path.isEmpty) {
    print('ERROR:  Invalid path.');
    return;
  }

  final file = File(path);
  if (!await file.exists()) {
    print('ERROR:  File not found.');
    return;
  }

  stdout.write('Enter root class name (e.g. User): ');
  final rootClass = stdin.readLineSync();

  if (rootClass == null || rootClass.isEmpty) {
    print('ERROR:  Invalid class name.');
    return;
  }

  final jsonMap = json.decode(await file.readAsString());
  if (jsonMap is! Map<String, dynamic>) {
    print('ERROR:  JSON must be a single object at the root.');
    return;
  }

  final generator = ModelEntityGenerator();
  generator.generate(rootClass, jsonMap);

  print('√ Generation complete.');
}

class ModelEntityGenerator {
  final Map<String, String> models = {};
  final Map<String, String> entities = {};

  void generate(String className, Map<String, dynamic> json) {
    _generateClass(className, json);
    _writeFiles();
  }

  void _generateClass(String className, Map<String, dynamic> json) {
    final modelName = '${className}Model';
    final entityName = '${className}Entity';

    final fields = <String, String>{};
    final fromJson = <String>[];
    final toJson = <String>[];
    final toEntity = <String>[];
    final props = <String>[];
    final constructor = <String>[];

    for (var entry in json.entries) {
      final nameSnake = entry.key;
      final nameCamel = _snakeToCamel(nameSnake);
      final value = entry.value;
      // final inferredType = _inferType(nameSnake, value, className);
      final inferredType = _inferType(nameSnake, value, modelName);

      fields[nameCamel] = inferredType.type;
      props.add(nameCamel);
      constructor.add('    this.$nameCamel,');

      fromJson.add('      $nameCamel: ${(inferredType).fromJson},');
      toJson.add('        \'$nameSnake\': $nameCamel,');
      toEntity.add('      $nameCamel: $nameCamel,');

      // If nested, recurse
      if (inferredType.nestedClass != null && inferredType.nestedJson != null) {
        _generateClass(inferredType.nestedClass!, inferredType.nestedJson!);
      }
    }

//?additional import '../entities/${_toSnakeCase(entityName)}.dart';

    final modelContent = '''

class ${_snakeToUpperCamel(modelName)} {
${fields.entries.map((e) {
      final type = e.value;

      final isPrimitive = _isPrimitiveTypeOrList(type);

      final fieldName = _snakeToCamel(e.key);
      return '  final ${(isPrimitive ? type : '${_snakeToUpperCamel(type)}' 'Model')}? $fieldName;';
    }).join('\n')}


  const ${_snakeToUpperCamel(modelName)}({
${constructor.join('\n')}
  });

  factory ${_snakeToUpperCamel(modelName)}.fromJson(Map<String, dynamic> json) {
    return ${_snakeToUpperCamel(modelName)}(
${fromJson.join('\n')}
    );
  }

  Map<String, dynamic> toJson() => {
${toJson.join('\n')}
  };

  ${_snakeToUpperCamel(entityName)} toEntity() {
    return ${_snakeToUpperCamel(entityName)}(
${toEntity.join('\n')}
    );
  }
}
''';

    final entityContent = '''
import 'package:equatable/equatable.dart';

class ${_snakeToUpperCamel(entityName)} extends Equatable {

${fields.entries.map((e) {
      final type = e.value;

      final isPrimitive = _isPrimitiveTypeOrList(type);

      final fieldName = _snakeToCamel(e.key);
      return '  final ${(isPrimitive ? type : '${_snakeToUpperCamel(type)}' 'Entity')}? $fieldName;';
    }).join('\n')}

  const ${_snakeToUpperCamel(entityName)}({
${constructor.join('\n')}
  });

  @override
  List<Object?> get props => [${props.join(', ')}];
}
''';

    models[modelName] = modelContent.trim();
    entities[entityName] = entityContent.trim();
  }

  void _writeFiles() {
    final modelDir = Directory('lib/models');
    final entityDir = Directory('lib/entities');

    modelDir.createSync(recursive: true);
    entityDir.createSync(recursive: true);

    for (var entry in models.entries) {
      final fileName = '${_toSnakeCase(entry.key)}.dart';
      File('${modelDir.path}/$fileName').writeAsStringSync(entry.value);
      print('√ Model written: models/$fileName');
    }

    for (var entry in entities.entries) {
      final fileName = '${_toSnakeCase(entry.key)}.dart';
      File('${entityDir.path}/$fileName').writeAsStringSync(entry.value);
      print('√ Entity written: entities/$fileName');
    }
  }

  _TypeResult _inferType(String fieldName, dynamic value, String parentClass) {
    if (value == null) {
      return _TypeResult('String', fromJson: "json['$fieldName']");
    }

    if (value is int) {
      return _TypeResult('int', fromJson: "json['$fieldName']");
    }
    if (value is double) {
      return _TypeResult('double', fromJson: "json['$fieldName']");
    }
    if (value is bool) {
      return _TypeResult('bool', fromJson: "json['$fieldName']");
    }

    // Check for ISO date
    if (value is String && RegExp(r'^\d{4}-\d{2}-\d{2}').hasMatch(value)) {
      return _TypeResult('DateTime',
          fromJson: "DateTime.parse(json['$fieldName'])");
    }

    if (value is List) {
      if (value.isNotEmpty) {
        final first = value.first;
        if (first is Map<String, dynamic>) {
          final nested = _capitalize(fieldName);
          final className = '${_capitalize(parentClass)}${nested}Item';
          return _TypeResult('List<$className>',
              fromJson:
                  "(json['$fieldName'] as List).map((e) => $className.fromJson(e)).toList()",
              nestedClass: className,
              nestedJson: first);
        } else {
          final inner = _inferType(fieldName, first, parentClass);
          return _TypeResult('List<${inner.type}>',
              fromJson: "List<${inner.type}>.from(json['$fieldName'])");
        }
      } else {
        return _TypeResult('List<String>',
            fromJson: "List<String>.from(json['$fieldName'] ?? [])");
      }
    }

    if (value is Map<String, dynamic>) {
      final nested = _capitalize(fieldName);
      final className = '${_capitalize(parentClass)}$nested';
      return _TypeResult(className,
          fromJson:
              "${_snakeToUpperCamel(className)}Model.fromJson(json['$fieldName'])",
          nestedClass: className,
          nestedJson: value);
    }

    return _TypeResult('String', fromJson: "json['$fieldName']");
  }

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String _toSnakeCase(String input) => input
      .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]}_${m[2]}')
      .toLowerCase();

  String _snakeToCamel(String input) {
    final parts = input.split('_');
    if (parts.isEmpty) return input;
    return parts.first +
        parts.skip(1).map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        }).join();
  }

  String _snakeToUpperCamel(String input) {
    final parts = input.split('_');
    if (parts.isEmpty) return input;
    return _capitalize(parts.first) +
        parts.skip(1).map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        }).join();
  }

  bool _isPrimitiveTypeOrList(String type) {
    const primitiveTypes = {
      'String',
      'int',
      'double',
      'bool',
      'DateTime',
    };

    // is primitiveTypes
    if (primitiveTypes.contains(type)) return true;

    // is List<...>
    final listRegExp = RegExp(r'^List<(.+)>$');
    final match = listRegExp.firstMatch(type);
    if (match != null) {
      final innerType = match.group(1);
      return primitiveTypes.contains(innerType);
    }

    return false;
  }
}

class _TypeResult {
  final String type;
  final String fromJson;
  final String? nestedClass;
  final Map<String, dynamic>? nestedJson;

  _TypeResult(this.type,
      {required this.fromJson, this.nestedClass, this.nestedJson});
}
