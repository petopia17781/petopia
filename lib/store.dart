import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petopia/SizeConfig.dart';
import 'package:petopia/models/Product.dart';

class StorePage extends StatefulWidget {

  StorePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2 * SizeConfig.heightMultiplier,),
              // header
              Header(),
              SizedBox(height: 2 * SizeConfig.heightMultiplier,),
              // banner
              Banner(),
              SizedBox(height: 2 * SizeConfig.heightMultiplier,),
              // categories
              Categories(),
              SizedBox(height: 2 * SizeConfig.heightMultiplier,),
              // special offers
              SpecialOffers(),
              SizedBox(height: 2 * SizeConfig.heightMultiplier,),
              PopularProducts()
            ],
          ),
        ),
      ),
    );
  }

}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 5 * SizeConfig.widthMultiplier
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // search bar
          Container(
            width: 75 * SizeConfig.widthMultiplier,
            height: 5 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              onChanged: (value) {
                // search value
              },
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search, color: Colors.black26,),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 2 * SizeConfig.widthMultiplier,
                      vertical: 1.5 * SizeConfig.heightMultiplier
                  )
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Stack(
              children: [
                // shopping cart icon
                Container(
                  padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
                  height: 5 * SizeConfig.heightMultiplier,
                  width: 10 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.1),
                      shape: BoxShape.circle
                  ),
                  child: SvgPicture.asset("assets/icons/Cart Icon.svg"),
                ),
                // notification
                Positioned(
                  top: -1 * SizeConfig.heightMultiplier,
                  right: 0,
                  child: Container(
                    height: 4 * SizeConfig.heightMultiplier,
                    width: 4 * SizeConfig.widthMultiplier,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.5, color: Colors.white)
                    ),
                    child: Center(
                        child: Text("3", style: TextStyle(
                            color: Colors.white,
                            fontSize: 1 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600
                        ),)
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
      padding: EdgeInsets.symmetric(
          horizontal: 5 * SizeConfig.widthMultiplier,
          vertical: 5 * SizeConfig.widthMultiplier
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Text.rich(
          TextSpan(
              text: "Spring Sale\n",
              style: TextStyle(color: Colors.black38),
              children: [
                TextSpan(
                  text: "Up to 30% off",
                  style: TextStyle(color: Colors.black54,
                      fontSize: 3 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.bold
                  ),
                )
              ]
          )

      ),
    );
  }
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Bill Icon.svg", "text": "Orders"},
      {"icon": "assets/icons/Heart Icon.svg", "text": "Wish List"},
      {"icon": "assets/icons/Membership Icon.svg", "text": "Member"},
      {"icon": "assets/icons/Category Icon.svg", "text": "Category"},
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 15 * SizeConfig.widthMultiplier,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(4 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: SvgPicture.asset(icon, color: Colors.black26,),
              ),
            ),
            const SizedBox(height: 5,),
            Text(text, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 2 * SizeConfig.textMultiplier,
            color: Colors.black54,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "See More",
            style: TextStyle(color: Colors.black26),
          ),
        ),
      ],
    );
  }
}

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
          child: SectionTitle(
            title: "Special for you",
            press: () {},
          ),
        ),
        SizedBox(height: 2 * SizeConfig.heightMultiplier),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "https://cdn.pixabay.com/photo/2020/05/13/21/03/dog-food-5168940_960_720.jpg",
                category: "Food",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: "https://cdn.pixabay.com/photo/2014/05/21/18/08/dog-bones-350093_960_720.jpg",
                category: "Treat",
                numOfBrands: 24,
                press: () {},
              ),
              SpecialOfferCard(
                image: "https://cdn.pixabay.com/photo/2016/09/02/14/52/dog-1639436_960_720.jpg",
                category: "Toy",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: 10 * SizeConfig.widthMultiplier),

            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.numOfBrands,
    @required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5 * SizeConfig.widthMultiplier),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 38 * SizeConfig.widthMultiplier,
          height: 12 * SizeConfig.heightMultiplier,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        shrinePink400.withOpacity(0.2),
                        shrinePink400.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2 * SizeConfig.widthMultiplier,
                    vertical: 1 * SizeConfig.heightMultiplier,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: 5 * SizeConfig.widthMultiplier),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                    (index) {
                  if (demoProducts[index].isPopular)
                    return ProductCard(product: demoProducts[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: 5 * SizeConfig.widthMultiplier),
            ],
          ),
        )
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: 5 * SizeConfig.widthMultiplier),
      child: SizedBox(
        width: 30 * SizeConfig.widthMultiplier,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(0 * SizeConfig.widthMultiplier),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: product.id.toString(),
                    child: Image.network(product.images[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: 2.3 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(1 * SizeConfig.widthMultiplier),
                      height: 5 * SizeConfig.heightMultiplier,
                      width: 5 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(
                        color: product.isFavourite
                            ? colorScheme.primary.withOpacity(0.15)
                            : colorScheme.secondary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: product.isFavourite
                            ? Colors.red
                            : Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


const Color shrinePink400 = Color(0xFFEAA4A4);