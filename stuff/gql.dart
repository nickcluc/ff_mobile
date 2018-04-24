// class OwnersNameQuery extends Object with Fields implements GQLOperation {
//   OwnersResolver owners = new OwnersResolver();
//
//   @override
//   String get type => queryType;
//
//   @override
//   String get name => 'OwnersNameQuery';
//
//   @override
//   List<GQLField> get fields => [owners];
//
//   @override
//   OwnersNameQuery clone() => new OwnersNameQuery()
//     ..owners = owners.clone();
// }
//
// class OwnersResolver extends Object with ScalarCollection<FullNameResolver>, Fields implements GQLField {
//   @override
//   FullNameResolver full_name = new FullNameResolver();
//
//   @override
//   String get name => 'owners';
//
//   @override
//   List<GQLField> get fields => [full_name];
//
//   @override
//   OwnersResolver clone() => new OwnersResolver()
//     ..full_name = full_name.clone();
// }
//
// // class OwnerResolver extends Object with Fields implements GQLField {
// //   FullNameResolver full_name = new FullNameResolver();
// //
// //   @override
// //   String get name => 'owners';
// //
// //   @override
// //   List<GQLField> get fields => [full_name];
// //
// //   @override
// //   OwnersResolver clone() => new OwnersResolver()
// //     ..full_name = full_name.clone();
// // }
// //
// //
// //
// //
//
// Future getOwnersData() async {
//   const endPoint = 'https://aqueous-cove-99042.herokuapp.com/graphql';
//
//   Logger.root // Optional
//   ..level = Level.ALL
//   ..onRecord.listen((rec) {
//     print('${rec.level.name}: ${rec.time}: ${rec.message}');
//   });
//
//   final client = new Client();
//   final logger = new Logger('GQLClient'); // Optional.
//
//   final graphQLClient = new GQLClient(
//     client: client,
//     logger: logger,
//     endPoint: endPoint,
//   );
//
//   final query = new OwnersNameQuery();
//
//   try {
//     final queryRes = await graphQLClient.execute(
//       query,
//       variables: <String, String>{},
//       headers: <String, String>{'Content-Type':'application/json'},
//     );
//
//     // print(queryRes.owners.full_name);
//   } on GQLException catch (e) {
//     print('EXCEPTION!!');
//     print(e.message);
//     print(e.gqlErrors);
//   }
// }
