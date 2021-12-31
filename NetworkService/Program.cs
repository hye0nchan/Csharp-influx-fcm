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

using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.Extensions.Hosting;
using Grpc.Core;
using Grpc.Net.Client;
using System;
using System.Threading;
using System.Threading.Tasks;
using NetExchange;
using System.Net;
using System.Net.Sockets;
using Google.Cloud.Firestore;
using System.Collections.Generic;
using Google.Protobuf;
using System.Diagnostics;

namespace NetService
{
    public class Program
    {
        private static GrpcChannel channel = GrpcChannel.ForAddress("http://localhost:5052");
        private static ExProto.ExProtoClient exchange = new ExProto.ExProtoClient(channel);
        internal static AsyncDuplexStreamingCall<RtuMessage, RtuMessage> rtuLink = exchange.MessageRtu();
        internal static AsyncDuplexStreamingCall<ExtMessage, ExtMessage> extLink = exchange.MessageExt();
        internal static AsyncDuplexStreamingCall<CmdMessage, CmdMessage> cmdLink = exchange.MessageCmd();
        internal static AsyncDuplexStreamingCall<ExMessage, ExMessage> exLink = exchange.ExLink();
        internal static AsyncDuplexStreamingCall<RtuMessage, RtuMessage> influxLink = exchange.influxDB();

        public static void Main(string[] args)
        {
            _ = Task.Run(async () =>
            {
                addIP();

                while (await rtuLink.ResponseStream.MoveNext(cancellationToken: CancellationToken.None))
                {
                    RtuMessage response = rtuLink.ResponseStream.Current; // From Server
                    IServerStreamWriter<RtuMessage> responseStream = ExchangeService.responseStreamRtu;
                    
                    IServerStreamWriter<RtuMessage> responseStream_influxDB = ExchangeService.responseStreamInflux;
                    var protocol = (byte)response.Channel;
                    Debug.WriteLine(response.DataUnit);
                    if (responseStream != null)
                    {
                        switch (protocol)
                        {
                            case 100:
                                //await responseStream_influxDB.WriteAsync(response);
                                await responseStream.WriteAsync(response);
                                break;
                            case 200:
                                ExchangeService.RxLink(ref response);
                                break;
                        }
                        await responseStream.WriteAsync(response); // Server to Client
                        
                    }
                    ExchangeService.RxLink(ref response);

                }

            });

            _ = Task.Run(async () =>
            {
                while (await extLink.ResponseStream.MoveNext(cancellationToken: CancellationToken.None))
                {
                    ExtMessage response = extLink.ResponseStream.Current; // From Server
                    IServerStreamWriter<ExtMessage> responseStream = ExchangeService.responseStreamExt;

                    if (responseStream != null)
                    {
                        await responseStream.WriteAsync(response); // Server to Client
                    }
                }
            });

            _ = Task.Run(async () =>
            {
                while (await cmdLink.ResponseStream.MoveNext(cancellationToken: CancellationToken.None))
                {
                    CmdMessage response = cmdLink.ResponseStream.Current; // From Server
                    IServerStreamWriter<CmdMessage> responseStream = ExchangeService.responseStreamCmd;

                    if (responseStream != null)
                    {
                        await responseStream.WriteAsync(response); // Server to Client
                    }
                }
            });

            Console.WriteLine("Network Service Host Starts");
            CreateHostBuilder(args).Build().Run();
        }

        // Additional configuration is required to successfully run gRPC on macOS.
        // For instructions on how to configure Kestrel and gRPC clients on macOS, visit https://go.microsoft.com/fwlink/?linkid=2099682
        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.ConfigureKestrel(options =>
                    {
                        string localIP = "Not available, please check your network seetings!";
                        IPHostEntry host = Dns.GetHostEntry(Dns.GetHostName());
                        foreach (IPAddress ip in host.AddressList)
                        {
                            if (ip.AddressFamily == AddressFamily.InterNetwork)
                            {
                                localIP = ip.ToString();
                            }
                        }
                        System.Net.IPAddress ip1 = System.Net.IPAddress.Parse(localIP);
                        options.Listen(ip1, 5054, o => o.Protocols = HttpProtocols.Http2);
                    });
                    webBuilder.UseStartup<Startup>();
                });

        static private void addIP()
        {
            string localIP = "Not available, please check your network seetings!";
            IPHostEntry host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (IPAddress ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    localIP = ip.ToString();
                }
            }
            System.Net.IPAddress ip1 = System.Net.IPAddress.Parse(localIP);
            Console.WriteLine(ip1);
            FirestoreDb db;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"hometestproject-f01e6-firebase-adminsdk-z0oga-3d3578f7d5.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);
            db = FirestoreDb.Create("hometestproject-f01e6");
            DocumentReference coll = db.Collection("IP").Document("local");
            Dictionary<string, string> data1 = new Dictionary<string, string>()
            {
                {"IP", ip1.ToString() }
            };
            coll.SetAsync(data1);
        }


    }
}
