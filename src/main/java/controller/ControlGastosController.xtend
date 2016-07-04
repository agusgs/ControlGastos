package controller

import exceptions.BaseControlGastosException
import model.ControladorGastos
import model.ControladorUsuarios
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import repositorios.GastosRepository
import repositorios.UsuariosRepository
import org.uqbar.xtrest.api.XTRest

@Controller
class ControlGastosController {

    extension JSONUtils = new JSONUtils

    ControladorUsuarios controladorUsuarios
    ControladorGastos controladorGastos
    Responses responses

    new(){
        controladorUsuarios = new ControladorUsuarios(new UsuariosRepository())
        controladorGastos = new ControladorGastos(new GastosRepository())
        responses = new Responses()
    }

    @Post("/setUp")
    def setUpEndpoint(){
        val usuarioId1 = efectuarRegistracion("agusgs", "lala123").id
        efectuarLogin("agusgs", "lala123")
        ok()
    }

    @Post("/login/:usuarioNombre/:usuarioPassword")
    def loginEndpoint(){
        response.contentType = "application/json"
        val iUsuarioNombre = String.valueOf(usuarioNombre)
        val iUsuarioPassword = String.valueOf(usuarioPassword)

        try {
            ok(efectuarLogin(iUsuarioNombre, iUsuarioPassword).toJson())
        }
        catch (BaseControlGastosException e) {
            forbidden(e.message.toJson());
        }
    }

    @Post("/logout/:usuarioId")
    def logoutEndPoint(){
        response.contentType = "application/json"
        val iUsuarioId = Integer.valueOf(usuarioId)

        try {
            efectuarLogout(iUsuarioId)
            ok()
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message.toJson());
        }
    }

    @Put("/registracion/:usuarioNombre/:usuarioPassword")
    def registracionEndPoint(){
        response.contentType = "application/json"
        val iUsuarioNombre = String.valueOf(usuarioNombre)
        val iUsuarioPassword = String.valueOf(usuarioPassword)

        try {
            ok(efectuarRegistracion(iUsuarioNombre, iUsuarioPassword).toJson())
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message.toJson());
        }
    }

    @Put("/gastos/:descripcion/:monto/:usuarioId")
    def nuevoGastoEndpoint(){
        response.contentType = "application/json"
        val iDescripcion = String.valueOf(descripcion)
        val iMonto = Double.valueOf(monto)
        val iUsuarioId = Integer.valueOf(usuarioId)

        try {
            controladorUsuarios.validarUsuarioLogueado(iUsuarioId)
            ok(efectuarCreacionDeGasto(iDescripcion, iMonto, iUsuarioId).toJson())
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message.toJson());
        }
    }

    @Get("/gastos/:descripcion/:usuarioId")
    def gastosDeDescripcionEndpoint(){
        response.contentType = "application/json"
        val iDescripcion = String.valueOf(descripcion)
        val iUsuarioId = Integer.valueOf(usuarioId)

        try {
            controladorUsuarios.validarUsuarioLogueado(iUsuarioId)
            ok(traerGastosDeDescripcion(iDescripcion, iUsuarioId).toJson())
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message.toJson());
        }
    }

    @Get("/gastos/:usuarioId")
    def gastosDelUsuarioEndpoint(){
        response.contentType = "application/json"
        val iUsuarioId = Integer.valueOf(usuarioId)

        try {
            controladorUsuarios.validarUsuarioLogueado(iUsuarioId)
            ok(traerGastos(iUsuarioId).toJson())
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message.toJson());
        }
    }

    @Get("/indice/:anio/:descripcion/:usuarioId")
    def indiceInflacionarioEndpoint(){
        response.contentType = "application/json"
        val iDescripcion = String.valueOf(descripcion)
        val iUsuarioId = Integer.valueOf(usuarioId)
        val iAnio = Integer.valueOf(anio)

        try {
            controladorUsuarios.validarUsuarioLogueado(iUsuarioId)
            ok(traerIndiceInflacionario(iAnio, iDescripcion, iUsuarioId).toJson())
        }
        catch (BaseControlGastosException e) {
            badRequest(e.message.toJson());
        }
    }

    def efectuarLogout(Integer usuarioId){
        controladorUsuarios.logout(usuarioId)
    }

    def traerIndiceInflacionario(Integer anio, String descripcion, Integer usuarioId){
        val usuario = controladorUsuarios.usuarioConId(usuarioId)
        val indiceAnual = controladorGastos.calcularIndiceInflacionarioAnual(anio, descripcion, usuario)
        val detalleIndice = controladorGastos.calcularDetalleIndiceInflacionario(anio, descripcion, usuario)

        responses.responseFor(indiceAnual, detalleIndice)
    }

    def traerGastos(Integer usuarioId){
        val usuario = controladorUsuarios.usuarioConId(usuarioId)
        val gastos = controladorGastos.todosLosGastos(usuario)
        val total = controladorGastos.total(usuario)

        responses.responseFor(gastos, total)
    }
    def traerGastosDeDescripcion(String descripcion, Integer usuarioId){
        val gastos = controladorGastos.filtrarPorDescripcion(
                controladorUsuarios.usuarioConId(usuarioId),
                descripcion)

        val totalParcial = controladorGastos.totalParcial(gastos)

        responses.responseFor(gastos, totalParcial)
    }

    def efectuarCreacionDeGasto(String descripcion, Double monto, Integer usuarioId){
        val usuario = controladorUsuarios.usuarioConId(usuarioId)

        controladorGastos.agregarGasto(descripcion, monto, usuario)
        val gastos = controladorGastos.todosLosGastos(usuario)
        val total = controladorGastos.total(usuario)

        responses.responseFor(gastos, total)
    }

    def efectuarRegistracion(String usuarioNombre, String usuarioPassword){
        responses.responseFor(controladorUsuarios.registrar(usuarioNombre, usuarioPassword))
    }

    def efectuarLogin(String usuarioNombre, String usuarioPassword){
        responses.responseFor(controladorUsuarios.login(usuarioNombre, usuarioPassword))
    }

    def static void main(String[] args) {
        XTRest.start(ControlGastosController, 9000)
    }
}