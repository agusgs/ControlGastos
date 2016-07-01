package controller

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import model.ControladorUsuarios
import repositorios.UsuariosRepository
import org.uqbar.xtrest.api.annotation.Put
import exceptions.BaseControlGastosException

@Controller
class ControlGastosController {

    ControladorUsuarios controladorUsuarios

    new(){
        controladorUsuarios = new ControladorUsuarios(new UsuariosRepository())
    }

    @Post("/login/:usuarioNombre/:usuarioPassword")
    def loginEndpoint(){
        response.contentType = "application/json"
        val iUsuarioNombre = String.valueOf(usuarioNombre)
        val iUsuarioPassword = String.valueOf(usuarioPassword)

        try {
            efectuarLogin(iUsuarioNombre, iUsuarioPassword)
            ok()
        }
        catch (BaseControlGastosException e) {
            forbidden(e.message);
        }
    }

    @Put("/registracion/:usuarioNombre/:usuarioPassword")
    def registracionEndPoint(){
        response.contentType = "application/json"
        val iUsuarioNombre = String.valueOf(usuarioNombre)
        val iUsuarioPassword = String.valueOf(usuarioPassword)

        try {
            efectuarRegistracion(iUsuarioNombre, iUsuarioPassword)
            ok()
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message);
        }
    }

    @Put("/gastos/:descripcion/:monto/:idUsuario")
    def nuevoGastoEndpoint(){


    }

    def efectuarRegistracion(String usuarioNombre, String usuarioPassword){
        controladorUsuarios.registrar(usuarioNombre, usuarioPassword)
    }

    def efectuarLogin(String usuarioNombre, String usuarioPassword){
        controladorUsuarios.login(usuarioNombre, usuarioPassword)
    }
}