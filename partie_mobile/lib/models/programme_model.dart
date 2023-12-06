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

    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));

    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));

    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteOrange.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));

    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteRouge.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));
    programmes.add(ProgrammeModel(
      priorite: "assets/icons/prioriteVerte.svg",
      horaire: "15:00-16:00",
      nom: "Imprimante",
      lieu: "Technopole",
    ));

    return programmes;
  }
}
