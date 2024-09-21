



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maze_runner/features/auth/loaders/login_loader_provider.dart';
import 'package:maze_runner/features/auth/repo/auth_repo.dart';



final authControllerProvider = Provider((ref){
  AuthRepo authRepo = ref.watch(authRepoProvider);

  return AuthController(authRepo: authRepo,ref:ref);
});
class AuthController {
  final AuthRepo authRepo;
  final ProviderRef ref;

  const AuthController({required this.ref,required this.authRepo});


  Future<String> loginUser({required String teamname,required String mobile}) async{


    ref.read(loginLoaderProvider.notifier).update((cb)=>true);
    String res = await authRepo.loginUser(teamname: teamname,mobile: mobile);
    ref.read(loginLoaderProvider.notifier).update((cb)=>false);
    return res;

  }
}