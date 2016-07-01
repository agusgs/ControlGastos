package exceptions

class ParametroInvalidoException extends BaseControlGastosException{
    new(String campo){
        super("El campo " + campo + " no puede estar vacio")
    }
}