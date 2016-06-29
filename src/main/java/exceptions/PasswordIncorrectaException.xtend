package exceptions

class PasswordIncorrectaException extends BaseControlGastosException{
    new(String usuarioNombre){
        super("El usuario " + usuarioNombre + " ingreso una password incorrecta")
    }
}