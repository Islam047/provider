import 'package:learn_provider/example/model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyParentWidget extends StatelessWidget {
  const MyParentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: ChangeNotifierProvider(
        create: (_) => MyModel(26, "Gordon"),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
            children:  const [
              MyCounterWidget(),
              SizedBox(height:20,),
              MyNameWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCounterWidget extends StatelessWidget {
  const MyCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final myModel = context.watch<MyModel>();
    int counter = context.select<MyModel, int>((myModel) => myModel.counter);
    return Column(
      children: [
        Text(counter.toString()),
        ElevatedButton(
          onPressed: context.read<MyModel>().increment,
          child: const Text("Increment"),
        )
      ],
    );
  }
}
/// With consumer
// class MyNameWidget extends StatelessWidget {
//   const MyNameWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MyModel>(
//       builder: (context, myModel, child) {
//         return Column(
//           children: <Widget>[
//             Text(myModel.name),
//             child!,
//           ],
//         );
//       },
//       child: const MySuperExpensiveWidget(),
//     );
//   }
// }

class MyNameWidget extends StatelessWidget {
  const MyNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MyModel, String>(
      selector: (context, model) => model.name,
      builder: (context, name, child) {
        return Column(
          children: [
            Text(name),
            child!,
          ],
        );
      },
      child: const MySuperExpensiveWidget(),
    );
  }
}

class MySuperExpensiveWidget extends StatelessWidget {
  const MySuperExpensiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      onPressed: () {
        context.read<MyModel>().changeName("Updated name");
      },
      child: const Text(" Change Name"),
    );
  }
}
