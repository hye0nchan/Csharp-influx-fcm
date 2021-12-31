// ignore_for_file: unnecessary_statements

import 'package:influxdb_client/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm_dashboard/widgets/stats_grid.dart';

import 'data.dart';

class AddInfluxDB {
  void tem1AddInfluxDB() async {
    var tem1InfluxValue = double.parse(sensor1redTemData);
    var temperature1Influx = Point('tem_1')
        .addField('value', tem1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(temperature1Influx);
  }

  void tem2AddInfluxDB() async {
    var tem2InfluxValue = double.parse(sensor2redTemData);
    var temperature2Influx = Point('tem_2')
        .addField('value', tem2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(temperature2Influx);
  }

  void tem3AddInfluxDB() async {
    var tem3InfluxValue = double.parse(sensor3redTemData);
    var temperature3Influx = Point('tem_3')
        .addField('value', tem3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(temperature3Influx);
  }

  void hum1AddInfluxDB() async {
    var hum1InfluxValue = double.parse(sensor1redHumData);
    var hum1Influx = Point('hum_1')
        .addField('value', hum1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(hum1Influx);
  }

  void hum2AddInfluxDB() async {
    var hum2InfluxValue = double.parse(sensor2redHumData);
    var hum2Influx = Point('hum_2')
        .addField('value', hum2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(hum2Influx);
  }

  void hum3AddInfluxDB() async {
    var hum3InfluxValue = double.parse(sensor3redHumData);
    var hum3Influx = Point('hum_3')
        .addField('value', hum3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(hum3Influx);
  }

  void co21AddInfluxDB() async {
    var co21InfluxValue = double.parse(sensor1redCo2Data);
    var co21Influx = Point('co2_1')
        .addField('value', co21InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(co21Influx);
  }

  void co22AddInfluxDB() async {
    var co22InfluxValue = double.parse(sensor2redCo2Data);
    var co22Influx = Point('co2_2')
        .addField('value', co22InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(co22Influx);
  }

  void co23AddInfluxDB() async {
    var co23InfluxValue = double.parse(sensor3redCo2Data);
    var co23Influx = Point('co2_3')
        .addField('value', co23InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(co23Influx);
  }

  void lux1AddInfluxDB() async {
    var lux1InfluxValue = double.parse(sensor1redLuxData);
    var lux1Influx = Point('lux_1')
        .addField('value', lux1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(lux1Influx);
  }

  void lux2AddInfluxDB() async {
    var lux2InfluxValue = double.parse(sensor2redLuxData);
    var lux2Influx = Point('lux_2')
        .addField('value', lux2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(lux2Influx);
  }

  void lux3AddInfluxDB() async {
    var lux3InfluxValue = double.parse(sensor3redLuxData);
    var lux3Influx = Point('lux_3')
        .addField('value', lux3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(lux3Influx);
  }

  void uv1AddInfluxDB() async {
    var uv1InfluxValue = double.parse(sensor1redUvData);
    var uv1Influx = Point('uv_1')
        .addField('value', uv1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(uv1Influx);
  }

  void uv2AddInfluxDB() async {
    var uv2InfluxValue = double.parse(sensor2redUvData);
    var uv2Influx = Point('uv_2')
        .addField('value', uv2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(uv2Influx);
  }

  void uv3AddInfluxDB() async {
    var uv3InfluxValue = double.parse(sensor1redUvData);
    var uv3Influx = Point('uv_3')
        .addField('value', uv3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(uv3Influx);
  }

  void nh31AddInfluxDB() async {
    var nh31InfluxValue = double.parse(sensor1redNh3Data);
    var nh31Influx = Point('nh3_1')
        .addField('value', nh31InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh31Influx);
  }

  void nh32AddInfluxDB() async {
    var nh32InfluxValue = double.parse(sensor2redNh3Data);
    var nh32Influx = Point('nh3_2')
        .addField('value', nh32InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh32Influx);
  }

  void nh33AddInfluxDB() async {
    var nh33InfluxValue = double.parse(sensor3redNh3Data);
    var nh33Influx = Point('nh3_3')
        .addField('value', nh33InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh33Influx);
  }

  void nh3L1AddInfluxDB() async {
    var nh3L1InfluxValue = double.parse(sensor1redNh3LData);
    var nh3L1Influx = Point('nh3L_1')
        .addField('value', nh3L1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3L1Influx);
  }

  void nh3L2AddInfluxDB() async {
    var nh3L2InfluxValue = double.parse(sensor2redNh3LData);
    var nh3L2Influx = Point('nh3L_2')
        .addField('value', nh3L2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3L2Influx);
  }

  void nh3L3AddInfluxDB() async {
    var nh3L3InfluxValue = double.parse(sensor1redNh3LData);
    var nh3L3Influx = Point('nh3L_3')
        .addField('value', nh3L3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3L3Influx);
  }

  void nh3M1AddInfluxDB() async {
    var nh3M1InfluxValue = double.parse(sensor1redNh3MData);
    var nh3M1Influx = Point('nh3M_1')
        .addField('value', nh3M1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3M1Influx);
  }

  void nh3M2AddInfluxDB() async {
    var nh3M2InfluxValue = double.parse(sensor2redNh3MData);
    var nh3M2Influx = Point('nh3M_2')
        .addField('value', nh3M2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3M2Influx);
  }

  void nh3M3AddInfluxDB() async {
    var nh3M3InfluxValue = double.parse(sensor3redNh3MData);
    var nh3M3Influx = Point('nh3M_3')
        .addField('value', nh3M3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3M3Influx);
  }

  void nh3H1AddInfluxDB() async {
    var nh3H1InfluxValue = double.parse(sensor1redNh3HData);
    var nh3H1Influx = Point('nh3H_1')
        .addField('value', nh3H1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3H1Influx);
  }

  void nh3H2AddInfluxDB() async {
    var nh3H2InfluxValue = double.parse(sensor2redNh3HData);
    var nh3H2Influx = Point('nh3H_2')
        .addField('value', nh3H2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3H2Influx);
  }

  void nh3H3AddInfluxDB() async {
    var nh3H3InfluxValue = double.parse(sensor3redNh3HData);
    var nh3H3Influx = Point('nh3H_3')
        .addField('value', nh3H3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(nh3H3Influx);
  }

  void no21AddInfluxDB() async {
    var no21InfluxValue = double.parse(sensor1redNo2HData);
    var no21Influx = Point('no2_1')
        .addField('value', no21InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no21Influx);
  }

  void no22AddInfluxDB() async {
    var no22InfluxValue = double.parse(sensor2redNo2HData);
    var no22Influx = Point('no2_2')
        .addField('value', no22InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no22Influx);
  }

  void no23AddInfluxDB() async {
    var no21InfluxValue = double.parse(sensor3redNo2HData);
    var no21Influx = Point('no2_3')
        .addField('value', no21InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no21Influx);
  }

  void no2L1AddInfluxDB() async {
    var no2L1InfluxValue = double.parse(sensor1redNo2LData);
    var no2L1Influx = Point('no2L_1')
        .addField('value', no2L1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2L1Influx);
  }

  void no2L2AddInfluxDB() async {
    var no2L2InfluxValue = double.parse(sensor2redNo2LData);
    var no2L2Influx = Point('no2L_2')
        .addField('value', no2L2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2L2Influx);
  }

  void no2L3AddInfluxDB() async {
    var no2L3InfluxValue = double.parse(sensor3redNo2LData);
    var no2L3Influx = Point('no2L_3')
        .addField('value', no2L3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2L3Influx);
  }

  void no2M1AddInfluxDB() async {
    var no2M1InfluxValue = double.parse(sensor1redNo2MData);
    var no2M1Influx = Point('no2M_1')
        .addField('value', no2M1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2M1Influx);
  }

  void no2M2AddInfluxDB() async {
    var no2M2InfluxValue = double.parse(sensor2redNo2MData);
    var no2M2Influx = Point('no2M_2')
        .addField('value', no2M2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2M2Influx);
  }

  void no2M3AddInfluxDB() async {
    var no2M3InfluxValue = double.parse(sensor3redNo2MData);
    var no2M3Influx = Point('no2M_3')
        .addField('value', no2M3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2M3Influx);
  }

  void no2H1AddInfluxDB() async {
    var no2H1InfluxValue = double.parse(sensor1redNo2HData);
    var no2H1Influx = Point('no2H_1')
        .addField('value', no2H1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2H1Influx);
  }

  void no2H2AddInfluxDB() async {
    var no2H2InfluxValue = double.parse(sensor2redNo2HData);
    var no2H2Influx = Point('no2H_2')
        .addField('value', no2H2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2H2Influx);
  }

  void no2H3AddInfluxDB() async {
    var no2H3InfluxValue = double.parse(sensor3redNo2HData);
    var no2H3Influx = Point('no2H_3')
        .addField('value', no2H3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(no2H3Influx);
  }

  void co1AddInfluxDB() async {
    var co1InfluxValue = double.parse(sensor1redCoData);
    var co1Influx = Point('co_1')
        .addField('value', co1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(co1Influx);
  }

  void co2AddInfluxDB() async {
    var co2InfluxValue = double.parse(sensor2redCoData);
    var co2Influx = Point('co_2')
        .addField('value', co2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(co2Influx);
  }

  void co3AddInfluxDB() async {
    var co3InfluxValue = double.parse(sensor3redCoData);
    var co3Influx = Point('co_3')
        .addField('value', co3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(co3Influx);
  }

  void coL1AddInfluxDB() async {
    var coL1InfluxValue = double.parse(sensor1redCoLData);
    var coL1Influx = Point('coL_1')
        .addField('value', coL1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coL1Influx);
  }

  void coL2AddInfluxDB() async {
    var coL2InfluxValue = double.parse(sensor2redCoLData);
    var coL2Influx = Point('coL_2')
        .addField('value', coL2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coL2Influx);
  }

  void coL3AddInfluxDB() async {
    var coL3InfluxValue = double.parse(sensor3redCoLData);
    var coL3Influx = Point('coH_3')
        .addField('value', coL3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coL3Influx);
  }

  void coM1AddInfluxDB() async {
    var coM1InfluxValue = double.parse(sensor1redCoMData);
    var coM1Influx = Point('coM_1')
        .addField('value', coM1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coM1Influx);
  }

  void coM2AddInfluxDB() async {
    var coM2InfluxValue = double.parse(sensor2redCoMData);
    var coM2Influx = Point('coM_2')
        .addField('value', coM2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coM2Influx);
  }

  void coM3AddInfluxDB() async {
    var coM3InfluxValue = double.parse(sensor3redCoMData);
    var coM3Influx = Point('coM_3')
        .addField('value', coM3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coM3Influx);
  }

  void coH1AddInfluxDB() async {
    var coH1InfluxValue = double.parse(sensor1redCoHData);
    var coH1Influx = Point('coH_1')
        .addField('value', coH1InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coH1Influx);
  }

  void coH2AddInfluxDB() async {
    var coH2InfluxValue = double.parse(sensor2redCoHData);
    var coH2Influx = Point('coH_2')
        .addField('value', coH2InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coH2Influx);
  }

  void coH3AddInfluxDB() async {
    var coH3InfluxValue = double.parse(sensor3redCoHData);
    var coH3Influx = Point('coH_3')
        .addField('value', coH3InfluxValue)
        .time(DateTime.now().toUtc());
    await writeApi.write(coH3Influx);
  }
}
