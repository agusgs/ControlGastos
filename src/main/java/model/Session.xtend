package model

import exceptions.PasswordIncorrectaException
import exceptions.UsuarioYaEstaLogueadoException
import repositorios.RepositorioUsuarios

class Session {

    RepositorioUsuarios repoUsuarios;

    def login(String usuarioNombre, String usuarioPassword){
        val usuario = repoUsuarios.getUsuarioPorNombre(usuarioNombre)
        validarUsuarioYaLogeado(usuario)

        if(!(usuario.password == usuarioPassword)){
            throw new PasswordIncorrectaException(usuarioNombre)
        }else{
            usuario.logueado = true
        }
    }

    def validarUsuarioYaLogeado(Usuario usuario){
        if(usuario.logueado){
            throw new UsuarioYaEstaLogueadoException(usuario)
        }
    }
}