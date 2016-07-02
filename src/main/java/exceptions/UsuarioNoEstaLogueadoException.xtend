package exceptions

class UsuarioNoEstaLogueadoException extends BaseControlGastosException{
    new(){
        super("Debe loguearse para poder operar")
    }
}