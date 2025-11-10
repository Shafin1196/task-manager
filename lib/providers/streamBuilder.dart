import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final cpuInfoCmd = 'top -bn1 | grep "Cpu(s)"';
Map<String, double> cpuInfoList = {};
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
