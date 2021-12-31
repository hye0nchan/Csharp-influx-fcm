using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using Google.Apis.Auth.OAuth2;
using Google.Cloud.Firestore;
using InfluxDB.Client;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;

//influxDB Client UI 수정

namespace WFormsUserApp
{
    internal partial class Form1 : Form
    {
        //FCM 으로 보낼 Token List 선언
        List<string> registrationTokens = new List<string>()
        {
        };
        int timerInterval = 600000;

        float[] fcmArray = new float[51];
        string[] fcmStringArray = new string[51];
        string fcmMessage = "";
        int count = 0;

        Timer tem1Timer = new Timer();
        Timer tem2Timer = new Timer();
        Timer tem3Timer = new Timer();


        internal Form1()
        {
            InitializeComponent();
            //시작시 초기화 및 토큰 가져오기
            Initialize_FCM();
        }
        async void Initialize_FCM()
        {
            //Google Credential 초기화
            FirebaseApp.Create(new AppOptions()
            {
                Credential = GoogleCredential.FromFile("C:/Users/Administrator/Desktop/C#FCM/UnitaryTester-FCM/hometestproject-f01e6-firebase-adminsdk-z0oga-3d3578f7d5.json"),
            });

            // 환경변수 초기화
            string path = AppDomain.CurrentDomain.BaseDirectory + @"hometestproject-f01e6-firebase-adminsdk-z0oga-3d3578f7d5.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);

            //device가 저장될 변수 선언
            List<String> deviceList = new List<string> { };

            //db 변수 선언
            FirestoreDb db;

            //db 변수 초기화
            db = FirestoreDb.Create("hometestproject-f01e6");

            //Collection이 Token인 모든 문서 가져오기
            Query allCitiesQuery = db.Collection("Token");
            QuerySnapshot allCitiesQuerySnapshot = await allCitiesQuery.GetSnapshotAsync();
            foreach (DocumentSnapshot documentSnapshot in allCitiesQuerySnapshot.Documents)
            {
                Dictionary<string, object> city = documentSnapshot.ToDictionary();
                foreach (KeyValuePair<string, object> pair in city)
                {
                    //가져온 토큰 device List에 저장0
                    if (!deviceList.Contains(pair.Value.ToString()))
                    {
                        deviceList.Add(pair.Value.ToString());
                    }
                }
            }

            //Token List에 가져온 Device Token 넣기
            for (int i = 0; i < deviceList.Count; i++)
            {
                if (!registrationTokens.Contains(deviceList[i]))
                {
                    registrationTokens.Add(deviceList[i]);
                }

            }

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            readInfluxData();

            //FCM 초기화 및 타이머 설정 (10분), 600000
            FCM_Timer.Start();
            FCM_Timer.Interval = timerInterval;
        }

        void test()
        {
            List<string> sensorList = new List<string> { "tem_" };
            int i = 1;
            var testString = $"r._measurement == \"{sensorList[0]}{i}\"";
            Debug.WriteLine(testString);
        }

        private async void FCM_Timer_Tick(object sender, EventArgs e)
        {
            //device가 저장될 변수 선언
            List<String> deviceList = new List<string> { };

            //db 변수 선언
            FirestoreDb db;

            //db 변수 초기화
            db = FirestoreDb.Create("hometestproject-f01e6");

            //Collection이 Token인 모든 문서 가져오기
            Query allCitiesQuery = db.Collection("Token");
            QuerySnapshot allCitiesQuerySnapshot = await allCitiesQuery.GetSnapshotAsync();
            foreach (DocumentSnapshot documentSnapshot in allCitiesQuerySnapshot.Documents)
            {
                Dictionary<string, object> city = documentSnapshot.ToDictionary();
                foreach (KeyValuePair<string, object> pair in city)
                {
                    //가져온 토큰 device List에 저장0
                    if (!deviceList.Contains(pair.Value.ToString()))
                    {
                        deviceList.Add(pair.Value.ToString());
                    }
                }
            }

            //Token List에 가져온 Device Token 넣기
            for (int i = 0; i < deviceList.Count; i++)
            {
                if (!registrationTokens.Contains(deviceList[i]))
                {

                    registrationTokens.Add(deviceList[i]);
                }
            }

            readInfluxData();
        }


