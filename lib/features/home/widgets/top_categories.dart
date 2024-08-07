import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});


  void navigateToCategoryPage(BuildContext context,String  category){
    Navigator.pushNamed(context,CategoryDealsScreen.routeName, arguments: category);

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent:72 ,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: ()=>navigateToCategoryPage(context,GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                SingleImageCategory(image: GlobalVariables.categoryImages[index]['image']!,),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
            
                  ),
                  )
              ],
            ),
          );
        },
      ) ,
    );
  }
}


class SingleImageCategory extends StatelessWidget {

  final String image;
  const SingleImageCategory({
    super.key,
    required this.image
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          image,
          fit:  BoxFit.cover,
          height: 40,
          width: 40,
        ),
      ) ,
    );
  }
}


