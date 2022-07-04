part of 'package:smart_stress/imports.dart';

const String testID = 'access_history';

class Subscription extends StatefulWidget {
  Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final controller = Get.put(SubscriptionController());

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

      _subscription = _iap.purchaseStream.listen((data) => setState(() {
            _purchases.addAll(data);
            _verifyPurchases();
          }));
    }
  }

  // Method to retrieve product list
  Future<void> _getUserProducts() async {
    Set<String> ids = {testID};
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    setState(() {
      _products = response.productDetails;
    });
  }

  // Method to retrieve users past purchase
  Future<void> _getPastPurchases() async {
    _subscription = _iap.purchaseStream.listen((data) => setState(() {
          _purchases.addAll(data);
          for (PurchaseDetails purchase in _purchases) {
            if (purchase.productID == 'access_history') {
              //SOLUTION

              if (Platform.isIOS && purchase.pendingCompletePurchase) {
                InAppPurchase.instance.completePurchase(purchase);
              }
            }
          }
        }));
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
    }
  }

  // Method to purchase a product
  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    _iap.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    // cancelling the subscription
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: shadePrimary,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
        ),
      ),
      body: Container(
        height: size,
        width: double.infinity,
        color: shadePrimary,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Image.asset(
              "assets/images/premium.png",
              height: 80,
              width: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              "Welcome to Daily+\nPremium!",
              style: theme.textTheme.bodyText2!
                  .copyWith(fontSize: 24, color: blackColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 10),
            child: Text(
              "You are now getting the best of the app",
              style: theme.textTheme.bodyText2!
                  .copyWith(fontSize: 16, color: blackColor),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Image.asset(
                "assets/images/measure.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                "Unlimited measurements per day",
                style: theme.textTheme.bodyText2!
                    .copyWith(fontSize: 14, color: blackColor),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Image.asset(
                "assets/images/calendar.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                "History in calendar view",
                style: theme.textTheme.bodyText2!
                    .copyWith(fontSize: 14, color: blackColor),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ListTile(
              leading: Image.asset(
                "assets/images/pgraph.png",
                height: 20,
                width: 20,
              ),
              title: Text(
                "Trending graph for periodic monitoring",
                style: theme.textTheme.bodyText2!
                    .copyWith(fontSize: 14, color: blackColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 34),
            child: CustomButton(
              label: Text(
                _products.isEmpty ? "" : "${_products[0].price}/Month",
                style: theme.textTheme.bodyText2!
                    .copyWith(fontSize: 18, color: blackColor),
              ),
              onPress: () {},
              buttoncolor: cardLightColor,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 34),
            child: CustomButton(
              label: Text(
                "Subscribe now",
                style: theme.textTheme.bodyText1!
                    .copyWith(fontSize: 18, color: cardLightColor),
              ),
              onPress: () async {
                clearTransactionsIos();
                for (var product in _products) {
                  if (product.id.isNotEmpty && product.id == "access_history") {
                    _buyProduct(product);
                    
                  }
                }
                controller.getUserId();
              },
              buttoncolor: primaryTwoColor,
              height: 50,
            ),
          )
        ]),
      ),
    );
  }

  Future<void> clearTransactionsIos() async {
    if (Platform.isIOS) {
      final transactions = await SKPaymentQueueWrapper().transactions();
      transactions.forEach((transaction) async {
        await SKPaymentQueueWrapper().finishTransaction(transaction);
      });
    }
  }
}