        async void readInfluxData()
        {
            //데이터 저장될 배열 선언
            float[] valueArray = new float[51];

            //for문에 사용될 배열
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

            // IP, Token 초기화
            var influxDBClient = InfluxDBClientFactory.Create("http://localhost:8086", "jrGSUa8nVpoSqLvIpqebtcgXPsu3cyh6nlCWVUFHf8Sa1FsE5sVsNXXEa-3X-y4KsO0iyb8e6MICbPxOMt5dyg==");

            float value = 0;
            var measurement = "measurement";

            // flux Query
            for (int i = 0; i < sensorList.Length; i++)
            {
                var Flux = "from(bucket:\"farmcare\") " +
       "|> range(start: -4m) " +
       "|> filter(fn: (r) => " +
       $"r._measurement == \"{sensorList[i]}1\" and " +
       "r._value > -50)";

                // + org
                var fluxTables = await influxDBClient.GetQueryApi().QueryAsync(Flux, "saltanb");

                // Query에 있는 Data 수집
                fluxTables.ForEach(fluxTable =>
                {
                    // 행 수집
                    var fluxRecords = fluxTable.Records;
                    fluxRecords.ForEach(fluxRecord =>
                    {
                        // object -> float
                        float fTest = (float)(double)fluxRecord.GetValue();
                        measurement = fluxRecord.GetMeasurement();
                        value = fTest;
                    });


                });
                fcmArray[i] = value;
                fcmStringArray[i] = measurement;
                sendFCM(measurement,value);

            }

            for (int i = 0; i < sensorList.Length; i++)
            {
                var Flux = "from(bucket:\"farmcare\") " +
       "|> range(start: -4m) " +
       "|> filter(fn: (r) => " +
       $"r._measurement == \"{sensorList[i]}2\" and " +
       "r._value > -50)";

                // + org
                var fluxTables = await influxDBClient.GetQueryApi().QueryAsync(Flux, "saltanb");

                // Query에 있는 Data 수집
                fluxTables.ForEach(fluxTable =>
                {
                    // 행 수집
                    var fluxRecords = fluxTable.Records;
                    fluxRecords.ForEach(fluxRecord =>
                    {
                        // object -> float
                        float fTest = (float)(double)fluxRecord.GetValue();
                        measurement = fluxRecord.GetMeasurement();
                        value = fTest;

                    });


                });
                fcmArray[i + 16] = value;
                fcmStringArray[i + 16] = measurement;
            }


            for (int i = 0; i < sensorList.Length; i++)
            {
                var Flux = "from(bucket:\"farmcare\") " +
       "|> range(start: -4m) " +
       "|> filter(fn: (r) => " +
       $"r._measurement == \"{sensorList[i]}3\" and " +
       "r._value > -50)";

                // + org
                var fluxTables = await influxDBClient.GetQueryApi().QueryAsync(Flux, "saltanb");

                // Query에 있는 Data 수집
                fluxTables.ForEach(fluxTable =>
                {
                    // 행 수집
                    var fluxRecords = fluxTable.Records;
                    fluxRecords.ForEach(fluxRecord =>
                    {
                        // object -> float
                        float fTest = (float)(double)fluxRecord.GetValue();
                        measurement = fluxRecord.GetMeasurement();
                        value = fTest;

                    });


                });
                fcmArray[i + 32] = value;
                fcmStringArray[i + 32] = measurement;
            }

            for(int i = 0; i < fcmArray.Length; i++)
            {
                Debug.WriteLine(fcmArray[i]);
            }

            
            for (int i = 0; i < fcmArray.Length; i++)
            {
                switch (i)
                {
                    case 0:
                    case 16:
                    case 32:
                        if (fcmArray[i] > 25)
                        {
                            switch (i)
                            {
                                //timer 기본 루프
                                case 0:
                                    if (tem1Timer.Enabled)
                                    {
                                        tem1Timer.Stop();
                                        fcmStringArray[i] = measurement;
                                    }
                                    tem1Timer.Start();
                                    tem1Timer.Interval = timerInterval;
                                    fcmStringArray[i] = "tem_1";
                                    tem1Timer.Interval = 180000;
                                    tem1Timer.Start();
                                    break;
                                case 16:
                                    tem2Timer.Interval = 180000;
                                    tem2Timer.Start();
                                    break;
                                case 32:
                                    tem3Timer.Interval = 180000;
                                    tem3Timer.Start();
                                    break;
                            }
                        }
                        break;
                }
                /*
                if (fcmMessage.Contains(fcmStringArray[i]))
                {
                    //listbox에 추가
                }
                */


            }
            //sendFCM(fcmMessage, count);
            
            sendFCM("test", 25);

        }

        async void sendFCM(string sensor, float value)
        {
            string[] splitMessage = fcmMessage.Split(",");

            // FCM에 보낼 메시지 초기화
            var message = new MulticastMessage()
            {
                Notification = new Notification
                {
                    Title = sensor,
                    Body = value.ToString(),
                },
                Tokens = registrationTokens,
            };

            //FCM 전송
            _ = await FirebaseMessaging.DefaultInstance.SendMulticastAsync(message);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Invoke((MethodInvoker)delegate ()
            {
                FCM_Timer.Interval = Convert.ToInt32(textBox1.Text);

            });
        }
    }
}
