import 'dart:io';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final cpuInfoCmd = 'top -bn1 | grep "Cpu(s)"';
final ramInfoCmd='''
free -h | awk '/Mem:/ {
  for(i=2;i<=NF;i++) {
    if(\$i ~ /Gi\$/) {
      val = substr(\$i, 1, length(\$i)-2);
      printf "%s ", val;
    } else if(\$i ~ /Mi\$/) {
      val = substr(\$i, 1, length(\$i)-2);
      printf "%.2f ", val/1024;
    }
  }
  print "";
}'
''';

Map<String, double> cpuInfoList = {};
Map<String, String> ramInfoList = {};
void assignValueOnCpuInfoList(String values) {
  values = values.replaceFirst('%Cpu(s): ', '');
  String unitvalues = values.replaceAll(RegExp(r'[0-9.\s]'), '');
  values = values.replaceAll(RegExp(r'[a-zA-Z]'), '');
  values = values.replaceAll(" ", '');
  List<String> sublist = values.split(',');
  List<String> sublistUnit = unitvalues.split(',');
  for (int i = 0; i < sublist.length; i++) {
    cpuInfoList[sublistUnit[i]] = double.tryParse(sublist[i])!;
  }
}

final cpuBuilder = StreamProvider<Map<String, double>>((ref) async* {
  while (true) {
    String _cmd = cpuInfoCmd;
    ProcessResult result = await Process.run('bash', ['-c', _cmd]);
    assignValueOnCpuInfoList(result.stdout);
    yield Map<String, double>.from(cpuInfoList);
    await Future.delayed(Duration(seconds: 1));
  }
});
void assignValueOnRamInfoList(String values) {
  List<String> sublist=values.split(' ');
  ramInfoList['total']=sublist[0];
  ramInfoList['used']=sublist[1];
  ramInfoList['free']=sublist[2];
  ramInfoList['shared']=sublist[3];
  ramInfoList['cache']=sublist[4];
  ramInfoList['available']=sublist[5];

}
final ramBuilder=StreamProvider<Map<String,String>>((ref)async*{
  while(true){
  String _cmd=ramInfoCmd;
  ProcessResult result=await Process.run('bash', ['-c', _cmd]);
  assignValueOnRamInfoList(result.stdout);
  // print(ramInfoList);
  yield Map<String, String>.from(ramInfoList);
  await Future.delayed(Duration(seconds: 1));
  }
});

final networkBuilder=StreamProvider<Map<String,double>>((ref)async*{
  final result=await Process.start('ifstat', ['-i', 'enp0s3', '1']);
  int i=2;
  double max=100;
  await for(var line in result.stdout.transform(SystemEncoding().decoder)){
    if(i>0){
      i--;
      continue;
    }
    line=line.trim(); 
    if(line.isEmpty)continue;
    final values=line.split(RegExp(r'\s+'));
    if(values.length>=2){
      double down=double.tryParse(values[0])?? 0;
      double up=double.tryParse(values[1])?? 0;
      double throughPut=down+up;
      double checkMax=ceilTo(throughPut);
      checkMax>max?max=checkMax:max=max;
      yield {'down':down,"up":up,"throughPut":throughPut,"max":max};
    }
  }
});

double ceilTo(double value){
  if(value<=0)return 100;
  int length=value.ceil().toString().length;
  double  base=pow(10,length).toDouble();
  return base;
  

}