package exceptions

import model.Usuario

class UsuarioYaEstaLogueadoException extends BaseControlGastosException{

    new(Usuario usuario){
        super("El " + usuario.nombre + " ya esta logueado")
    }
}