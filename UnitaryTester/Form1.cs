using Google.Protobuf;
using Grpc.Core;
using Grpc.Net.Client;
using InfluxDB.Client;
using InfluxDB.Client.Writes;
using NetExchange;
using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WFormsUserApp
{
    internal partial class Form1 : Form
    {
        private static GrpcChannel channel = GrpcChannel.ForAddress("http://172.17.160.1:5054");
        internal static ExProto.ExProtoClient exchange = new ExProto.ExProtoClient(channel);
        internal static AsyncDuplexStreamingCall<RtuMessage, RtuMessage> rtuLink = exchange.MessageRtu();
        internal static AsyncDuplexStreamingCall<ExtMessage, ExtMessage> extLink = exchange.MessageExt();
        internal static AsyncDuplexStreamingCall<CmdMessage, CmdMessage> cmdLink = exchange.MessageCmd();
        internal static AsyncDuplexStreamingCall<RtuMessage, RtuMessage> influxLink = exchange.influxDB();

        bool rtuMessageOn = true;
        int timer1Interval = 180000;
        int timer2Interval = 180000;
        int timer3Interval = 180000;
        internal Form1()
        {
            InitializeComponent();
            Task.Run(() => RtuMessageService());
        }

        void rtuMessageTrue()
        {
            rtuMessageOn = true;
        }

        private async void InfluxService()
        {
            try
            {
                while (await influxLink.ResponseStream.MoveNext(cancellationToken: CancellationToken.None))
                {
                    if (rtuMessageOn)
                    {
                        var response = rtuLink.ResponseStream.Current;

                        byte protocol = (byte)response.Channel;

                        UInt16 clientId = (UInt16)(response.Channel >> 8);
                        this.Invoke((MethodInvoker)delegate ()
                        {
                            richTextBox2.Text = "RxRtu(" + GetProtocolChannelName(protocol) + ")";
                            richTextBox2.AppendText(Environment.NewLine + $"Client ID={clientId}");
                        });

                        switch (protocol)
                        {
                            case 100:
                                /* Modbus protocol */
                                byte[] payload = new byte[response.DataUnit.Length];
                                response.DataUnit.CopyTo(payload, 0);
                                RxRtu((UInt16)response.SequenceNumber, response.GwId, response.DeviceId, payload);
                                break;
                            default:
                                /* Unknown protocol */
                                break;
                        }
                        rtuMessageOn = false;
                    }

                }
            }
            catch (Exception)
            {
            }
            finally
            {
                Application.Exit();
            }
        }

        private async void RtuMessageService()
        {
            try
            {

                while (await rtuLink.ResponseStream.MoveNext(cancellationToken: CancellationToken.None))
                {
                    if (rtuMessageOn)
                    {
                        var response = rtuLink.ResponseStream.Current;

                        byte protocol = (byte)response.Channel;

                        UInt16 clientId = (UInt16)(response.Channel >> 8);
                        this.Invoke((MethodInvoker)delegate ()
                        {
                            richTextBox2.Text = "RxRtu(" + GetProtocolChannelName(protocol) + ")";
                            richTextBox2.AppendText(Environment.NewLine + $"Client ID={clientId}");
                        });

                        switch (protocol)
                        {
                            case 100:
                                /* Modbus protocol */
                                byte[] payload = new byte[response.DataUnit.Length];
                                response.DataUnit.CopyTo(payload, 0);
                                RxRtu((UInt16)response.SequenceNumber, response.GwId, response.DeviceId, payload);
                                break;
                            default:
                                /* Unknown protocol */
                                break;
                        }
                        rtuMessageOn = false;
                    }

                }
            }
            catch (Exception)
            {
            }
            finally
            {
                Application.Exit();
            }
        }

        private async void ExtMessageService()
        {
            try
            {
                while (await extLink.ResponseStream.MoveNext(cancellationToken: CancellationToken.None))
                {
                    var response = extLink.ResponseStream.Current;
                    byte[] payload = new byte[response.DataUnit.Length];
                    response.DataUnit.CopyTo(payload, 0);
                    RxExt(response.Context, response.GwId, response.DeviceId, payload);
                }
            }
            catch (Exception)
            {
            }
            finally
            {
                Application.Exit();
            }
        }

        private async void CmdMessageService()
        {
            try
            {
                while (await cmdLink.ResponseStream.MoveNext(cancellationToken: CancellationToken.None))
                {
                    var response = cmdLink.ResponseStream.Current;
                    byte[] payload = new byte[response.Payload.Length];
                    response.Payload.CopyTo(payload, 0);
                    RxCmd((UInt16)response.OpCode, response.Route, response.Argument, response.GwId, response.DeviceId, payload);
                }
            }
            catch (Exception)
            {
            }
            finally
            {
                Application.Exit();
            }
        }

        private String GetProtocolChannelName(UInt16 channel)
        {
            switch (channel)
            {
                case 0:
                    return "Modbus";
            }

            return "Unknown probotol";
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            listView1.View = View.Details;
            listView2.View = View.Details;
            listView3.View = View.Details;

            listView1.Columns.Add("measurement", 100);
            listView1.Columns.Add("value", 150);
            listView2.Columns.Add("measurement", 100);
            listView2.Columns.Add("value", 150);
            listView3.Columns.Add("measurement", 100);
            listView3.Columns.Add("value", 150);


            timer1.Enabled = true;
            timer1.Interval = timer1Interval;
            Thread.Sleep(5000);
            timer2.Enabled = true;
            timer2.Interval = timer2Interval;
            Thread.Sleep(5000);
            timer3.Enabled = true;
            timer3.Interval = timer3Interval;

        }


        private static UInt16 TxClient;
        public void TxRtu(UInt16 sequenceNumber, UInt32 gatewayId, UInt64 deviceId, byte[] payload)
        {
            byte protocol = 100;
            UInt16 clientID = --TxClient;

            this.Invoke((MethodInvoker)delegate ()
            {
                richTextBox1.Text = "TxRtu(" + GetProtocolChannelName(protocol) + ")";
                richTextBox1.AppendText(Environment.NewLine + $"Client ID={clientID}");
                richTextBox1.AppendText(Environment.NewLine + $"RequestStream.SequenceNumber={sequenceNumber}");
                richTextBox1.AppendText(Environment.NewLine + $"RequestStream.GatewayId=" + gatewayId.ToString("X6"));
                richTextBox1.AppendText(Environment.NewLine + $"RequestStream.DeviceId=" + deviceId.ToString("X12"));
                richTextBox1.AppendText(Environment.NewLine + $"RequestStream.Tdu.Length={payload.Length}");
                richTextBox1.AppendText(Environment.NewLine + $"RequestStream.Tdu={BitConverter.ToString(payload).Replace("-", string.Empty)}");
                richTextBox1.AppendText(Environment.NewLine);
                richTextBox2.Text = "Awaiting response...";
            });

            rtuLink.RequestStream.WriteAsync(new RtuMessage
            {
                Channel = ((UInt32)clientID << 8) | protocol,
                SequenceNumber = sequenceNumber,
                GwId = gatewayId,
                DeviceId = deviceId,
                DataUnit = ByteString.CopyFrom(payload[0..payload.Length])
            });
        }

        public void RxRtu(UInt16 acknowledgeNumber, UInt32 gatewayId, UInt64 deviceId, byte[] payload)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                richTextBox2.AppendText(Environment.NewLine + $"response.AcknowledgeNumber={acknowledgeNumber}");
                richTextBox2.AppendText(Environment.NewLine + $"response.GatewayId=" + gatewayId.ToString("X6"));
                richTextBox2.AppendText(Environment.NewLine + $"response.DeviceId=" + deviceId.ToString("X12"));
                richTextBox2.AppendText(Environment.NewLine + $"response.Tdu.Length={payload.Length}");
                richTextBox2.AppendText(Environment.NewLine + BitConverter.ToString(payload));
                richTextBox2.AppendText(Environment.NewLine);
                richTextBox1.Text += "Responsed... ";
            });

            GetModbusFloat(payload, deviceId);

        }

        public void TxExt(UInt64 context, UInt32 gatewayId, UInt64 deviceId, byte[] payload)
        {
            UInt16 channel = (UInt16)context;

            this.Invoke((MethodInvoker)delegate ()
            {
                richTextBox2.Text = "TxExt(" + GetProtocolChannelName(channel) + ")";
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.Context=" + context.ToString("X16"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.GatewayId=" + gatewayId.ToString("X6"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.DeviceId=" + deviceId.ToString("X12"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.Tdu.Length={payload.Length}");
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.Tdu={BitConverter.ToString(payload).Replace("-", string.Empty)}");
                richTextBox2.AppendText(Environment.NewLine);
                richTextBox3.Text = "Replied...";
            });

            extLink.RequestStream.WriteAsync(new ExtMessage
            {
                Context = context,
                GwId = gatewayId,
                DeviceId = deviceId,
                DataUnit = ByteString.CopyFrom(payload[0..payload.Length])
            });
        }

        public void RxExt(UInt64 context, UInt32 gatewayId, UInt64 deviceId, byte[] payload)
        {
            UInt16 channel = (UInt16)context;

            this.Invoke((MethodInvoker)delegate ()
            {
                richTextBox3.Text = "RxExt(" + GetProtocolChannelName(channel) + ")";
                richTextBox3.AppendText(Environment.NewLine + $"RequestStream.Context=" + context.ToString("X16"));
                richTextBox3.AppendText(Environment.NewLine + $"response.GatewayId=" + gatewayId.ToString("X6"));
                richTextBox3.AppendText(Environment.NewLine + $"response.DeviceId=" + deviceId.ToString("X12"));
                richTextBox3.AppendText(Environment.NewLine + $"response.Tdu.Length={payload.Length}");
                richTextBox3.AppendText(Environment.NewLine + BitConverter.ToString(payload));
                richTextBox3.AppendText(Environment.NewLine);
                richTextBox3.Text += "Awaiting processing...";
            });

            switch (channel)
            {
                case 0: /* Modbus Salve Processing */
                    TxExt(context, gatewayId, deviceId, new byte[] { /* Response Message */ });
                    break;
            }
        }

        public void TxCmd(UInt16 opCode, UInt32 route, UInt32 argument, UInt32 gatewayId, UInt64 deviceId, byte[] payload)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                richTextBox2.Text = "TxExt()";
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.OpCode=" + opCode.ToString("X4"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.Route=" + route.ToString("X8"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.Argument=" + argument.ToString("X8"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.GatewayId=" + gatewayId.ToString("X6"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.DeviceId=" + deviceId.ToString("X12"));
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.Tdu.Length={payload.Length}");
                richTextBox2.AppendText(Environment.NewLine + $"RequestStream.Tdu={BitConverter.ToString(payload).Replace("-", string.Empty)}");
                richTextBox2.AppendText(Environment.NewLine);
                richTextBox3.Text = "Replied...";
            });

            cmdLink.RequestStream.WriteAsync(new CmdMessage
            {
                OpCode = opCode,
                Route = route,
                Argument = argument,
                GwId = gatewayId,
                DeviceId = deviceId,
                Payload = ByteString.CopyFrom(payload[0..payload.Length])
            });
        }

        public void RxCmd(UInt16 opCode, UInt32 route, UInt32 argument, UInt32 gatewayId, UInt64 deviceId, byte[] payload)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                richTextBox3.Text = "RxCmd()";
                richTextBox3.AppendText(Environment.NewLine + $"RequestStream.OpCode=" + opCode.ToString("X4"));
                richTextBox3.AppendText(Environment.NewLine + $"RequestStream.Route=" + route.ToString("X8"));
                richTextBox3.AppendText(Environment.NewLine + $"RequestStream.Argument=" + argument.ToString("X8"));
                richTextBox3.AppendText(Environment.NewLine + $"response.GatewayId=" + gatewayId.ToString("X6"));
                richTextBox3.AppendText(Environment.NewLine + $"response.DeviceId=" + deviceId.ToString("X12"));
                richTextBox3.AppendText(Environment.NewLine + $"response.Tdu.Length={payload.Length}");
                richTextBox3.AppendText(Environment.NewLine + BitConverter.ToString(payload));
                richTextBox3.AppendText(Environment.NewLine);
            });

            switch (opCode)
            {
                case 0:
                    this.Invoke((MethodInvoker)delegate ()
                    {
                        richTextBox2.Text += "Gateway... ";
                    });
                    break;
            }
        }

        void GetModbusFloat(byte[] receiveData, UInt64 deviceId)
        {

            float? temValue1 = 0;
            float? humValue1 = 0;
            float? co2Value1 = 0;
            float? luxValue1 = 0;
            float? uvValue1 = 0;
            float? nh3Value1 = 0;
            float? nh3_LValue1 = 0;
            float? nh3_MValue1 = 0;
            float? nh3_HValue1 = 0;
            float? no2Value1 = 0;
            float? no2_LValue1 = 0;
            float? no2_MValue1 = 0;
            float? no2_HValue1 = 0;
            float? coValue1 = 0;
            float? co_LValue1 = 0;
            float? co_MValue1 = 0;
            float? co_HValue1 = 0;

            float? temValue2 = 0;
            float? humValue2 = 0;
            float? co2Value2 = 0;
            float? luxValue2 = 0;
            float? uvValue2 = 0;
            float? nh3Value2 = 0;
            float? nh3_LValue2 = 0;
            float? nh3_MValue2 = 0;
            float? nh3_HValue2 = 0;
            float? no2Value2 = 0;
            float? no2_LValue2 = 0;
            float? no2_MValue2 = 0;
            float? no2_HValue2 = 0;
            float? coValue2 = 0;
            float? co_LValue2 = 0;
            float? co_MValue2 = 0;
            float? co_HValue2 = 0;

            float? temValue3 = 0;
            float? humValue3 = 0;
            float? co2Value3 = 0;
            float? luxValue3 = 0;
            float? uvValue3 = 0;
            float? nh3Value3 = 0;
            float? nh3_LValue3 = 0;
            float? nh3_MValue3 = 0;
            float? nh3_HValue3 = 0;
            float? no2Value3 = 0;
            float? no2_LValue3 = 0;
            float? no2_MValue3 = 0;
            float? no2_HValue3 = 0;
            float? coValue3 = 0;
            float? co_LValue3 = 0;
            float? co_MValue3 = 0;
            float? co_HValue3 = 0;

            UInt64[] deviceList = new UInt64[3] {
                0x24A16057F685,
                0x500291AEBCD9,
                0x500291AEBE4D
           };

            int[,] sensorArray = new int[17, 4]
            {
                { 23, 24, 21, 22 },
                { 5, 6, 3, 4 },
                { 29, 30, 27, 28 },
                { 35, 36, 33, 34 },
                { 41, 42, 39, 40 },
                { 47, 48, 45, 46 },
                { 65, 66, 63, 64 },
                { 71, 72, 69, 70 },
                { 77, 78, 75, 76 },
                { 53, 54, 51, 52 },
                { 95, 96, 93, 94 },
                { 107, 108, 105, 106 },
                { 113, 114, 111, 112 },
                { 59, 60, 57, 58 },
                { 131, 132, 129, 130 },
                { 137, 138, 135, 136 },
                { 149, 150, 147, 148 },

            };

            for (int i = 0; i < 17; i++)
            {
                byte[] rData = new byte[4];

                rData[0] = receiveData[sensorArray[i, 3]];
                rData[1] = receiveData[sensorArray[i, 2]];
                rData[2] = receiveData[sensorArray[i, 1]];
                rData[3] = receiveData[sensorArray[i, 0]];

                for (int j = 0; j < 3; j++)
                {
                    if (deviceId == deviceList[j])
                    {
                        switch (deviceId)
                        {
                            case 0x24A16057F685:
                                switch (i)
                                {
                                    case 0:
                                        temValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 1:
                                        humValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 2:
                                        co2Value1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 3:
                                        luxValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 4:
                                        uvValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 5:
                                        nh3Value1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 6:
                                        nh3_LValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 7:
                                        nh3_MValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 8:
                                        nh3_HValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 9:
                                        no2Value1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 10:
                                        no2_LValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 11:
                                        no2_MValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 12:
                                        no2_HValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 13:
                                        coValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 14:
                                        co_LValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 15:
                                        co_MValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 16:
                                        co_HValue1 = BitConverter.ToSingle(rData, 0);
                                        break;
                                }
                                break;
                            case 0x500291AEBCD9:
                                switch (i)
                                {
                                    case 0:
                                        temValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 1:
                                        humValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 2:
                                        co2Value2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 3:
                                        luxValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 4:
                                        uvValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 5:
                                        nh3Value2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 6:
                                        nh3_LValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 7:
                                        nh3_MValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 8:
                                        nh3_HValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 9:
                                        no2Value2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 10:
                                        no2_LValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 11:
                                        no2_MValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 12:
                                        no2_HValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 13:
                                        coValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 14:
                                        co_LValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 15:
                                        co_MValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 16:
                                        co_HValue2 = BitConverter.ToSingle(rData, 0);
                                        break;
                                }
                                break;
                            case 0x500291AEBE4D:
                                switch (i)
                                {
                                    case 0:
                                        temValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 1:
                                        humValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 2:
                                        co2Value3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 3:
                                        luxValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 4:
                                        uvValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 5:
                                        nh3Value3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 6:
                                        nh3_LValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 7:
                                        nh3_MValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 8:
                                        nh3_HValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 9:
                                        no2Value3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 10:
                                        no2_LValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 11:
                                        no2_MValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 12:
                                        no2_HValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 13:
                                        coValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 14:
                                        co_LValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 15:
                                        co_MValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                    case 16:
                                        co_HValue3 = BitConverter.ToSingle(rData, 0);
                                        break;
                                }
                                break;
                        }
                    }
                }

            }
            var influxDBClient = InfluxDBClientFactory.Create("http://localhost:8086", "jrGSUa8nVpoSqLvIpqebtcgXPsu3cyh6nlCWVUFHf8Sa1FsE5sVsNXXEa-3X-y4KsO0iyb8e6MICbPxOMt5dyg==");
            String[] sensorList = new string[17] {
                "tem_",
                "hum_",
                "co2_",
                "lux_",
                "uv_",
                "nh3_",
                "nh3_L_",
                "nh3_M_",
                "nh3_H_",
                "no2_",
                "no2_L_",
                "no2_M_",
                "no2_H_",
                "co_",
                "co_L_",
                "co_M_",
                "co_H_",
            };

            float?[] valueList1 = new float?[17] {
                temValue1,
                humValue1,
                co2Value1,
                luxValue1,
                uvValue1,
                nh3Value1,
                nh3_LValue1,
                nh3_MValue1,
                nh3_HValue1,
                no2Value1,
                no2_LValue1,
                no2_MValue1,
                no2_HValue1,
                coValue1,
                co_LValue1,
                co_MValue1,
                co_HValue1
            };

            float?[] valueList2 = new float?[17] {
                temValue2,
                humValue2,
                co2Value2,
                luxValue2,
                uvValue2,
                nh3Value2,
                nh3_LValue2,
                nh3_MValue2,
                nh3_HValue2,
                no2Value2,
                no2_LValue2,
                no2_MValue2,
                no2_HValue2,
                coValue2,
                co_LValue2,
                co_MValue2,
                co_HValue2
            };

            float?[] valueList3 = new float?[17] {
                temValue3,
                humValue3,
                co2Value3,
                luxValue3,
                uvValue3,
                nh3Value3,
                nh3_LValue3,
                nh3_MValue3,
                nh3_HValue3,
                no2Value3,
                no2_LValue3,
                no2_MValue3,
                no2_HValue3,
                coValue3,
                co_LValue3,
                co_MValue3,
                co_HValue3
            };

            String[] numberList = new string[3]
            {
                "1",
                "2",
                "3"
            };

            if (deviceId == 0x24A16057F685)
            {
                for (int i = 0; i < sensorList.Length; i++)
                {
                    if (valueList1[i] != null)
                    {
                        this.Invoke((MethodInvoker)delegate ()
                        {
                            ListViewItem lvi = new ListViewItem(sensorList[i] + numberList[0]);
                            lvi.SubItems.Add(valueList1[i].ToString());
                            listView1.Items.Add(lvi);
                        });
                        

                        using (var writeApi = influxDBClient.GetWriteApi())
                        {
                            var point = PointData.Measurement(sensorList[i] + numberList[0])
                                .Field("value", (float)valueList1[i]);

                            writeApi.WritePoint("farmcare", "saltanb", point);
                        }


                    }
                }
            }
            else if (deviceId == 0x500291AEBCD9)
            {
                for (int i = 0; i < sensorList.Length; i++)
                {
                    if (valueList2[i] != null)
                    {
                        this.Invoke((MethodInvoker)delegate ()
                        {
                            ListViewItem lvi = new ListViewItem(sensorList[i] + numberList[1]);
                            lvi.SubItems.Add(valueList2[i].ToString());
                            listView2.Items.Add(lvi);
                        });

                        using (var writeApi = influxDBClient.GetWriteApi())
                        {
                            var point = PointData.Measurement(sensorList[i] + numberList[1])
                                .Field("value", (float)valueList2[i]);


                            writeApi.WritePoint("farmcare", "saltanb", point);

                        }



                    }
                }
            }
            else if (deviceId == 0x500291AEBE4D)
            {
                for (int i = 0; i < sensorList.Length; i++)
                {
                    if (valueList1[i] != null)
                    {
                        this.Invoke((MethodInvoker)delegate ()
                        {
                            ListViewItem lvi = new ListViewItem(sensorList[i] + numberList[2]);
                            lvi.SubItems.Add(valueList3[i].ToString());
                            listView3.Items.Add(lvi);
                        });

                        using (var writeApi = influxDBClient.GetWriteApi())
                        {
                            var point = PointData.Measurement(sensorList[i] + numberList[2])
                                .Field("value", (float)valueList3[i]);


                            writeApi.WritePoint("farmcare", "saltanb", point);
                        }

                    }
                }
            }


        }

        private void sensor1_Click(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                listView1.Items.Clear();
            });
            rtuMessageTrue();
            byte protocol = 100;
            UInt16 clientID = --TxClient;
            uint sequenceNumber = 0;
            byte[] data = new byte[] { 0x01, 0x03, 0x00, 0xCB, 0x00, 0x52, 0xAD, 0xDE };

            rtuLink.RequestStream.WriteAsync(new RtuMessage
            {
                Channel = ((UInt32)clientID << 8) | protocol,
                SequenceNumber = sequenceNumber,
                GwId = 0,
                DeviceId = 0x24A16057F685,
                DataUnit = ByteString.CopyFrom(data[0..data.Length])
            });
        }

        private void sensor2_Click(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                listView2.Items.Clear();
            });
            rtuMessageTrue();
            byte protocol = 100;
            UInt16 clientID = --TxClient;
            uint sequenceNumber = 0;
            byte[] data = new byte[] { 0x01, 0x03, 0x00, 0xCB, 0x00, 0x52, 0xAD, 0xDE };

            rtuLink.RequestStream.WriteAsync(new RtuMessage
            {
                Channel = ((UInt32)clientID << 8) | protocol,
                SequenceNumber = sequenceNumber,
                GwId = 0,
                DeviceId = 0x500291AEBCD9,
                DataUnit = ByteString.CopyFrom(data[0..data.Length])
            });
        }

        private void sensor3_Click(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                listView3.Items.Clear();
            });
            rtuMessageTrue();
            byte protocol = 100;
            UInt16 clientID = --TxClient;
            uint sequenceNumber = 0;
            byte[] data = new byte[] { 0x01, 0x03, 0x00, 0xCB, 0x00, 0x52, 0xAD, 0xDE };

            rtuLink.RequestStream.WriteAsync(new RtuMessage
            {
                Channel = ((UInt32)clientID << 8) | protocol,
                SequenceNumber = sequenceNumber,
                GwId = 0,
                DeviceId = 0x500291AEBE4D,
                DataUnit = ByteString.CopyFrom(data[0..data.Length])
            });
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                listView1.Items.Clear();
            });
            rtuMessageTrue();
            byte protocol = 100;
            UInt16 clientID = --TxClient;
            uint sequenceNumber = 0;
            byte[] data = new byte[] { 0x01, 0x03, 0x00, 0xCB, 0x00, 0x52, 0xAD, 0xDE };

            rtuLink.RequestStream.WriteAsync(new RtuMessage
            {
                Channel = ((UInt32)clientID << 8) | protocol,
                SequenceNumber = sequenceNumber,
                GwId = 0,
                DeviceId = 0x24A16057F685,
                DataUnit = ByteString.CopyFrom(data[0..data.Length])
            });
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                listView2.Items.Clear();
            });
            rtuMessageTrue();
            byte protocol = 100;
            UInt16 clientID = --TxClient;
            uint sequenceNumber = 0;
            byte[] data = new byte[] { 0x01, 0x03, 0x00, 0xCB, 0x00, 0x52, 0xAD, 0xDE };

            rtuLink.RequestStream.WriteAsync(new RtuMessage
            {
                Channel = ((UInt32)clientID << 8) | protocol,
                SequenceNumber = sequenceNumber,
                GwId = 0,
                DeviceId = 0x500291AEBCD9,
                DataUnit = ByteString.CopyFrom(data[0..data.Length])
            });
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                listView3.Items.Clear();
            });
            rtuMessageTrue();
            byte protocol = 100;
            UInt16 clientID = --TxClient;
            uint sequenceNumber = 0;
            byte[] data = new byte[] { 0x01, 0x03, 0x00, 0xCB, 0x00, 0x52, 0xAD, 0xDE };

            rtuLink.RequestStream.WriteAsync(new RtuMessage
            {
                Channel = ((UInt32)clientID << 8) | protocol,
                SequenceNumber = sequenceNumber,
                GwId = 0,
                DeviceId = 0x500291AEBE4D,
                DataUnit = ByteString.CopyFrom(data[0..data.Length])
            });
        }

        private void richTextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            timer1.Interval = (Convert.ToInt32(textBox1.Text)) * 1000;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            timer2.Interval = (Convert.ToInt32(textBox2.Text)) * 1000;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            timer3.Interval = (Convert.ToInt32(textBox3.Text))*1000;
        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(char.IsDigit(e.KeyChar)|| e.KeyChar == Convert.ToChar(Keys.Back)))
            {
                e.Handled = true;
            }
        }

        private void textBox2_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(char.IsDigit(e.KeyChar) || e.KeyChar == Convert.ToChar(Keys.Back)))
            {
                e.Handled = true;
            }
        }

        private void textBox3_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(char.IsDigit(e.KeyChar) || e.KeyChar == Convert.ToChar(Keys.Back)))
            {
                e.Handled = true;
            }
        }

    }
}