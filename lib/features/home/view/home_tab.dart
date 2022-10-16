import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/core/app/SizeConfig.dart';
import 'package:in_the_kloud_app/core/base/models/cart_item.dart';
import 'package:in_the_kloud_app/features/home/models/product_model.dart';
import 'package:in_the_kloud_app/features/home/provider/products_provider.dart';
import 'package:in_the_kloud_app/features/product_details/view/product_details_screen.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:in_the_kloud_app/resources/constants.dart';
import 'package:in_the_kloud_app/resources/strings.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  SizeConfig initSizeConfig(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()
      ..initWithRatio(context: context, designWidth: 600);
    return sizeConfig;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = initSizeConfig(context);

    Tuple2<bool, bool> loadingData =
        context.select<ProductsProvider, Tuple2<bool, bool>>((provider) =>
            Tuple2<bool, bool>(
                provider.isCategoriesLoading, provider.isProductsLoading));

    bool isCategoriesLoading = loadingData.item1;
    bool isProductsLoading = loadingData.item2;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _SearchContainer(sizeConfig: sizeConfig),
        Container(
          margin: EdgeInsets.only(top: sizeConfig.toDynamicUnit(25.6)),
          padding: EdgeInsets.only(left: sizeConfig.toDynamicUnit(44.8)),
          height: sizeConfig.toDynamicUnit(25.6),
          width: double.infinity,
          color: AppColors.lighterGray,
          child: const Text('Category'),
        ),
        SizedBox(
          height: sizeConfig.toDynamicUnit(89.6),
          child: (isCategoriesLoading)
              ? const Center(child: CircularProgressIndicator())
              : _CategoryList(sizeConfig: sizeConfig),
        ),
        Container(
          padding: EdgeInsets.only(left: sizeConfig.toDynamicUnit(44.8)),
          height: sizeConfig.toDynamicUnit(25.6),
          width: double.infinity,
          color: AppColors.lighterGray,
          child: const Text('Products'),
        ),
        isProductsLoading
            ? const CircularProgressIndicator()
            : _ProductsGrid(sizeConfig: sizeConfig),
      ],
    );
  }
}

class _SearchContainer extends StatelessWidget {
  final SizeConfig sizeConfig;

  const _SearchContainer({
    required this.sizeConfig,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: sizeConfig.toDynamicUnit(119),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: AppColors.SearchBoxGradiantColors),
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.all(Constants.$15px),
        child: Container(
          padding: EdgeInsets.only(left: Constants.$8px, right: Constants.$8px),
          decoration: BoxDecoration(
            color: AppColors.lynxWhite,
            borderRadius: BorderRadius.all(Constants.SearchBoxRadius),
          ),
          child: TextField(
              style: Theme.of(context).textTheme.labelLarge,
              decoration: const InputDecoration(
                hintText: AppStrings.searchProductsHindText,
                icon: Icon(
                  size: Constants.AppCustomSearchBarIconSize,
                  Icons.search_rounded,
                ),
              ),
              obscuringCharacter: AppStrings.obscuringTextFieldCharacter,
              onChanged: (text) =>
                  context.read<ProductsProvider>().searchForProduct(text)),
        ));
  }
}

class _CategoryList extends StatelessWidget {
  final SizeConfig sizeConfig;

  const _CategoryList({
    required this.sizeConfig,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tuple2<int, int> tuple = context.select<ProductsProvider, Tuple2<int, int>>(
        (provider) => Tuple2<int, int>(
            provider.getNumOfCategories(), provider.selectedCategoryIndex));

    int numOfCategories = tuple.item1;
    int selectedCategoryIndex = tuple.item2;

    return ListView.builder(
        padding: EdgeInsets.only(
            top: sizeConfig.toDynamicUnit(16.8),
            left: sizeConfig.toDynamicUnit(43.2),
            right: sizeConfig.toDynamicUnit(43.2),
            bottom: sizeConfig.toDynamicUnit(21.6)),
        scrollDirection: Axis.horizontal,
        itemCount: numOfCategories + 1,
        itemBuilder: (context, index) => _CategoryItem(
            sizeConfig: sizeConfig,
            index: index - 1,
            isSelected: index - 1 == selectedCategoryIndex));
  }
}

class _CategoryItem extends StatelessWidget {
  final SizeConfig sizeConfig;
  final int index;
  final bool isSelected;

