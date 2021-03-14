class UsuarioModel {
  int id;
  String email;
  String name;
  String password;

  UsuarioModel({this.id, this.email, this.name, this.password});

  Map<String, dynamic> toJsonLogin() => {
        'email': this.email,
        'password': this.password,
      };
}
