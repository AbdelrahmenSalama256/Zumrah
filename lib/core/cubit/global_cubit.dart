import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zumrah/core/constants/app_constant.dart';
import 'package:zumrah/core/network/local_network.dart';
import 'package:zumrah/core/services/service_locator.dart';

import 'global_state.dart';

class SimpleContact {
  final String name;
  final String email;
  final String mobile;
  final XFile? image;

  SimpleContact({
    required this.name,
    required this.email,
    required this.mobile,
    this.image,
  });

  SimpleContact copyWith({
    String? name,
    String? email,
    String? mobile,
    XFile? image,
  }) {
    return SimpleContact(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      image: image ?? this.image,
    );
  }
}

class CartItem {
  final String productId;
  final int quantity;
  final int variationId;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.variationId,
  });
}

//! GlobalCubit
class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  int currentNavIndex = 0;
  final ScrollController controller = ScrollController();

  String language = sl<CacheHelper>().getCachedLanguage();
  String currencyCode = "EGP";
  String currencySymbol = "LE";

  SimpleContact? profile;
  final List<CartItem> cartItems = [];
  final Set<String> wishlistProductIds = {};

  void init() {
    _initCurrency();
    getProfile();
  }

  void changeBottomNavIndex(int index) {
    if (currentNavIndex != index) {
      currentNavIndex = index;
      emit(BottomNavChangeState());
    }
  }

  Future<void> changeLanguage() async {
    emit(LanguageChangingState());
    await Future.delayed(const Duration(milliseconds: 300));
    final newLanguage =
        sl<CacheHelper>().getCachedLanguage() == "en" ? "ar" : "en";
    await sl<CacheHelper>().cacheLanguage(newLanguage);
    language = newLanguage;
    emit(LanguageChangedState());
  }

  void updateToken(String token) {
    final cacheHelper = sl<CacheHelper>();
    cacheHelper.setData(AppConstants.token, token);
    emit(GlobalTokenUpdated());
  }

  bool get isAuthenticated {
    final token = sl<CacheHelper>().getDataString(key: AppConstants.token);
    return token != null && token.isNotEmpty;
  }

  void _initCurrency() {
    final cache = sl<CacheHelper>();
    final cachedCode = cache.getDataString(key: AppConstants.currencyCode);
    final cachedSymbol = cache.getDataString(key: AppConstants.currencySymbol);
    if (cachedCode != null && cachedCode.isNotEmpty) {
      currencyCode = cachedCode;
    }
    if (cachedSymbol != null && cachedSymbol.isNotEmpty) {
      currencySymbol = cachedSymbol;
    } else {
      currencySymbol = _defaultSymbolForCodeAscii(currencyCode);
    }
  }

  void changeCurrency({required String code, String? symbol}) {
    currencyCode = code;
    currencySymbol = symbol ?? _defaultSymbolForCodeAscii(code);
    final cache = sl<CacheHelper>();
    cache.setData(AppConstants.currencyCode, currencyCode);
    cache.setData(AppConstants.currencySymbol, currencySymbol);
    emit(CurrencyChangedState(currencyCode, currencySymbol));
  }

  String _defaultSymbolForCodeAscii(String code) {
    switch (code.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EGP':
        return 'EGP';
      case 'SAR':
        return 'SAR';
      case 'AED':
        return 'AED';
      case 'EUR':
        return 'EUR';
      case 'GBP':
        return 'GBP';
      default:
        return '\$';
    }
  }

  Future<void> getProfile({bool forceRefresh = false}) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    profile ??= SimpleContact(
      name: 'Guest User',
      email: 'guest@example.com',
      mobile: '',
    );
    emit(ProfileLoaded());
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? mobile,
    XFile? image,
  }) async {
    emit(ProfileUpdating());
    await Future.delayed(const Duration(milliseconds: 500));
    final current = profile ??
        SimpleContact(
          name: 'Guest User',
          email: 'guest@example.com',
          mobile: '',
        );
    profile = current.copyWith(
      name: name,
      email: email,
      mobile: mobile,
      image: image ?? current.image,
    );
    emit(ProfileUpdated());
    emit(ProfileLoaded());
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    profile = null;
    cartItems.clear();
    wishlistProductIds.clear();
    final cacheHelper = sl<CacheHelper>();
    cacheHelper.removeData(key: AppConstants.userProfile);
    cacheHelper.removeData(key: AppConstants.token);
    currentNavIndex = 0;
    emit(LogoutSuccess('logout_success'));
  }

  Future<void> addToCart(
      {required String productId,
      required int quantity,
      required int variation}) async {
    emit(CartLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    cartItems.add(CartItem(
        productId: productId, quantity: quantity, variationId: variation));
    emit(CartLoaded());
  }

  Future<void> addtowishlist({required String productId}) async {
    emit(WishlistLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    wishlistProductIds.add(productId);
    emit(WishlistSuccess('wishlist_item_added'));
    emit(WishlistStatusChanged(productId: productId, isFavourite: true));
  }

  Future<void> removeFromWishlist(int id, {String? productId}) async {
    emit(RemoveWishlistLoading());
    final key = productId ?? id.toString();
    await Future.delayed(const Duration(milliseconds: 300));
    final removed = wishlistProductIds.remove(key);
    if (!removed) {
      emit(WishlistItemRemovedError('wishlist_item_not_found'));
      return;
    }
    emit(WishlistItemRemovedSuccess('wishlist_item_removed'));
    emit(WishlistStatusChanged(productId: key, isFavourite: false));
  }

  Future<void> removeProductFromWishlistByProductId(String productId) async {
    await removeFromWishlist(0, productId: productId);
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
