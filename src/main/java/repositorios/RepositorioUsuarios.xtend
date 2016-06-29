package repositorios

import model.Usuario
import java.util.List
import exceptions.UsuarioInexistenteException

class RepositorioUsuarios {

    List<Usuario> usuarios

    new(){
        usuarios = newArrayList();
    }

    def getUsuarioPorNombre(String usuarioNombre){
        validarExistenciaDeUsuario(usuarioNombre)

        this.usuarios.findFirst[usuario | usuario.nombre == usuarioNombre]
    }

    def validarExistenciaDeUsuario(String usuarioNombre){
        if(existeUsuario(usuarioNombre)){
           throw new UsuarioInexistenteException(usuarioNombre)
        }
    }

    def existeUsuario(String usuarioNombre){
        this.usuarios.exists[usuario | usuario.nombre == usuarioNombre]
    }
}