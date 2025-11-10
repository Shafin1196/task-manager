

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/legacy.dart';
final modelCmd='cat /proc/cpuinfo | grep "model name" | head -1';
final cpuInfoCmd='top -bn1 | grep "Cpu(s)"';

final cpuProvider=FutureProvider<String >((ref)async{
  String _cmd=modelCmd;
  ProcessResult result=await Process.run('bash', ['-c', _cmd]);
  String name=result.stdout;
  return name.replaceFirst('model name	: ', '');
});

final selectProvider=StateProvider<String>((ref){
return "cpu";
});