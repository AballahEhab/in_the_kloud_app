import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/core/app/SizeConfig.dart';
import 'package:in_the_kloud_app/core/base/models/cart_item.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:in_the_kloud_app/resources/constants.dart';
import 'package:provider/provider.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  SizeConfig initSizeConfig(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()
      ..initWithRatio(context: context, designWidth: 600);
    return sizeConfig;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = initSizeConfig(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: sizeConfig.toDynamicUnit(15),
            bottom: sizeConfig.toDynamicUnit(40),
            top: sizeConfig.toDynamicUnit(40),
          ),
          child: Text('Cart',style:Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.cartPageTitleColor,fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: _CartList(
            sizeConfig: sizeConfig,
          ),
        ),
        _TotalContainer(sizeConfig: sizeConfig),
        SizedBox(height: sizeConfig.toDynamicUnit(118.4))
      ],
    );
  }
}

class _CartList extends StatelessWidget {
  final SizeConfig sizeConfig;

  const _CartList({required this.sizeConfig, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numOfCartItems = context.select<AppProvider, int>(
        (provider) => provider.getNumOfCartProducts());

    return ListView.builder(
        itemCount: numOfCartItems,
        itemBuilder: (context, index) => _CartListItem(
            sizeConfig: sizeConfig,
            cartItem:
                context.read<AppProvider>().getItemFromCartByIndex(index)));
  }
}

class _CartListItem extends StatelessWidget {
  final SizeConfig sizeConfig;
  final CartItem cartItem;

  const _CartListItem(
      {required this.sizeConfig, required this.cartItem, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CartItem cartItem = context.select<AppProvider, CartItem>(
    //     (provider) => provider.getItemFromCartByIndex(index));
    return Container(
      margin: EdgeInsets.only(
        bottom: sizeConfig.toDynamicUnit(31),
        left: sizeConfig.toDynamicUnit(20),
        right: sizeConfig.toDynamicUnit(20),
      ),
      width: sizeConfig.toDynamicUnit(559),
      height: sizeConfig.toDynamicUnit(127),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(sizeConfig.toDynamicUnit(27)),
              bottomLeft: Radius.circular(sizeConfig.toDynamicUnit(27))),
          border: Border.all(color: AppColors.Green),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.cartItemBoxGrad1, AppColors.White]),
          boxShadow: Constants.SingInBoxShadow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: sizeConfig.toDynamicUnit(16),
              bottom: sizeConfig.toDynamicUnit(14.4),
              top: sizeConfig.toDynamicUnit(12.61),
            ),
            width: sizeConfig.toDynamicUnit(96),
            height: sizeConfig.toDynamicUnit(96),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(sizeConfig.toDynamicUnit(11)))),
            child: Image.network(
              height: sizeConfig.toDynamicUnit(178),
              fit: BoxFit.contain,
              cartItem.product.thumbnail ??
                  'https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large.jpg',
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: sizeConfig.toDynamicUnit(5),
                bottom: sizeConfig.toDynamicUnit(15),
                top: sizeConfig.toDynamicUnit(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.product.title!,style:Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.DarkGrey)),
                  SizedBox(height: sizeConfig.toDynamicUnit(5)),
                  Text('${cartItem.product.price} USD x ${cartItem.quantity}',style:Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.Green))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(sizeConfig.toDynamicUnit(9)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total',style:Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.DarkGrey)),
                Text(' ${cartItem.totalPrice} USD',style:Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.Green,fontWeight:FontWeight.w500)),
                InkWell(
                  onTap: () {
                    context.read<AppProvider>().removeItemFromCart(cartItem);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.White,
                        borderRadius: BorderRadius.all(
                            Radius.circular(sizeConfig.toDynamicUnit(13))),
                        border: Border.all(color: AppColors.darkRed)),
                    padding: EdgeInsets.only(
                      left: sizeConfig.toDynamicUnit(10.5),
                      right: sizeConfig.toDynamicUnit(10.5),
                    ),
                    child: Text(
                      'Remove',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppColors.darkRed),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalContainer extends StatelessWidget {
  final SizeConfig sizeConfig;

  const _TotalContainer({required this.sizeConfig, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = context
        .select<AppProvider, int>((provider) => provider.getTotalAmount());
    return Container(
      height: sizeConfig.toDynamicUnit(70.4),
      padding: EdgeInsets.only(
          top: sizeConfig.toDynamicUnit(20),
          bottom: sizeConfig.toDynamicUnit(15.6),
          left: sizeConfig.toDynamicUnit(78.5),
          right: sizeConfig.toDynamicUnit(79.5)),
      decoration: BoxDecoration(
          color: AppColors.Black,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(sizeConfig.toDynamicUnit(30)),
              bottomLeft: Radius.circular(sizeConfig.toDynamicUnit(30))),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.productDetaCountBoxGrad1,
                AppColors.productDetaCountBoxGrad2,
              ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: TextStyle(color: AppColors.White),
          ),
          Text(
            '$total USD',
            style: TextStyle(color: AppColors.White),
          )
        ],
      ),
    );
  }
}
