import 'package:expenses_app/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewExpense extends StatefulWidget {
  void Function(Expense) onAddExpense;
  NewExpense(this.onAddExpense, {super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecntroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? selectedDate;
  final formatter = DateFormat.yMd();
  Category selectedCategory = Category.food;

  @override
  void dispose() {
    super.dispose();
    _titlecntroller.dispose();
    _amountcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              maxLength: 50,
              controller: _titlecntroller,
              decoration: const InputDecoration(
                label: Text(
                  "Title",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 50,
                    controller: _amountcontroller,
                    decoration: const InputDecoration(
                      label: Text(
                        "Amount",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      prefixText: '\$',
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      selectedDate == null
                          ? "No date selected"
                          : formatter.format(selectedDate!),
                    ),
                    IconButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final firstDate =
                              DateTime(now.year - 1, now.month, now.day);
                          final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              firstDate: firstDate,
                              lastDate: now);
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        },
                        icon: const Icon(Icons.calendar_month))
                  ],
                ))
              ],
            ),
            DropdownButton(
              dropdownColor: isDarkMode
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer.withOpacity(
                        0.8,
                      ),
              items: Category.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              value: selectedCategory,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    )),
                //? validation
                ElevatedButton(
                    onPressed: () {
                      final entredAmount =
                          double.tryParse(_amountcontroller.text);
                      final bool amountisInvalid =
                          entredAmount == null || entredAmount <= 0;
                      if (_titlecntroller.text.trim().isEmpty ||
                          amountisInvalid ||
                          selectedDate == null) {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text("Invalid input"),
                                content: const Text(
                                    "please make sure you entred all the fields!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text("Okay"))
                                ],
                              );
                            });
                      } else {
                        widget.onAddExpense(Expense(
                            title: _titlecntroller.text,
                            amount: entredAmount,
                            date: selectedDate!,
                            category: selectedCategory));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save Expense")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
