///
//  Generated code. Do not modify.
//  source: network.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class ExMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'net_exchange'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'route', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gwId', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataUnit', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ExMessage._() : super();
  factory ExMessage({
    $core.int? route,
    $core.int? gwId,
    $fixnum.Int64? deviceId,
    $core.List<$core.int>? dataUnit,
  }) {
    final _result = create();
    if (route != null) {
      _result.route = route;
    }
    if (gwId != null) {
      _result.gwId = gwId;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (dataUnit != null) {
      _result.dataUnit = dataUnit;
    }
    return _result;
  }
  factory ExMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExMessage clone() => ExMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExMessage copyWith(void Function(ExMessage) updates) => super.copyWith((message) => updates(message as ExMessage)) as ExMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExMessage create() => ExMessage._();
  ExMessage createEmptyInstance() => create();
  static $pb.PbList<ExMessage> createRepeated() => $pb.PbList<ExMessage>();
  @$core.pragma('dart2js:noInline')
  static ExMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExMessage>(create);
  static ExMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get route => $_getIZ(0);
  @$pb.TagNumber(1)
  set route($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoute() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoute() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get gwId => $_getIZ(1);
  @$pb.TagNumber(2)
  set gwId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGwId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGwId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get deviceId => $_getI64(2);
  @$pb.TagNumber(3)
  set deviceId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeviceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get dataUnit => $_getN(3);
  @$pb.TagNumber(4)
  set dataUnit($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDataUnit() => $_has(3);
  @$pb.TagNumber(4)
  void clearDataUnit() => clearField(4);
}

class RtuMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RtuMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'net_exchange'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'channel', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceNumber', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gwId', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataUnit', $pb.PbFieldType.OY)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sensor', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  RtuMessage._() : super();
  factory RtuMessage({
    $core.int? channel,
    $core.int? sequenceNumber,
    $core.int? gwId,
    $fixnum.Int64? deviceId,
    $core.List<$core.int>? dataUnit,
    $core.int? sensor,
  }) {
    final _result = create();
    if (channel != null) {
      _result.channel = channel;
    }
    if (sequenceNumber != null) {
      _result.sequenceNumber = sequenceNumber;
    }
    if (gwId != null) {
      _result.gwId = gwId;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (dataUnit != null) {
      _result.dataUnit = dataUnit;
    }
    if (sensor != null) {
      _result.sensor = sensor;
    }
    return _result;
  }
  factory RtuMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RtuMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RtuMessage clone() => RtuMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RtuMessage copyWith(void Function(RtuMessage) updates) => super.copyWith((message) => updates(message as RtuMessage)) as RtuMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RtuMessage create() => RtuMessage._();
  RtuMessage createEmptyInstance() => create();
  static $pb.PbList<RtuMessage> createRepeated() => $pb.PbList<RtuMessage>();
  @$core.pragma('dart2js:noInline')
  static RtuMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RtuMessage>(create);
  static RtuMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get channel => $_getIZ(0);
  @$pb.TagNumber(1)
  set channel($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get sequenceNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set sequenceNumber($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSequenceNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequenceNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get gwId => $_getIZ(2);
  @$pb.TagNumber(3)
  set gwId($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGwId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGwId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get deviceId => $_getI64(3);
  @$pb.TagNumber(4)
  set deviceId($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceId() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get dataUnit => $_getN(4);
  @$pb.TagNumber(5)
  set dataUnit($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDataUnit() => $_has(4);
  @$pb.TagNumber(5)
  void clearDataUnit() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get sensor => $_getIZ(5);
  @$pb.TagNumber(6)
  set sensor($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSensor() => $_has(5);
  @$pb.TagNumber(6)
  void clearSensor() => clearField(6);
}

class ExtMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExtMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'net_exchange'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'context', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gwId', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataUnit', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ExtMessage._() : super();
  factory ExtMessage({
    $fixnum.Int64? context,
    $core.int? gwId,
    $fixnum.Int64? deviceId,
    $core.List<$core.int>? dataUnit,
  }) {
    final _result = create();
    if (context != null) {
      _result.context = context;
    }
    if (gwId != null) {
      _result.gwId = gwId;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (dataUnit != null) {
      _result.dataUnit = dataUnit;
    }
    return _result;
  }
  factory ExtMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExtMessage clone() => ExtMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExtMessage copyWith(void Function(ExtMessage) updates) => super.copyWith((message) => updates(message as ExtMessage)) as ExtMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtMessage create() => ExtMessage._();
  ExtMessage createEmptyInstance() => create();
  static $pb.PbList<ExtMessage> createRepeated() => $pb.PbList<ExtMessage>();
  @$core.pragma('dart2js:noInline')
  static ExtMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtMessage>(create);
  static ExtMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get context => $_getI64(0);
  @$pb.TagNumber(1)
  set context($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContext() => $_has(0);
  @$pb.TagNumber(1)
  void clearContext() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get gwId => $_getIZ(1);
  @$pb.TagNumber(2)
  set gwId($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGwId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGwId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get deviceId => $_getI64(2);
  @$pb.TagNumber(3)
  set deviceId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeviceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get dataUnit => $_getN(3);
  @$pb.TagNumber(4)
  set dataUnit($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDataUnit() => $_has(3);
  @$pb.TagNumber(4)
  void clearDataUnit() => clearField(4);
}

class CmdMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CmdMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'net_exchange'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'opCode', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'route', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'argument', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gwId', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  CmdMessage._() : super();
  factory CmdMessage({
    $core.int? opCode,
    $core.int? route,
    $core.int? argument,
    $core.int? gwId,
    $fixnum.Int64? deviceId,
    $core.List<$core.int>? payload,
  }) {
    final _result = create();
    if (opCode != null) {
      _result.opCode = opCode;
    }
    if (route != null) {
      _result.route = route;
    }
    if (argument != null) {
      _result.argument = argument;
    }
    if (gwId != null) {
      _result.gwId = gwId;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (payload != null) {
      _result.payload = payload;
    }
    return _result;
  }
  factory CmdMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CmdMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CmdMessage clone() => CmdMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CmdMessage copyWith(void Function(CmdMessage) updates) => super.copyWith((message) => updates(message as CmdMessage)) as CmdMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CmdMessage create() => CmdMessage._();
  CmdMessage createEmptyInstance() => create();
  static $pb.PbList<CmdMessage> createRepeated() => $pb.PbList<CmdMessage>();
  @$core.pragma('dart2js:noInline')
  static CmdMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CmdMessage>(create);
  static CmdMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get opCode => $_getIZ(0);
  @$pb.TagNumber(1)
  set opCode($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOpCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearOpCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get route => $_getIZ(1);
  @$pb.TagNumber(2)
  set route($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRoute() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoute() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get argument => $_getIZ(2);
  @$pb.TagNumber(3)
  set argument($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasArgument() => $_has(2);
  @$pb.TagNumber(3)
  void clearArgument() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get gwId => $_getIZ(3);
  @$pb.TagNumber(4)
  set gwId($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGwId() => $_has(3);
  @$pb.TagNumber(4)
  void clearGwId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get deviceId => $_getI64(4);
  @$pb.TagNumber(5)
  set deviceId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDeviceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceId() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get payload => $_getN(5);
  @$pb.TagNumber(6)
  set payload($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPayload() => $_has(5);
  @$pb.TagNumber(6)
  void clearPayload() => clearField(6);
}

