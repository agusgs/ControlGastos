package controller

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import model.ControladorUsuarios
import repositorios.UsuariosRepository
import org.uqbar.xtrest.api.annotation.Put
import exceptions.BaseControlGastosException
import model.ControladorGastos
import repositorios.GastosRepository

@Controller
class ControlGastosController {

    ControladorUsuarios controladorUsuarios
    ControladorGastos controladorGastos
    new(){
        controladorUsuarios = new ControladorUsuarios(new UsuariosRepository())
        controladorGastos = new ControladorGastos(new GastosRepository())
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

    @Put("/gastos/:descripcion/:monto/:usuarioId")
    def nuevoGastoEndpoint(){
        response.contentType = "application/json"
        val iDescripcion = String.valueOf(descripcion)
        val iMonto = Double.valueOf(monto)
        val iUsuarioId = Integer.valueOf(usuarioId)

        try {
            efectuarCreacionDeGasto(iDescripcion, iMonto, iUsuarioId)
            ok()
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message);
        }
    }

    def efectuarCreacionDeGasto(String descripcion, Double monto, Integer usuarioId){
        controladorGastos.agregarGasto(descripcion, monto, controladorUsuarios.usuarioConId(usuarioId))
    }

    def efectuarRegistracion(String usuarioNombre, String usuarioPassword){
        controladorUsuarios.registrar(usuarioNombre, usuarioPassword)
    }

    def efectuarLogin(String usuarioNombre, String usuarioPassword){
        controladorUsuarios.login(usuarioNombre, usuarioPassword)
    }
}