import Debug "mo:base/Debug";
import Principal "mo:base/Principal";


actor Auth {
    type User= {
        username: Text;
        passwordHas: Text ;//almacenar el hash d ela contraseña
        principal: Principal;//principal asociado al usuario
    
    };

    stable var users: [User]= [];// lista de usuarios registrados
    
    //funciòn para regsitra un nuevo usuario
    public func  register (username: Text, password: Text) : Text {
  // verifica que el usuario este registrado
      for (user in users) 
      if (user, username == username) {
        return "el usuario ya esta registrado";
      }

    }

    //Algorismo seguro a la contraseña
    let passwordHash = hashPassword (password);

    let newUser = User {
        username= username;
        passwordHash= passwordHash;
        principal = msg.caller;
    };
    user: = users # [newUser];
    Debug.print ("Usuario registrado: " # username);
    return "Registro Exitoso";
}

//funcion para inciar sesion

public func login(username:Text, password:Text {
    let optUser = Array.fin<User> (fun (user){ user.username == username}, user);
    switch (opyUser){

        case (null) { return " usuario no encontrado";}

        case (user) {
            //verificar la contraseña
            if (user.passwordHash ! = hasPassword (password)){

                return "Contraseña incorrecta"
            };
 
        };
        
    }

//SIMULACION D ELA FUNCION DEL HASH
private func hashPassword (password : Text ): Text {
    return password;
}
}
