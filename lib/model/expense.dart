import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();
final datetime = DateFormat.yMd();

enum Category { food, travle, transportation, leisure, work, education }

const categoryIcon = {
  Category.food: Icons.restaurant,
  Category.travle: Icons.airplanemode_active,
  Category.transportation: Icons.emoji_transportation_outlined,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.education: Icons.screenshot_monitor_outlined
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  String get formatDate {
    return datetime.format(date);
  }
}

class ExpenseBucket {
  Category category;
  List<Expense> expenses;

  ExpenseBucket(this.category, this.expenses);
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

      double totalExpenses(){
        double sum = 0;
        for (var expense in expenses) {
          sum += expense.amount;
        }
        return sum;
      }      
}
