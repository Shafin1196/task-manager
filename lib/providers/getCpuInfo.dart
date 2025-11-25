

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/legacy.dart';
final modelCmd='cat /proc/cpuinfo | grep "model name" | head -1';

final cpuProvider=FutureProvider<Map<String,String> >((ref)async{
  final file = File('/proc/cpuinfo');
  final lines = await file.readAsLines();

  List<Map<String, String>> cpus = []; 
  Map<String, String> cpu = {};        

  for (var line in lines) {
   
    if (line.trim().isEmpty) {
      if (cpu.isNotEmpty) {
        cpus.add(Map.from(cpu)); 
        cpu.clear();             
      }
    } else {
      
      var parts = line.split(':');
      if (parts.length == 2) {
        cpu[parts[0].trim()] = parts[1].trim(); 
      }
    }
  }

  if (cpu.isNotEmpty) cpus.add(cpu);
  return cpus[0];
});

final selectProvider=StateProvider<String>((ref){
return "cpu";
});