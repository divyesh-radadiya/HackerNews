// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_table.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class NewsTableData extends DataClass implements Insertable<NewsTableData> {
  final int id;
  final String title;
  final String by;
  final int time;
  NewsTableData(
      {@required this.id,
      @required this.title,
      @required this.by,
      @required this.time});
  factory NewsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return NewsTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      by: stringType.mapFromDatabaseResponse(data['${effectivePrefix}by']),
      time: intType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || by != null) {
      map['by'] = Variable<String>(by);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<int>(time);
    }
    return map;
  }

  NewsTableCompanion toCompanion(bool nullToAbsent) {
    return NewsTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      by: by == null && nullToAbsent ? const Value.absent() : Value(by),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
    );
  }

  factory NewsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NewsTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      by: serializer.fromJson<String>(json['by']),
      time: serializer.fromJson<int>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'by': serializer.toJson<String>(by),
      'time': serializer.toJson<int>(time),
    };
  }

  NewsTableData copyWith({int id, String title, String by, int time}) =>
      NewsTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        by: by ?? this.by,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('NewsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('by: $by, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode, $mrjc(title.hashCode, $mrjc(by.hashCode, time.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is NewsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.by == this.by &&
          other.time == this.time);
}

class NewsTableCompanion extends UpdateCompanion<NewsTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> by;
  final Value<int> time;
  const NewsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.by = const Value.absent(),
    this.time = const Value.absent(),
  });
  NewsTableCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required String by,
    @required int time,
  })  : title = Value(title),
        by = Value(by),
        time = Value(time);
  static Insertable<NewsTableData> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> by,
    Expression<int> time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (by != null) 'by': by,
      if (time != null) 'time': time,
    });
  }

  NewsTableCompanion copyWith(
      {Value<int> id, Value<String> title, Value<String> by, Value<int> time}) {
    return NewsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      by: by ?? this.by,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (by.present) {
      map['by'] = Variable<String>(by.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('by: $by, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $NewsTableTable extends NewsTable
    with TableInfo<$NewsTableTable, NewsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $NewsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _byMeta = const VerificationMeta('by');
  GeneratedTextColumn _by;
  @override
  GeneratedTextColumn get by => _by ??= _constructBy();
  GeneratedTextColumn _constructBy() {
    return GeneratedTextColumn(
      'by',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedIntColumn _time;
  @override
  GeneratedIntColumn get time => _time ??= _constructTime();
  GeneratedIntColumn _constructTime() {
    return GeneratedIntColumn(
      'time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, by, time];
  @override
  $NewsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'news_table';
  @override
  final String actualTableName = 'news_table';
  @override
  VerificationContext validateIntegrity(Insertable<NewsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('by')) {
      context.handle(_byMeta, by.isAcceptableOrUnknown(data['by'], _byMeta));
    } else if (isInserting) {
      context.missing(_byMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time'], _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return NewsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $NewsTableTable createAlias(String alias) {
    return $NewsTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $NewsTableTable _newsTable;
  $NewsTableTable get newsTable => _newsTable ??= $NewsTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [newsTable];
}
