package model

import exceptions.PasswordIncorrectaException
import exceptions.UsuarioYaEstaLogueadoException
import repositorios.UsuariosRepository
import exceptions.UsuarioInexistenteException
import exceptions.UsuarioNoEstaLogueadoException

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
        usuario
    }

    def registrar(String usuarioNombre, String usuarioPassword){
        val usuario = repoUsuarios.create(usuarioNombre, usuarioPassword)
        usuario.login
        usuario
    }

    def usuarioConId(Integer usuarioId){
        repoUsuarios.getUsuarioPorId(usuarioId)
    }

    def logout(Integer usuarioId){
        validarUsuarioLogueado(usuarioId)
        usuarioConId(usuarioId).logout
    }

    def validarUsuarioLogueado(Integer idUsuario){
        try{
            val usuario = usuarioConId(idUsuario)
            if(!usuario.logueado){
                throw new UsuarioNoEstaLogueadoException()
            }
        }catch(UsuarioInexistenteException e){
            throw new UsuarioNoEstaLogueadoException()
        }
    }

    def validarUsuarioYaLogeado(Usuario usuario){
        if(usuario.logueado){
            throw new UsuarioYaEstaLogueadoException(usuario)
        }
    }
}