import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';
import 'widgets/calculator_display.dart';
import 'widgets/scientific_keypad.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: CalculatorDisplay(
                expression: viewModel.expression,
                result: viewModel.result,
                error: viewModel.error,
              ),
            ),
            Expanded(
              flex: 5,
              child: ScientificKeypad(
                onKeyPressed: viewModel.handleKeyPress,
                onClear: viewModel.clearAll,
                onDelete: viewModel.delete,
                onCalculate: viewModel.calculate,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
