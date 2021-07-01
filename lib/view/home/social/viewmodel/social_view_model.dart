import 'package:flutter/material.dart';
import 'package:folder_architecture/core/base/model/base_view_model.dart';
import 'package:folder_architecture/view/home/social/model/query/friend_query.dart';
import 'package:folder_architecture/view/home/social/model/social_user_model.dart';
import 'package:folder_architecture/view/home/social/service/ISocialService.dart';
import 'package:folder_architecture/view/home/social/service/social_service.dart';
import 'package:mobx/mobx.dart';
part 'social_view_model.g.dart';

class SoicalViewModel = _SoicalViewModelBase with _$SoicalViewModel;

abstract class _SoicalViewModelBase with Store, BaseViewModel {
  late ISocialService _socialService;
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    _socialService = SocialService(vexanaManager!.networkManager);
    fetchAllUsers();
  }

  @observable
  bool isLoading = false;

  @observable
  List<SocialUser> socialUserList = [];

  @action
  Future<void> fetchAllUsers() async {
    isLoadingChange();
    final response = await _socialService.fetchUserHouseList(FriendQuery(limit: 1), context!);
    socialUserList = response;
    isLoadingChange();
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }
}
