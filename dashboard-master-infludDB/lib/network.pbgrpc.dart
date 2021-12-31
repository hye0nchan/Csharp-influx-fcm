///
//  Generated code. Do not modify.
//  source: network.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields, import_of_legacy_library_into_null_safe

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'network.pb.dart' as $0;
export 'network.pb.dart';

class ExProtoClient extends $grpc.Client {
  static final _$messageRtu = $grpc.ClientMethod<$0.RtuMessage, $0.RtuMessage>(
      '/net_exchange.ExProto/MessageRtu',
      ($0.RtuMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RtuMessage.fromBuffer(value));
  static final _$messageExt = $grpc.ClientMethod<$0.ExtMessage, $0.ExtMessage>(
      '/net_exchange.ExProto/MessageExt',
      ($0.ExtMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ExtMessage.fromBuffer(value));
  static final _$messageCmd = $grpc.ClientMethod<$0.CmdMessage, $0.CmdMessage>(
      '/net_exchange.ExProto/MessageCmd',
      ($0.CmdMessage value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CmdMessage.fromBuffer(value));
  static final _$exClientstream =
      $grpc.ClientMethod<$0.RtuMessage, $0.RtuMessage>(
          '/net_exchange.ExProto/ExClientstream',
          ($0.RtuMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.RtuMessage.fromBuffer(value));
  static final _$exServerstream =
      $grpc.ClientMethod<$0.RtuMessage, $0.RtuMessage>(
          '/net_exchange.ExProto/ExServerstream',
          ($0.RtuMessage value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.RtuMessage.fromBuffer(value));

  ExProtoClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.RtuMessage> messageRtu(
      $async.Stream<$0.RtuMessage> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$messageRtu, request, options: options);
  }

  $grpc.ResponseStream<$0.ExtMessage> messageExt(
      $async.Stream<$0.ExtMessage> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$messageExt, request, options: options);
  }

  $grpc.ResponseStream<$0.CmdMessage> messageCmd(
      $async.Stream<$0.CmdMessage> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$messageCmd, request, options: options);
  }

  $grpc.ResponseFuture<$0.RtuMessage> exClientstream($0.RtuMessage request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$exClientstream, request, options: options);
  }

  $grpc.ResponseStream<$0.RtuMessage> exServerstream($0.RtuMessage request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$exServerstream, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ExProtoServiceBase extends $grpc.Service {
  $core.String get $name => 'net_exchange.ExProto';

  ExProtoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RtuMessage, $0.RtuMessage>(
        'MessageRtu',
        messageRtu,
        true,
        true,
        ($core.List<$core.int> value) => $0.RtuMessage.fromBuffer(value),
        ($0.RtuMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExtMessage, $0.ExtMessage>(
        'MessageExt',
        messageExt,
        true,
        true,
        ($core.List<$core.int> value) => $0.ExtMessage.fromBuffer(value),
        ($0.ExtMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CmdMessage, $0.CmdMessage>(
        'MessageCmd',
        messageCmd,
        true,
        true,
        ($core.List<$core.int> value) => $0.CmdMessage.fromBuffer(value),
        ($0.CmdMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RtuMessage, $0.RtuMessage>(
        'ExClientstream',
        exClientstream_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RtuMessage.fromBuffer(value),
        ($0.RtuMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RtuMessage, $0.RtuMessage>(
        'ExServerstream',
        exServerstream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.RtuMessage.fromBuffer(value),
        ($0.RtuMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.RtuMessage> exClientstream_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RtuMessage> request) async {
    return exClientstream(call, await request);
  }

  $async.Stream<$0.RtuMessage> exServerstream_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RtuMessage> request) async* {
    yield* exServerstream(call, await request);
  }

  $async.Stream<$0.RtuMessage> messageRtu(
      $grpc.ServiceCall call, $async.Stream<$0.RtuMessage> request);
  $async.Stream<$0.ExtMessage> messageExt(
      $grpc.ServiceCall call, $async.Stream<$0.ExtMessage> request);
  $async.Stream<$0.CmdMessage> messageCmd(
      $grpc.ServiceCall call, $async.Stream<$0.CmdMessage> request);
  $async.Future<$0.RtuMessage> exClientstream(
      $grpc.ServiceCall call, $0.RtuMessage request);
  $async.Stream<$0.RtuMessage> exServerstream(
      $grpc.ServiceCall call, $0.RtuMessage request);
}
