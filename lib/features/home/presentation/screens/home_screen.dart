import 'package:fashion_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:fashion_app/features/home/presentation/cubit/home_state.dart';
import 'package:fashion_app/features/home/presentation/widgets/category_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {

          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is HomeLoaded) {
            final categories = state.categories;

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final category = categories[index];

                return CategoryListItem(
                  name: category.name,
                  image: category.coverPictureUrl,
                  description: category.description,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}