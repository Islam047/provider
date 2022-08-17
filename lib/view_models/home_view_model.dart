import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../pages/detail_page.dart';
import '../services/network_service.dart';

class HomeViewModel extends ChangeNotifier {
  List<Post> items = [];
  bool isLoading = false;

  Future apiPostList() async {
    isLoading = true;
    notifyListeners();
    String? response =
        await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();

    String? response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());

    isLoading = false;
    notifyListeners();
    return response != null;
  }

  void goToDetailPage(BuildContext context) async {
    String? response =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const DetailPage(
        state: DetailState.create,
      );
    }));
    if (response == "add") {
      apiPostList();
    }
  }

  void goToDetailPageUpdate(Post post, BuildContext context) async {
    String? response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DetailPage(
            post: post,
            state: DetailState.update,
          );
        },
      ),
    );
    if (response == "refresh") {
      apiPostList();
    }
  }
}
