///
//  Generated code. Do not modify.
//  source: network.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use exMessageDescriptor instead')
const ExMessage$json = const {
  '1': 'ExMessage',
  '2': const [
    const {'1': 'route', '3': 1, '4': 1, '5': 13, '10': 'route'},
    const {'1': 'gw_id', '3': 2, '4': 1, '5': 13, '10': 'gwId'},
    const {'1': 'device_id', '3': 3, '4': 1, '5': 4, '10': 'deviceId'},
    const {'1': 'data_unit', '3': 4, '4': 1, '5': 12, '10': 'dataUnit'},
  ],
};

/// Descriptor for `ExMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exMessageDescriptor = $convert.base64Decode('CglFeE1lc3NhZ2USFAoFcm91dGUYASABKA1SBXJvdXRlEhMKBWd3X2lkGAIgASgNUgRnd0lkEhsKCWRldmljZV9pZBgDIAEoBFIIZGV2aWNlSWQSGwoJZGF0YV91bml0GAQgASgMUghkYXRhVW5pdA==');
@$core.Deprecated('Use rtuMessageDescriptor instead')
const RtuMessage$json = const {
  '1': 'RtuMessage',
  '2': const [
    const {'1': 'channel', '3': 1, '4': 1, '5': 13, '10': 'channel'},
    const {'1': 'sequence_number', '3': 2, '4': 1, '5': 13, '10': 'sequenceNumber'},
    const {'1': 'gw_id', '3': 3, '4': 1, '5': 13, '10': 'gwId'},
    const {'1': 'device_id', '3': 4, '4': 1, '5': 4, '10': 'deviceId'},
    const {'1': 'data_unit', '3': 5, '4': 1, '5': 12, '10': 'dataUnit'},
  ],
};

/// Descriptor for `RtuMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rtuMessageDescriptor = $convert.base64Decode('CgpSdHVNZXNzYWdlEhgKB2NoYW5uZWwYASABKA1SB2NoYW5uZWwSJwoPc2VxdWVuY2VfbnVtYmVyGAIgASgNUg5zZXF1ZW5jZU51bWJlchITCgVnd19pZBgDIAEoDVIEZ3dJZBIbCglkZXZpY2VfaWQYBCABKARSCGRldmljZUlkEhsKCWRhdGFfdW5pdBgFIAEoDFIIZGF0YVVuaXQ=');
@$core.Deprecated('Use extMessageDescriptor instead')
const ExtMessage$json = const {
  '1': 'ExtMessage',
  '2': const [
    const {'1': 'context', '3': 1, '4': 1, '5': 4, '10': 'context'},
    const {'1': 'gw_id', '3': 2, '4': 1, '5': 13, '10': 'gwId'},
    const {'1': 'device_id', '3': 3, '4': 1, '5': 4, '10': 'deviceId'},
    const {'1': 'data_unit', '3': 4, '4': 1, '5': 12, '10': 'dataUnit'},
  ],
};

/// Descriptor for `ExtMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List extMessageDescriptor = $convert.base64Decode('CgpFeHRNZXNzYWdlEhgKB2NvbnRleHQYASABKARSB2NvbnRleHQSEwoFZ3dfaWQYAiABKA1SBGd3SWQSGwoJZGV2aWNlX2lkGAMgASgEUghkZXZpY2VJZBIbCglkYXRhX3VuaXQYBCABKAxSCGRhdGFVbml0');
@$core.Deprecated('Use cmdMessageDescriptor instead')
const CmdMessage$json = const {
  '1': 'CmdMessage',
  '2': const [
    const {'1': 'op_code', '3': 1, '4': 1, '5': 13, '10': 'opCode'},
    const {'1': 'route', '3': 2, '4': 1, '5': 13, '10': 'route'},
    const {'1': 'argument', '3': 3, '4': 1, '5': 13, '10': 'argument'},
    const {'1': 'gw_id', '3': 4, '4': 1, '5': 13, '10': 'gwId'},
    const {'1': 'device_id', '3': 5, '4': 1, '5': 4, '10': 'deviceId'},
    const {'1': 'payload', '3': 6, '4': 1, '5': 12, '10': 'payload'},
  ],
};

/// Descriptor for `CmdMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cmdMessageDescriptor = $convert.base64Decode('CgpDbWRNZXNzYWdlEhcKB29wX2NvZGUYASABKA1SBm9wQ29kZRIUCgVyb3V0ZRgCIAEoDVIFcm91dGUSGgoIYXJndW1lbnQYAyABKA1SCGFyZ3VtZW50EhMKBWd3X2lkGAQgASgNUgRnd0lkEhsKCWRldmljZV9pZBgFIAEoBFIIZGV2aWNlSWQSGAoHcGF5bG9hZBgGIAEoDFIHcGF5bG9hZA==');
