

abstract class AuthStates{
}


class AppIntialState extends AuthStates{


}


class ForgotPassSuccessState extends AuthStates{

  ForgotPassSuccessState();
}
class ForgotPassErrorState extends AuthStates{

  ForgotPassErrorState();
}


class LoginSuccessState extends AuthStates{

  LoginSuccessState();
}

class LoginErrorState extends AuthStates{

  LoginErrorState();
}

class LoginLoadingState extends AuthStates{

  LoginLoadingState();
}

class SignUpSuccessState extends AuthStates{

  SignUpSuccessState();
}

class SignUpErrorState extends AuthStates{

  SignUpErrorState();
}

class SignUpLoadingState extends AuthStates{

  SignUpLoadingState();
}

class ChangePassSuccessState extends AuthStates{

  ChangePassSuccessState();

}

class ChangePassErrorState extends AuthStates{

  ChangePassErrorState();
}

class ChangePassLoadingState extends AuthStates{

  ChangePassLoadingState();
}
