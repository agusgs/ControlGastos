package model

import exceptions.ParametroInvalidoException

class ValidadorParametros {

    String campo
    Object objeto

    def static para(String campo, Object objeto){
        new ValidadorParametros(campo, objeto)
    }

    new(String campo, Object objeto){
        this.campo = campo
        this.objeto = objeto
    }

    def validar(){
        if(this.objeto == null){
            throw new ParametroInvalidoException(campo)
        }
    }
}