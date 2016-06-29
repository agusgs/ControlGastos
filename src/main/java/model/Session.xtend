package model

import repositorios.RepositorioUsuarios
import exceptions.PasswordIncorrectaException

class Session {

    RepositorioUsuarios repoUsuarios;

    def login(String usuarioNombre, String usuarioPassword){
        val usuario = repoUsuarios.getUsuarioPorNombre(usuarioNombre)

        if(!(usuario.password == usuarioPassword)){
            throw new PasswordIncorrectaException(usuarioNombre)
        }
    }
}