package model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Usuario {

    Integer id
    String nombre
    String password
    Boolean logueado

    new(Integer id, String nombreUsuario, String passwordUsuario){
        this.id = id
        this.nombre = nombreUsuario
        this.password = passwordUsuario
        this.logueado = false
    }
}