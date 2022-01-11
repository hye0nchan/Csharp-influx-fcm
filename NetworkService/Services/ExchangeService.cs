#region Copyright notice and license

// Copyright 2019 The gRPC Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#endregion

using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using Grpc.Core;
using NetExchange;
using System;
using Google.Cloud.Firestore;
using System.Collections.Generic;

namespace NetService
{
    public class ExchangeService : ExProto.ExProtoBase
    {
        private readonly ILogger _logger;
        internal static IServerStreamWriter<RtuMessage> responseStreamRtu = null;
        internal static IServerStreamWriter<ExtMessage> responseStreamExt = null;
        internal static IServerStreamWriter<CmdMessage> responseStreamCmd = null;
        internal static IServerStreamWriter<RtuMessage> responseStream = null;
        internal static IServerStreamWriter<RtuMessage> responseStreamInflux = null;
        internal static IServerStreamWriter<ExMessage> responseExMessage = null;

        public ExchangeService(ILoggerFactory loggerFactory)
        {
            _logger = loggerFactory.CreateLogger<ExchangeService>();
            _logger.LogInformation($"Exchange Service Protocol Starts");
        }


        public override async Task influxDB(IAsyncStreamReader<RtuMessage> requestStream, IServerStreamWriter<RtuMessage> responseStream, ServerCallContext context)
        {
            ExchangeService.responseStreamRtu = responseStream;

            while (await requestStream.MoveNext())
            {
                RtuMessage request = requestStream.Current; // From Client
                await Program.rtuLink.RequestStream.WriteAsync(request); // Client to Server
            }

            ExchangeService.responseStreamRtu = null;
        }
        public override Task ExServerstream(RtuMessage request, IServerStreamWriter<RtuMessage> responseStream, ServerCallContext context)
        {

            var count = 0;

            while (true)
            {
                ExchangeService.responseStream = responseStream;
                if (count == 0)
                {
                    FirestoreDb db;
                    string path = AppDomain.CurrentDomain.BaseDirectory + @"hometestproject-f01e6-firebase-adminsdk-z0oga-3d3578f7d5.json";
                    Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);
                    db = FirestoreDb.Create("hometestproject-f01e6");
                    DocumentReference coll = db.Collection("Connect").Document("Bool");
                    Dictionary<string, bool> data1 = new Dictionary<string, bool>()
            {
                {"Bool", true }
            };
                    coll.SetAsync(data1);

                    count = 1;
                }
            }
        }

        public override Task<RtuMessage> ExClientstream(RtuMessage request, ServerCallContext context)
        {

            var response = request;
            while (true)
            {
                TxLink(ref response);
                return Task.FromResult(response);
            }

        }


        internal static void TxLink(ref RtuMessage request)
        {                   
            RtuMessage response = request;

            Program.rtuLink.RequestStream.WriteAsync(response);
        }

        internal static void RxLink(ref RtuMessage response)
        {
            IServerStreamWriter<RtuMessage> responseStream = ExchangeService.responseStream;

            if (responseStream != null)
            {
                RtuMessage box = new RtuMessage();
                //responseStream.WriteAsync(new ExMessage {Route = response.Route, DataUnit = response.DataUnit, GwId = response.GwId, DeviceId = response.DeviceId });
                box.GwId = response.GwId; box.DataUnit = response.DataUnit; box.DeviceId = response.DeviceId; box.SequenceNumber = response.SequenceNumber;

                responseStream.WriteAsync(box);

            }

        }

        public override async Task MessageRtu(IAsyncStreamReader<RtuMessage> requestStream, IServerStreamWriter<RtuMessage> responseStream, ServerCallContext context)
        {
            ExchangeService.responseStreamRtu = responseStream;

            while (await requestStream.MoveNext())
            {
                RtuMessage request = requestStream.Current; // From Client
                await Program.rtuLink.RequestStream.WriteAsync(request); // Client to Server
            }

            ExchangeService.responseStreamRtu = null;
        }


        public override async Task MessageExt(IAsyncStreamReader<ExtMessage> requestStream, IServerStreamWriter<ExtMessage> responseStream, ServerCallContext context)
        {
            ExchangeService.responseStreamExt = responseStream;

            while (await requestStream.MoveNext())
            {
                ExtMessage request = requestStream.Current; // From Client
                await Program.extLink.RequestStream.WriteAsync(request); // Client to Server
            }

            ExchangeService.responseStreamRtu = null;
        }

        public override async Task MessageCmd(IAsyncStreamReader<CmdMessage> requestStream, IServerStreamWriter<CmdMessage> responseStream, ServerCallContext context)
        {
            ExchangeService.responseStreamCmd = responseStream;

            while (await requestStream.MoveNext())
            {
                CmdMessage request = requestStream.Current; // From Client
                await Program.cmdLink.RequestStream.WriteAsync(request); // Client to Server
            }

            ExchangeService.responseStreamCmd = null;
        }
    }
}
