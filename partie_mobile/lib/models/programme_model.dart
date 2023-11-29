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

    return programmes;
  }
}

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
        name: 'Salad',
        iconPath: 'assets/icons/plate.svg',
        boxColor: const Color(0xff9DCEFF)));

    categories.add(CategoryModel(
        name: 'Cake',
        iconPath: 'assets/icons/pancakes.svg',
        boxColor: const Color(0xffEEA4CE)));

    categories.add(CategoryModel(
        name: 'Pie',
        iconPath: 'assets/icons/pie.svg',
        boxColor: const Color(0xff9DCEFF)));

    categories.add(CategoryModel(
        name: 'Smoothies',
        iconPath: 'assets/icons/orange-snacks.svg',
        boxColor: const Color(0xffEEA4CE)));

    return categories;
  }
}
