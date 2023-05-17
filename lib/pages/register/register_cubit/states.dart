abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class ChangeSuffixIconState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  final String errorMsg;
  RegisterErrorState({required this.errorMsg});
}
class RegisterSuccessState extends RegisterStates{}

class CreateUserErrorState extends RegisterStates{
  final String errorMsg;
  CreateUserErrorState({required this.errorMsg});
}
class CreateUserSuccessState extends RegisterStates{}




class GetLatLonLoadingState extends RegisterStates{}
class GetLatLonErrorState extends RegisterStates{}
class GetLatLongSuccessState extends RegisterStates{}

class CheckLocationEnabledState extends RegisterStates{}
