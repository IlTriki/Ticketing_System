import 'package:flutter/material.dart';

class ProgrammeModel {
  String priorite;
  String horaire;
  String nom;
  String lieu;

  ProgrammeModel({
    required this.priorite,
    required this.horaire,
    required this.nom,
    required this.lieu,
  });

  static List<ProgrammeModel> getProgrammes() {
    List<ProgrammeModel> programmes = [];
    return programmes;
  }
}
