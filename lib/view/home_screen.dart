import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/app_colors.dart';
import 'package:mvvm_provider/viewModel/home_viewmodel.dart';
import 'package:mvvm_provider/viewModel/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/response/status.dart';
import '../model/movies_model.dart';
import '../utils/routes/route_names.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  HomeViewModel homeViewModel = HomeViewModel();
  
  @override
  void initState() {
    homeViewModel.fetchMoviesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return  Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.98),
      appBar: AppBar(
        title:  Text("Home",style: TextStyle(color: AppColors.white),),
        backgroundColor: AppColors.blue,
        iconTheme: IconThemeData(color: AppColors.white),
        actions: [
          TextButton.icon(
              onPressed: (){
                userViewModel.removeUser().then((value) {
                  Navigator.pushNamed(context, RouteNames.login);
                },);
              },
              label: Text("LogOut",style: TextStyle(color: AppColors.white),),
            icon: Icon(Icons.logout,color: AppColors.white,size: 28,),
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => homeViewModel,
      child: Consumer<HomeViewModel>(builder: (context, value, _) {
        switch(value.moviesList.status){
          case Status.LOADING:
            return Center(child: CircularProgressIndicator(color: AppColors.blue,));
           
          case Status.ERROR:
           return Center(child: Text(value.moviesList.message.toString()));
          case Status.COMPLETE:
            return ListView.builder(
              itemCount: value.moviesList.data!.movies!.length,
              itemBuilder: (context, index) {
                return Card(
                  surfaceTintColor: AppColors.white,
                  color: AppColors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: double.infinity,
                      height: 120,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110,
                            child: CachedNetworkImage(
                                  imageUrl: value.moviesList.data!.movies![index].posterurl.toString(),
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter:
                                          const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                      decoration: ShapeDecoration.fromBoxDecoration(BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.grey.withOpacity(0.1),
                                      )),
                                      child: const Center(child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) => Container(
                                      decoration: ShapeDecoration.fromBoxDecoration(BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      color: AppColors.grey.withOpacity(0.1),
                                      )),
                                      child: const Center(child: Icon(Icons.error))),
                                ),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 200,
                                  child: Text(value.moviesList.data!.movies![index].title.toString(),style:Theme.of(context).textTheme.titleMedium,overflow:TextOverflow.ellipsis ,)),
                             const SizedBox(height: 8,),
                              SizedBox(
                                  width: 200,
                                  child: Text(value.moviesList.data!.movies![index].year .toString(),style: const TextStyle(overflow: TextOverflow.ellipsis),)),
                              Spacer(),
                              Row(
                                children: [
                                  const Icon(Icons.star,color: Colors.yellow,size: 16,),
                                  Text(
                                    Utils.averageRatings(value
                                        .moviesList.data!.movies![index].ratings!)
                                        .toStringAsFixed(1),
                                  ),
                                ],
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              // return ListTile(
              //   leading: CachedNetworkImage(
              //     imageUrl: value.moviesList.data!.movies![index].posterurl.toString(),
              //     imageBuilder: (context, imageProvider) => Container(
              //       height: 100,
              //       width: 100,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //             image: imageProvider,
              //             fit: BoxFit.cover,
              //             colorFilter:
              //             const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
              //       ),
              //     ),
              //     placeholder: (context, url) => const CircularProgressIndicator(),
              //     errorWidget: (context, url, error) => const Icon(Icons.error),
              //   ),
              //   title: Text(value.moviesList.data!.movies![index].title.toString()),
              // );
            },);
          default:
            return const SizedBox();
        }
      },),
      )
    );
  }
}
