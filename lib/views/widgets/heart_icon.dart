// // import 'package:app/core/constants/app_extension.dart';
// // import 'package:app/core/constants/assets_manager.dart';
// // import 'package:app/features/favorites/favorites_cubit.dart';
// // import 'package:app/features/favorites/favorites_states.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_svg/svg.dart';

// // class HeartIcon extends StatefulWidget {
// //   const HeartIcon({super.key, required this.productId});

// //   final String productId;

// //   @override
// //   State<HeartIcon> createState() => _HeartIconState();
// // }

// // class _HeartIconState extends State<HeartIcon> {
// //   bool _showSnackbar = true;

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocConsumer<FavoritesCubit, FavoritesState>(
// //       listenWhen: (previous, current) => current is FavoritesAddSuccess || current is FavoritesDeleteSuccess || current is FavoritesGetFailure,
// //       listener: (context, state) {
// //         if (!_showSnackbar) return;
// //         ScaffoldMessenger.of(context).hideCurrentSnackBar();

// //         if (state is FavoritesAddSuccess) {
// //           context.showSnackBar(message: state.products.message!);
// //         } else if (state is FavoritesDeleteSuccess) {
// //           context.showSnackBar(message: state.products.message!);
// //         } else if (state is FavoritesGetFailure) {
// //           context.showSnackBar(message: state.error.message!);
// //         }
// //       },
// //       builder: (context, state) {
// //         //! [ReadContext] and its read method, similar to [watch], but doesn't make widgets rebuild if the value obtained changes.
// //         final cubit = context.watch<FavoritesCubit>();
// //         final isFav = cubit.isProdInFav(widget.productId);
// //         final isLoading = (state is FavoritesAddLoading && state.productId == widget.productId) || (state is FavoritesDeleteLoading && state.productId == widget.productId);

// //         return Padding(
// //           padding: const EdgeInsets.only(top: 8, right: 8),
// //           key: ValueKey<bool>(isFav),
// //           child: isLoading
// //               ? const CupertinoActivityIndicator()
// //               : GestureDetector(
// //                   onTap: () async {
// //                     _showSnackbar = true;
// //                     await cubit.toggleFavorite(widget.productId);
// //                   },
// //                   child: AnimatedSwitcher(
// //                     duration: Duration(milliseconds: 250),
// //                     transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
// //                     child: SvgPicture.asset(
// //                       isFav ? AssetsManager.heartIcon1 : AssetsManager.heartIcon,
// //                     ),
// //                   ),
// //                 ),
// //         );
// //       },
// //     );
// //   }
// // }

// // class HeartRemoverIcon extends StatefulWidget {
// //   const HeartRemoverIcon({
// //     super.key,
// //     required this.productId,
// //   });
// //   final String productId;

// //   @override
// //   State<HeartRemoverIcon> createState() => _HeartRemoverIconState();
// // }

// // class _HeartRemoverIconState extends State<HeartRemoverIcon> {
// //   bool _showSnackbar = true;

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocConsumer<FavoritesCubit, FavoritesState>(
// //       listener: (context, state) {
// //         if (!_showSnackbar) return;
// //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
// //         if (state is FavoritesDeleteSuccess) {
// //           context.showSnackBar(message: state.products.message!);
// //         } else if (state is FavoritesGetFailure) {
// //           context.showSnackBar(message: state.error.message!);
// //         }
// //       },
// //       builder: (context, state) {
// //         final cubit = context.watch<FavoritesCubit>();
// //         final isFav = cubit.isProdInFav(widget.productId);
// //         final isLoading = (state is FavoritesDeleteLoading && state.productId == widget.productId);

// //         return Padding(
// //           padding: const EdgeInsets.all(0),
// //           key: ValueKey<bool>(isFav),
// //           child: isLoading
// //               ? const CupertinoActivityIndicator()
// //               : GestureDetector(
// //                   onTap: () async {
// //                     _showSnackbar = true;
// //                     await cubit.deleteFromFavorites(widget.productId);
// //                   },
// //                   child: Align(
// //                     alignment: Alignment.centerRight,
// //                     child: SvgPicture.asset(AssetsManager.frame6162v1),
// //                   ),
// //                 ),
// //         );
// //       },
// //     );
// //   }
// // }
// //!==///////////////////////////////////
// import 'package:app/core/common/models/products_response.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../core/errors/error_marketi_model.dart';
// import 'favorites_repo.dart';
// import 'favorites_states.dart';

// class FavoritesCubit extends Cubit<FavoritesState> {
//   final FavoritesRepo favoritesRepo;
//   FavoritesCubit(this.favoritesRepo) : super(FavoritesInitial());
//   static FavoritesCubit get(context) => BlocProvider.of(context);
//   List<Product> favorites = [];

//   Future<void> getFavorites() async {
//     if (state is FavoritesGetLoading) return;
//     emit(FavoritesGetLoading());
//     final result = await favoritesRepo.getFavorites();
//     result.fold(
//       (failure) => emit(FavoritesGetFailure(failure.errorModel)),
//       (favorites) {
//         this.favorites = favorites;
//         emit(FavoritesGetSuccess(favorites));
//       },
//     );
//   }

//   Future<void> addToFavorites(String productId) async {
//     if (state is FavoritesAddLoading) return;
//     emit(FavoritesAddLoading(productId)); // Pass productId

//     final result = await favoritesRepo.addFavorites(productId: productId);
//     result.fold(
//       (failure) => emit(FavoritesAddFailure(failure.errorModel)),
//       (success) {
//         getFavorites();
//         emit(FavoritesAddSuccess(
//           ErrorMarketiModel(
//             success.errorModel.message ?? "Added to favorites successfully",
//           ),
//           productId, // Add productId to success state if needed
//         ));
//         emit(Done());
//       },
//     );
//   }

//   Future<void> deleteFromFavorites(String productId) async {
//     if (state is FavoritesDeleteLoading) return;
//     emit(FavoritesDeleteLoading(productId)); // Pass productId

//     final result = await favoritesRepo.deleteFavorites(productId: productId);
//     result.fold(
//       (failure) => emit(FavoritesDeleteFailure(failure.errorModel)),
//       (success) {
//         getFavorites();
//         emit(FavoritesDeleteSuccess(
//           ErrorMarketiModel(success.errorModel.message ?? "Removed from favorites successfully"),
//           productId, // Add productId to success state if needed
//         ));
//         emit(Done());
//       },
//     );
//   }

// /*  Future<void> addToFavorites(String productId) async {
//     if (state is FavoritesAddLoading) return;
//     emit(FavoritesAddLoading());

//     final result = await favoritesRepo.addFavorites(productId: productId);
//     result.fold(
//       (failure) => emit(FavoritesAddFailure(failure.errorModel)),
//       (success) {
//         getFavorites();
//         //! favorites.add(newProduct);
//         //! emit(FavoritesListChanged([...favorites]));
//         emit(
//           FavoritesAddSuccess(
//             ErrorMarketiModel(
//               success.errorModel.message ?? "Added to favorites successfully",
//             ),
//           ),
//         );
//         emit(Done());
//       },
//     );
//   }

//   Future<void> deleteFromFavorites(String productId) async {
//     if (state is FavoritesDeleteLoading) return;
//     emit(FavoritesDeleteLoading());

//     final result = await favoritesRepo.deleteFavorites(productId: productId);
//     result.fold(
//       (failure) => emit(FavoritesDeleteFailure(failure.errorModel)),
//       (success) {
//         getFavorites();
//         emit(FavoritesDeleteSuccess(ErrorMarketiModel(success.errorModel.message ?? "Removed from favorites successfully")));
//         emit(Done());
//       },
//     );
//   }
// */
//   Future<void> toggleFavorite(String productId) async {
//     final isFav = isProdInFav(productId);

//     if (isFav) {
//       await deleteFromFavorites(productId);
//     } else {
//       await addToFavorites(productId);
//     }
//   }

//   bool isProdInFav(String productId) {
//     return favorites.any((product) => product.id == productId);
//   }
// }
// /*
// class FavoritesAddCubit extends Cubit<FavoritesAddState> {
//   final FavoritesRepo favoritesRepo;

//   FavoritesAddCubit(this.favoritesRepo) : super(FavoritesAddInitial());

//   Future<void> addToFavorites(String productId) async {
//     emit(FavoritesAddLoading());

//     final result = await favoritesRepo.addFavorites(productId: productId);
//     result.fold(
//       (failure) => emit(FavoritesAddFailure(failure.errorModel)),
//       (success) => emit(FavoritesAddSuccess(success.errorModel.message ?? "Item added")),
//     );
//   }
// }

// class FavoritesDeleteCubit extends Cubit<FavoritesDeleteState> {
//   final FavoritesRepo favoritesRepo;

//   FavoritesDeleteCubit(this.favoritesRepo) : super(FavoritesDeleteInitial());

//   Future<void> deleteFromFavorites(String productId) async {
//     emit(FavoritesDeleteLoading());

//     final result = await favoritesRepo.deleteFavorites(productId: productId);
//     result.fold((failure) => emit(FavoritesDeleteFailure(failure.errorModel)), (success) {
//       emit(FavoritesDeleteSuccess(success.errorModel.message ?? "Item deleted"));
//       // FavoritesCubit.get(context).getFavorites();
//     });
//   }
// }
// */
