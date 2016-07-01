package model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {

    String nombre
    String password
    Boolean logueado

    new(String nombreUsuario, String passwordUsuario){
        this.nombre = nombreUsuario
        this.password = passwordUsuario
        this.logueado = false
    }
}