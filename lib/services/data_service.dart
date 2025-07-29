import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:crossapp/models/wod.dart';
import 'package:crossapp/models/athlete.dart';

class DataService {
  Future<List<WOD>> getWODs() async {
    final String response = await rootBundle.loadString('lib/data/wods.json');
    final data = await json.decode(response) as List;
    return data.map((json) => WOD.fromJson(json)).toList();
  }

  Future<List<Athlete>> getAthletes() async {
    final String response = await rootBundle.loadString('lib/data/athletes.json');
    final data = await json.decode(response) as List;
    return data.map((json) => Athlete.fromJson(json)).toList();
  }
}
