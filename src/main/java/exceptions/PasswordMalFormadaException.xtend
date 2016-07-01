package exceptions

class PasswordMalFormadaException extends BaseControlGastosException{
    new(){
        super("La password ingresada debe ser de al menos 6 caracteres y contener al menos un numero")
    }
}