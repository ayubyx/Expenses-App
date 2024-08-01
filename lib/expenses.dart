import 'package:expenses_app/chart/chart.dart';
import 'package:expenses_app/model/expense.dart';
import 'package:expenses_app/new_expense.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registredExpenses = [];

  void addExpense(Expense expense) {
    setState(() {
      registredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      registredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size.width;
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses tracker app",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: mq < 600
          ? Center(
              child: Column(
                children: [
                  Expanded(child: Chart(registredExpenses)),
                  Expanded(
                    child: ExpensesList(
                      expenses: registredExpenses,
                      onRemoveExpense: removeExpense,
                    ),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                Expanded(child: Chart(registredExpenses)),
                Expanded(
                  child: ExpensesList(
                    expenses: registredExpenses,
                    onRemoveExpense: removeExpense,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: isDarkMode
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(
                  0.6,
                ),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: isDarkMode
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer.withOpacity(
                        1,
                      ),
              context: context,
              builder: (ctx) => NewExpense(addExpense));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
