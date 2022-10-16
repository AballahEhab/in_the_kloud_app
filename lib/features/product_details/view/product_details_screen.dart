import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/core/app/SizeConfig.dart';
import 'package:in_the_kloud_app/features/home/models/product_model.dart';
import 'package:in_the_kloud_app/features/product_details/provider/product_details_provider.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);
  static const route = '/products-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int? productId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailsProvider>().getProductDetails(productId!);
    });
  }

  SizeConfig initSizeConfig(BuildContext context) =>
      SizeConfig()..initWithRatio(context: context, designWidth: 428.5);

  @override
  Widget build(BuildContext context) {
    productId ??= ModalRoute.of(context)!.settings.arguments as int;

    SizeConfig sizeConfig = initSizeConfig(context);

    bool isLoading = context
        .select<ProductDetailsProvider, bool>((provider) => provider.isLoading);

    return Scaffold(
        backgroundColor: AppColors.White,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : _PageContent(sizeConfig: sizeConfig));
  }

  void navigateBackToHomeScreen() {
    Navigator.pop(context);
  }
}

class _PageContent extends StatelessWidget {
  final SizeConfig sizeConfig;

  const _PageContent({required this.sizeConfig, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = context.select<ProductDetailsProvider, Product>(
        (provider) => provider.productDetails!);

    return Column(
      children: [
        Expanded(
          child: _ProductDetails(sizeConfig: sizeConfig, product: product),
        ),
        _CountBottomBarWithTotal(sizeConfig: sizeConfig, product: product),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final SizeConfig sizeConfig;
  final Product product;

  const _ProductDetails(
      {required this.sizeConfig, required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: sizeConfig.toDynamicUnit(353.2),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: sizeConfig.toDynamicUnit(60),
                  bottom: sizeConfig.toDynamicUnit(39)),
              child: Swiper(
                itemBuilder: (context, index) {
                  return Image.network(
                    product.images![index],
                    fit: BoxFit.contain,
                  );
                },
                // autoplay: true,
                itemCount: (product.images?.length)!,
                scrollDirection: Axis.horizontal,
                pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: SwiperPagination.rect),
                control: SwiperControl(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeConfig.toDynamicUnit(25)),
                ),
              ),
            )),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(sizeConfig.toDynamicUnit(20))),
                gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.productDetaDescBoxGrad1,
                      AppColors.Green
                    ])),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: sizeConfig.toDynamicUnit(15),
                    bottom: sizeConfig.toDynamicUnit(19),
                    left: sizeConfig.toDynamicUnit(31),
                    right: sizeConfig.toDynamicUnit(21),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.title!,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500,color: AppColors.White,fontSize: sizeConfig.toDynamicUnit(20.5)),),
                      Text('${product.price} USD',style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500,color: AppColors.White,fontSize: sizeConfig.toDynamicUnit(20.5))),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: sizeConfig.toDynamicUnit(10),
                      left: sizeConfig.toDynamicUnit(31),
                      right: sizeConfig.toDynamicUnit(16),
                    ),
                    child: Text(product.description!,style:Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: AppColors.White,fontSize: sizeConfig.toDynamicUnit(16)),),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CountBottomBarWithTotal extends StatelessWidget {
  const _CountBottomBarWithTotal({
    Key? key,
    required this.sizeConfig,
    required this.product,
  }) : super(key: key);

  final SizeConfig sizeConfig;
  final Product product;

  @override
  Widget build(BuildContext context) {
    Tuple2<int, int> tuple = context.select<AppProvider, Tuple2<int, int>>(
        (provider) => Tuple2<int, int>(
            provider.getProductQuantityByProductId(product),
            provider.getProductTotalByProductId(product)));

    int quantity = tuple.item1;
    int total = tuple.item2;

    return SizedBox(
      height: sizeConfig.toDynamicUnit(79),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: sizeConfig.toDynamicUnit(170.5),
            height: sizeConfig.toDynamicUnit(79),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(sizeConfig.toDynamicUnit(20))),
                gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.productDetaCountBoxGrad1,
                      AppColors.productDetaCountBoxGrad2
                    ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<AppProvider>()
                        .decrementQuantityByProduct(product);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: sizeConfig.toDynamicUnit(15),
                    child: Icon(Icons.remove),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(sizeConfig.toDynamicUnit(16)),
                  child: Text('$quantity',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.White,
                          fontSize: sizeConfig.toDynamicUnit(18.29),
                          fontWeight: FontWeight.w500)),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<AppProvider>()
                        .incrementQuantityByProduct(product);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: sizeConfig.toDynamicUnit(15),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: sizeConfig.toDynamicUnit(258),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(sizeConfig.toDynamicUnit(20))),
                gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.White,
                      AppColors.productDetaTotalBoxGrad
                    ])),
            child: Center(
              child: Text('Total $total USD',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.Green,
                      fontSize: sizeConfig.toDynamicUnit(18.29),
                      fontWeight: FontWeight.w500)),
            ),
          )
        ],
      ),
    );
  }
}
