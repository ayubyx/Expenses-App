import 'package:expenses_app/main.dart';
import 'package:expenses_app/model/expense.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpensesList extends StatelessWidget {
  void Function(Expense) onRemoveExpense;
  ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: expenses.length,
        itemBuilder: (context, i) {
          return Dismissible(
            background: Container(
              color: myColorScheme.error.withOpacity(0.9),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            key: ValueKey(expenses[i]),
            child: ExpensesItem(expense: expenses[i]),
            onDismissed: (direction) => onRemoveExpense(expenses[i]),
          );
        });
  }
}
