import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_states.dart';
import 'package:flutter_cubit/cubit/app_cubits.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/widgets/app_button.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';
import 'package:flutter_cubit/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 3;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
      builder: (context, state){
        if(state is DetailState){
          var info = state.place;
          return  Scaffold(
            body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("http://mark.bslmeiyu.com/uploads/"+info.img),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  Positioned(
                      top: 70,
                      left: 20,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              BlocProvider.of<AppCubits>(context).goHome();
                            },
                            icon: Icon(Icons.menu),
                            color: Colors.white,
                          )
                        ],
                      )
                  ),
                  Positioned(
                      top: 300,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                        width: MediaQuery.of(context).size.width,
                        height: 500,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppLargeText(text: info.name, color: Colors.black.withOpacity(0.8),),
                                AppLargeText(text: "\$ "+info.price.toString(), color: AppColors.mainColor,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: AppColors.mainColor,),
                                SizedBox(width: 5,),
                                AppText(text: info.location, color: AppColors.textColor1)
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Wrap(
                                  children: List.generate(info.stars, (index){
                                    return Icon(Icons.star, color: gottenStars>index?AppColors.starColor:AppColors.textColor2,);
                                  }),
                                ),
                                SizedBox(width: 10,),
                                AppText(text: "(4.0)", color: AppColors.textColor2,)
                              ],
                            ),
                            const SizedBox(height: 25,),
                            AppLargeText(text: "People", color: Colors.black.withOpacity(0.8), size: 20,),
                            const SizedBox(height: 5,),
                            AppText(text: "Number of people in your group", color: AppColors.mainTextColor,),
                            Wrap(
                              children: List.generate(info.people, (index){
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  } ,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10, top: 15),
                                    child: AppButtons(
                                      size: 50,
                                      color: selectedIndex==index? Colors.white:AppColors.textColor1,
                                      backgroundColor: selectedIndex==index? Colors.black:AppColors.buttonBackground,
                                      borderColor: AppColors.buttonBackground,
                                      text: (index+1).toString(),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20,),
                            AppLargeText(text: "Description", color: Colors.black.withOpacity(0.8), size: 20,),
                            SizedBox(height: 10,),
                            AppText(text: info.description, color: AppColors.mainTextColor,),

                          ],
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        AppButtons(size: 60, color: AppColors.textColor1, backgroundColor: Colors.white, borderColor: AppColors.textColor1, isIcon: true, icon: Icons.favorite_border_rounded,),
                        const SizedBox(width: 20,),
                        ResponsiveButton( isResponsive: true,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }else{
          return Container();
        }
      },
    );
  }
}
