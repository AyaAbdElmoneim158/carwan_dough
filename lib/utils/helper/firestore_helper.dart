import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static final instance = FirestoreHelper._();
  final _fireStore = FirebaseFirestore.instance;
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _fireStore.doc(path);
    debugPrint('Request Data: $data');
    await reference.set(data);
  }

  Future<void> setDataWithMerge({
    required String path,
    required Map<String, dynamic> data,
    // bool merge = false,
  }) async {
    final reference = _fireStore.doc(path);
    debugPrint('Request Data: $data');

    await reference.set(
      data,
      SetOptions(merge: true), //merge),
    );
  }

  Future<void> deleteData({required String path}) async {
    final reference = _fireStore.doc(path);
    debugPrint('Path: $path');
    await reference.delete();
  }

  /// Deletes all documents in a collection at the given path
  Future<void> clearCollection({required String path, int batchSize = 500}) async {
    final collectionRef = _fireStore.collection(path);

    while (true) {
      final querySnapshot = await collectionRef.limit(batchSize).get();
      if (querySnapshot.docs.isEmpty) break;

      final batch = _fireStore.batch();
      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Stop if less than batch size (no more documents)
      if (querySnapshot.docs.length < batchSize) break;
    }

    debugPrint('Collection at "$path" cleared successfully.');
  }

  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _fireStore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) => builder(
              snapshot.data() as Map<String, dynamic>,
              snapshot.id,
            ),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) async {
    final reference = _fireStore.doc(path);
    final snapshot = await reference.get();
    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = await query.get();
    final result = snapshots.docs.map((snapshot) => builder(snapshot.data() as Map<String, dynamic>, snapshot.id)).where((value) => value != null).toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }
}
