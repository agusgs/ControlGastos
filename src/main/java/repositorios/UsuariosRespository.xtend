package repositorios

import model.Usuario
import java.util.List
import exceptions.UsuarioInexistenteException
import exceptions.UsuarioDuplicadoException
import java.util.regex.Pattern
import exceptions.PasswordMalFormadaException
import model.ValidadorParametros

class UsuariosRepository {

    final String PASSWORD_REGEX = "(?=(.*?\\d){1})[a-zA-Z0-9]{5,}"

    List<Usuario> usuarios
    Integer contadorId

    new(){
        usuarios = newArrayList();
        contadorId = 0
    }

    def getUsuarioPorNombre(String usuarioNombre){
        validarExistenciaDeUsuarioPorNombre(usuarioNombre)

        this.usuarios.findFirst[usuario | usuario.nombre == usuarioNombre]
    }

    def getUsuarioPorId(Integer usuarioId){
        validarExistenciaDeUsuarioPorId(usuarioId)

        usuarios.findFirst[usuario | usuario.id == usuarioId]
    }

    def create(String usuarioNombre, String passwordUsuario){
        validarParametrosNoNulos(usuarioNombre, passwordUsuario)
        validarUsuarioDuplicado(usuarioNombre)
        validarPasswordMalFormada(passwordUsuario)

        contadorId ++

        val usuarioNuevo =  new Usuario(contadorId, usuarioNombre, passwordUsuario)
        this.usuarios.add(usuarioNuevo)

        usuarioNuevo
    }

    def all(){
        this.usuarios
    }

    def validarExistenciaDeUsuarioPorId(Integer usuarioId){
        if(!(existeUsuarioPorId(usuarioId))){
            throw new UsuarioInexistenteException(usuarioId.toString())
        }
    }

    def existeUsuarioPorId(Integer usuarioId){
        this.usuarios.exists[usuario | usuario.id == usuarioId]
    }

    def validarParametrosNoNulos(String usuarioNombre, String passwordUsuario){
        ValidadorParametros.para("NOMBRE", usuarioNombre).validar()
        ValidadorParametros.para("PASSWORD", passwordUsuario).validar()
    }

    def validarPasswordMalFormada(String password){
        val pattern = Pattern.compile(PASSWORD_REGEX)
        val matcher = pattern.matcher(password)

        if(!(matcher.matches)){
            throw new PasswordMalFormadaException()
        }
    }

    def validarUsuarioDuplicado(String nombre){
        if(existeUsuarioPorNombre(nombre)){
            throw new UsuarioDuplicadoException(nombre)
        }
    }

    def validarExistenciaDeUsuarioPorNombre(String usuarioNombre){
        if(!(existeUsuarioPorNombre(usuarioNombre))){
           throw new UsuarioInexistenteException(usuarioNombre)
        }
    }

    def existeUsuarioPorNombre(String usuarioNombre){
        this.usuarios.exists[usuario | usuario.nombre == usuarioNombre]
    }

}