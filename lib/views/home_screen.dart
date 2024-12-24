import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_shose/config/my_config.dart';
import 'package:shop_shose/models/cart_item.dart';
import 'package:shop_shose/viewmodels/controller/auth_viewmodel.dart';
import 'package:shop_shose/viewmodels/controller/shoe_controller.dart';
import 'package:shop_shose/widget/add_cart_shoe_detail.dart';
import 'package:shop_shose/x_router/router_name.dart';
import '../models/shoes_model.dart';

class HomeScreen extends StatelessWidget {
  final ShoeController shoeController = Get.find();
  final TextEditingController searchController = TextEditingController();
  final RxBool showSuggestions = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoe Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed(RouterName.cart);
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Stack(children: [
        Obx(() {
          if (shoeController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    _buildSearchBar(),
                    _buildBanner(),
                    _buildHotPicks(),
                    Expanded(child: _buildShoeGrid()),
                  ],
                ),
              ),
            );
          }
        }),
        Obx(() => showSuggestions.value
            ? _buildSuggestionsList()
            : SizedBox.shrink()),
      ]),
    );
  }

  Widget _buildSuggestionsList() {
    return Positioned.fill(
      top: 70.h, // Adjust this value to position the list below the search bar
      child: Container(
        color: Colors.white,
        child: Obx(() {
          if (shoeController.filteredShoes.isEmpty) {
            return Center(child: Text('Không tìm thấy kết quả'));
          }
          return ListView.builder(
            itemCount: shoeController.filteredShoes.length,
            itemBuilder: (context, index) {
              final shoe = shoeController.filteredShoes[index];
              void _showDetailModal(BuildContext context) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddCartShoeDetail(shoe: shoe),
                );
              }

              return ListTile(
                title: Text(shoe.name ?? ''),
                subtitle: Text(shoe.brand ?? ''),
                leading: shoe.image != null
                    ? Image.network(shoe.image!, width: 50.w, height: 50.h)
                    : null,
                onTap: () {
                  // searchController.clear();
                  // showSuggestions.value = false;
                  // shoeController.searchShoes('');
                  _showDetailModal(context);
                },
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm giày...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onChanged: (value) {
          shoeController.searchShoes(value);
          showSuggestions.value = value.isNotEmpty;
        },
      ),
    );
  }

  Widget _buildBanner() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0.r,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              shoeController.updateBannerIndex(index);
            },
          ),
          items: [
            'assets/image/banner4.jpg',
            'assets/image/banner2.jpg',
            'assets/image/banner3.jpg'
          ].map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10.h),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [0, 1, 2].map((i) {
                return Container(
                  width: 8.0.w,
                  height: 8.0.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: shoeController.currentBannerIndex.value == i
                        ? Colors.blue
                        : Colors.grey,
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildHotPicks() {
    return Container(
      height: 120.h,
      child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shoeController.filteredShoes.take(5).length,
            itemBuilder: (context, index) {
              final shoe = shoeController.filteredShoes[index];
              void _showDetailModal(BuildContext context) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => AddCartShoeDetail(shoe: shoe),
                );
              }

              return Card(
                color: Colors.grey[200],
                child: GestureDetector(
                  child: Container(
                    width: 100.h,
                    child: Column(
                      children: [
                        Image.network(shoe.image!,
                            height: 80.h, fit: BoxFit.cover),
                        // Text(shoe.name!, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  onTap: () => _showDetailModal(context),
                ),
              );
            },
          )),
    );
  }

  Widget _buildShoeGrid() {
    return Obx(() => GridView.builder(
          padding: EdgeInsets.all(8.r),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: shoeController.filteredShoes.length,
          itemBuilder: (context, index) {
            final shoe = shoeController.filteredShoes[index];
            return ShoeItem(shoe: shoe);
          },
        ));
  }
}

class ShoeItem extends StatelessWidget {
  final Shoes shoe;
  ShoeItem({required this.shoe});
  // void _showBuyDetailModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => BuyShoeDetail(shoe: shoe),
  //   );
  // }

  void _showAddCartDetailModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCartShoeDetail(shoe: shoe),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(child: Image.network(shoe.image!, fit: BoxFit.cover)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shoe.name!, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(shoe.brand!),
                Text('\$${shoe.price}', style: TextStyle(color: Colors.green)),
                Text('Số lượng: ${shoe.quantity}'),
                // DropdownButton<String>(
                //   value: selectedSize.value.isEmpty ? null : selectedSize.value,
                //   hint: Text('Size'),
                //   onChanged: (String? newValue) {
                //     selectedSize.value = newValue!;
                //   },
                //   items: ['S', 'M', 'L', 'XL']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                // Row(
                //   children: [
                //     IconButton(
                //       icon: Icon(Icons.remove),
                //       onPressed: () =>
                //           quantity.value > 1 ? quantity.value-- : null,
                //     ),
                //     Obx(() => Text('${quantity.value}')),
                //     IconButton(
                //       icon: Icon(Icons.add),
                //       onPressed: () => quantity.value++,
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        _showAddCartDetailModal(context);
                      },
                      color: Colors.green,
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.shopping_bag),
                    //   onPressed: () {
                    //     _showBuyDetailModal(context);
                    //   },
                    //   color: Colors.green,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final AuthViewModel userController = Get.find();
  final ShoeController shoeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              userController.userinfo.value!.name ?? 'Thien',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Thông Tin '),
            onTap: () {
              Get.toNamed(RouterName.userinfo);
              // Navigate to cart
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Đơn Đã Đặt'),
            onTap: () {
              shoeController.getAllOrders();
              Get.toNamed(RouterName.getalloder);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Đăng Xuất'),
            onTap: () {
              userController.Logout();
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}
