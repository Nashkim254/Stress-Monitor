part of 'package:smart_stress/imports.dart';

class SubscriptionController extends GetxController {
  // InAppPurchase _iap = InAppPurchase.instance;
  bool available = true;
  var isSubscribed = false.obs;
  String userId = '';
  String platformId = "";
  String email = "";
  String uploadLimit = "";
  String paidAt = DateTime.now().toString();
  var expiresAt = DateTime.now();
   var token = "".obs;

  final String testID = 'access_history';
  // List<String> myProductID = ["access_history"];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoggedin = true.obs;
  var _isLoading = false.obs;

  Future getUserId() async {
    final SharedPreferences prefs = await _prefs;
    isLoggedin.value = prefs.getBool("isSubscribed") ?? false;
    userId = prefs.getString("userId")!;
    platformId = prefs.getString("platformId")!;
    token.value = prefs.getString("token")!;
    Future.delayed(const Duration(seconds: 3), () {
//TODO
        subscriptionMethod(SubscribeModel(
            user_id: controller.userId,
            paid_at: _purchases[0].transactionDate ?? DateTime.now().toString(),
            expires_at: expiresAt.add(const Duration(days: 30)).toString(),
            amount: "9.99",
            platform_id: controller.platformId),
            token.value
            );
        prefs.setBool("isSubscribed", true);
      
    });

    return;
  }

  Future subscriptionMethod(SubscribeModel modelData,String token) async {
    _isLoading(true);
    ResponseModel response = await postSubscription(modelData,token);
    _isLoading(false);
    if (response.code == 200) {
      _isLoading(false);
      Get.off(CalendarView());
    } else if (response.code == 401) {
        Get.dialog(ConfirmDialog(
           color: errorColor,
        message: response.data["message"],
        onPressed: ()=>Get.back(),
      ));
    } else {
        Get.dialog(ConfirmDialog(
           color: errorColor,
        message: response.data["message"],
        onPressed: ()=>Get.back(),
      ));
      _isLoading(false);
    }
    update();
  }

  @override
  void onInit() {
    getUserId();
    _initialize();
    super.onInit();
  }

  // Instantiates inAppPurchase
  final InAppPurchase _iap = InAppPurchase.instance;

  // checks if the API is available on this device
  bool _isAvailable = false;

  // keeps a list of products queried from Playstore or app store
  List<ProductDetails> _products = [];

  // List of users past purchases
  List<PurchaseDetails> _purchases = [];

  // subscription that listens to a stream of updates to purchase details
  late StreamSubscription _subscription;

  // used to represents consumable credits the user can buy

  Future<void> _initialize() async {
    // Check availability of InApp Purchases
    _isAvailable = await _iap.isAvailable();
    // perform our async calls only when in-app purchase is available
    if (_isAvailable) {
      await _getUserProducts();
      await _getPastPurchases();
      _verifyPurchases();

      // listen to new purchases and rebuild the widget whenever
      // there is a new purchase after adding the new purchase to our
      // purchase list

      _subscription =
          _iap.purchaseStream.listen((data) => _purchases.addAll(data));
      _verifyPurchases();
      update();
    }
  }

  // Method to retrieve product list
  Future<void> _getUserProducts() async {
    Set<String> ids = {testID};
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    _products = response.productDetails;
    update();
  }

  // Method to retrieve users past purchase
  Future<void> _getPastPurchases() async {
    _subscription =
        _iap.purchaseStream.listen((data) => _purchases.addAll(data));
    for (PurchaseDetails purchase in _purchases) {
      if (purchase.productID == 'access_history') {
        //SOLUTION
        if (Platform.isIOS) {
          InAppPurchase.instance.completePurchase(purchase);
        }
      }
    }
    update();
  }

  // checks if a user has purchased a certain product
  PurchaseDetails _hasUserPurchased(String productID) {
    return _purchases.firstWhere((purchase) => purchase.productID == productID);
  }

  // Method to check if the product has been purchased already or not.
  void _verifyPurchases() {
    PurchaseDetails purchase = _hasUserPurchased(testID);
    if (purchase.status == PurchaseStatus.purchased) {
//TODO
      subscriptionMethod(SubscribeModel(
          user_id: controller.userId,
          paid_at: purchase.transactionDate,
          expires_at:  expiresAt.add(const Duration(days: 30)).toString(),
          amount: "9.99",
          platform_id: controller.platformId),
          token.value
          );
    }
  }

  // Method to purchase a product
  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }
}
