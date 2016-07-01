package exceptions

class UsuarioDuplicadoException extends BaseControlGastosException{
    new(String usuarioNombre){
        super("El nombre de usuario " + usuarioNombre + " ya esta tomado")
    }
}