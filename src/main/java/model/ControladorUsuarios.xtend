package model

import exceptions.PasswordIncorrectaException
import exceptions.UsuarioYaEstaLogueadoException
import repositorios.UsuariosRepository

class ControladorUsuarios {

    UsuariosRepository repoUsuarios;

    new(UsuariosRepository repoUsuarios){
        this.repoUsuarios = repoUsuarios
    }

    def login(String usuarioNombre, String usuarioPassword){
        val usuario = repoUsuarios.getUsuarioPorNombre(usuarioNombre)
        validarUsuarioYaLogeado(usuario)

        if(!(usuario.password == usuarioPassword)){
            throw new PasswordIncorrectaException(usuarioNombre)
        }else{
            usuario.logueado = true
        }
    }

    def registrar(String usuarioNombre, String usuarioPassword){
        repoUsuarios.create(usuarioNombre, usuarioPassword)
    }

    def validarUsuarioYaLogeado(Usuario usuario){
        if(usuario.logueado){
            throw new UsuarioYaEstaLogueadoException(usuario)
        }
    }
}