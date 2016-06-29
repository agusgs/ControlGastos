package exceptions

class UsuarioInexistenteException extends BaseControlGastosException{
    new(String usuarioNombre){
        super("El usuario " + usuarioNombre + " no existe")
    }
}