  const _CategoryItem({
    required this.sizeConfig,
    required this.index,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryName = context.select<ProductsProvider, String>(
        (provider) => provider.getCategoryByIndex(index));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.toDynamicUnit(15.2)),
      child: SizedBox(
        height: sizeConfig.toDynamicUnit(51.2),
        child: ChoiceChip(
          selected: isSelected,
          selectedColor: AppColors.Green,
          labelStyle: (isSelected)
              ? TextStyle(
                  color: AppColors.lynxWhite, fontWeight: FontWeight.w600)
              : TextStyle(color: AppColors.Green, fontWeight: FontWeight.w600),
          backgroundColor: AppColors.lynxWhite,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.$35px),
              side: BorderSide(color: AppColors.Green)),
          onSelected: (isSelected) => {
            if (isSelected)
              context.read<ProductsProvider>().setCategorySelected(index)
          },
          label: Text(
            categoryName,
            style: (isSelected)
                ? TextStyle(
                    color: AppColors.lynxWhite, fontWeight: FontWeight.w600)
                : TextStyle(
                    color: AppColors.Green, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  final SizeConfig sizeConfig;

  const _ProductsGrid({
    required this.sizeConfig,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numOfProducts = context.select<ProductsProvider, int>(
        (provider) => provider.getNumOfProducts());

    return Expanded(
        child: GridView.count(
      padding: EdgeInsets.only(
          left: sizeConfig.toDynamicUnit(27.2),
          right: sizeConfig.toDynamicUnit(25.6)),
      childAspectRatio:
          sizeConfig.toDynamicUnit(236.8) / sizeConfig.toDynamicUnit(344),
      scrollDirection: Axis.vertical,
      crossAxisCount: Constants.GridCrossAxisCount,
      children: List.generate(
        numOfProducts,
        (index) => _ProductItem(index: index, sizeConfig: sizeConfig),
      ),
    ));
  }
}

class _ProductItem extends StatelessWidget {
  final int index;
  final SizeConfig sizeConfig;

  const _ProductItem({
    required this.index,
    required this.sizeConfig,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = context.select<ProductsProvider, Product>(
        (provider) => provider.getProductByIndex(index));

    return Padding(
      padding: EdgeInsets.only(
        right: sizeConfig.toDynamicUnit(18.4),
        top: sizeConfig.toDynamicUnit(24),
        bottom: sizeConfig.toDynamicUnit(24),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            top: sizeConfig.toDynamicUnit(18.4),
            left: sizeConfig.toDynamicUnit(18.4),
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: sizeConfig.toDynamicUnit(236.8),
              height: sizeConfig.toDynamicUnit(344),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(Constants.$20px),
                      bottomLeft: Radius.circular(Constants.$20px)),
                  border: Border.all(color: AppColors.Green)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: sizeConfig.toDynamicUnit(7)),
                      child: Image.network(
                        height: sizeConfig.toDynamicUnit(178),
                        fit: BoxFit.contain,
                        product.thumbnail ??
                            'https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large.jpg',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateToProductDetails(context, product.id!);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: sizeConfig.toDynamicUnit(3.6),
                        top: sizeConfig.toDynamicUnit(5),
                        left: sizeConfig.toDynamicUnit(15),
                        right: sizeConfig.toDynamicUnit(15),
                      ),
                      height: sizeConfig.toDynamicUnit(34),
                      child: Center(
                        child: Text(product.title!,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  Divider(height: sizeConfig.toDynamicUnit(1.6)),
                  Container(
                      margin: EdgeInsets.only(
                        bottom: sizeConfig.toDynamicUnit(9.2),
                        top: sizeConfig.toDynamicUnit(10.4),
                      ),
                      height: sizeConfig.toDynamicUnit(34),
                      child: Center(child: Text('\$ ${product.price} USD'))),
                  ProductCardBottomButton(
                    sizeConfig: sizeConfig,
                    product: product,
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: product.discountPercentage != null,
            child: Container(
              width: sizeConfig.toDynamicUnit(91.2),
              height: sizeConfig.toDynamicUnit(44.8),
              decoration: const BoxDecoration(
                  color: AppColors.darkRed,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Center(
                  child: Text('${product.discountPercentage}%',
                      style: TextStyle(color: AppColors.White))),
            ),
          )
        ],
      ),
    );
  }

  void navigateToProductDetails(BuildContext context, int productId) {
    Navigator.pushNamed(context, ProductDetailsScreen.route,
        arguments: productId);
  }
}

class ProductCardBottomButton extends StatelessWidget {
  final SizeConfig sizeConfig;
  final Product product;

  const ProductCardBottomButton(
      {required this.sizeConfig, required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItem? cartItem = context.select<AppProvider, CartItem?>(
        (provider) => provider.getItemFromCartByProductId(product.id!));

    return cartItem != null
        ? Container(
            height: sizeConfig.toDynamicUnit(70.4),
            decoration: BoxDecoration(
                color: AppColors.Green,
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.productAddToCartButtonColor2,
                      AppColors.Green,
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
                    child: Icon(
                      Icons.remove,
                      size: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(sizeConfig.toDynamicUnit(16)),
                  child: ProductCountInCart(
                      product: product, sizeConfig: sizeConfig),
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
                    child: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          )
        : InkWell(
            onTap: () {
              context.read<AppProvider>().incrementQuantityByProduct(product);
            },
            child: Container(
              height: sizeConfig.toDynamicUnit(70.4),
              decoration: BoxDecoration(
                  color: AppColors.Green,
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.productAddToCartButtonColor2,
                        AppColors.Green,
                      ])),
              child: const Center(
                  child: Text(
                'ADD TO CART',
                style: TextStyle(color: AppColors.White),
              )),
            ),
          );
  }
}

class ProductCountInCart extends StatelessWidget {
  const ProductCountInCart({
    Key? key,
    required this.product,
    required this.sizeConfig,
  }) : super(key: key);

  final Product? product;
  final SizeConfig sizeConfig;

  @override
  Widget build(BuildContext context) {
    int quantity = context.select<AppProvider, int>(
        (provider) => provider.getProductQuantityByProductId(product!));

    return Text('$quantity',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.White,
            fontSize: sizeConfig.toDynamicUnit(18.29),
            fontWeight: FontWeight.w500));
  }
}
