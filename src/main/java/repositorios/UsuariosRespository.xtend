package repositorios

import model.Usuario
import java.util.List
import exceptions.UsuarioInexistenteException
import exceptions.UsuarioDuplicadoException
import java.util.regex.Pattern
import exceptions.PasswordMalFormadaException

class UsuariosRepository {

    final String PASSWORD_REGEX = "(?=(.*?\\d){1})[a-zA-Z0-9]{5,}"

    List<Usuario> usuarios

    new(){
        usuarios = newArrayList();
    }

    def getUsuarioPorNombre(String usuarioNombre){
        validarExistenciaDeUsuario(usuarioNombre)

        this.usuarios.findFirst[usuario | usuario.nombre == usuarioNombre]
    }

    def create(String usuarioNombre, String passwordUsuario){
        validarParametrosNoNulos(usuarioNombre, passwordUsuario)
        validarUsuarioDuplicado(usuarioNombre)
        validarPasswordMalFormada(passwordUsuario)

        val usuarioNuevo =  new Usuario(usuarioNombre, passwordUsuario)
        this.usuarios.add(usuarioNuevo)

        usuarioNuevo
    }

    def all(){
        this.usuarios
    }

    def validarPasswordMalFormada(String password){
        val pattern = Pattern.compile(PASSWORD_REGEX)
        val matcher = pattern.matcher(password)

        if(!(matcher.matches)){
            throw new PasswordMalFormadaException()
        }
    }

    def validarUsuarioDuplicado(String nombre){
        if(existeUsuario(nombre)){
            throw new UsuarioDuplicadoException(nombre)
        }
    }

    def validarExistenciaDeUsuario(String usuarioNombre){
        if(!(existeUsuario(usuarioNombre))){
           throw new UsuarioInexistenteException(usuarioNombre)
        }
    }

    def existeUsuario(String usuarioNombre){
        this.usuarios.exists[usuario | usuario.nombre == usuarioNombre]
    }

}