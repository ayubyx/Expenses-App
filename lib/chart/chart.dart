//import 'dart:developer';
import 'package:expenses_app/chart/chart_bar.dart';
import 'package:expenses_app/model/expense.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Chart extends StatelessWidget {
  Chart(this.expenses, {super.key});

  List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.education),
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.transportation),
      ExpenseBucket.forCategory(expenses, Category.travle),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double maxTotalExpense() {
    double maxtotalexpense = 0;
    for (var bucket in buckets) {
      if (bucket.totalExpenses() > maxtotalexpense) {
        maxtotalexpense = bucket.totalExpenses();
      }
    }
    return maxtotalexpense;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(builder: (cntx, constraint) {
      //log(constraint.maxWidth.toString());
      //log(constraint.minWidth.toString());
      //log(constraint.maxHeight.toString());
      //log(constraint.maxHeight.toString());
      return Container(
          height: constraint.maxHeight,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.0),
              ])),
          child: Column(children: [
            Expanded(
                child: Row(
              children: [
                // ignore: unused_local_variable
                for (final element in buckets)
                  ChartBar(
                    fill: element.totalExpenses() == 0
                        ? 0
                        : element.totalExpenses() / maxTotalExpense(),
                  )
              ],
            )),
            const SizedBox(height: 10),
            constraint.minHeight < 100
                ? Container()
                : Row(
                    children: [
                      ...buckets.map(
                        (bucket) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(categoryIcon[bucket.category],
                                color: isDarkMode
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(
                                          0.7,
                                        )),
                          ),
                        ),
                      ),
                    ],
                  ),
          ]));
    });
  }
}
