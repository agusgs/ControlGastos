package controller

import model.Gasto
import model.ItemDetalleInflacionario
import model.Usuario
import responses.GastoResponse
import responses.GastosResponse
import responses.IndiceResponse
import responses.UsuarioResponse

class Responses {

    def responseFor(Usuario usuario){
        new UsuarioResponse(usuario.id, usuario.nombre)
    }

    def responseFor(Iterable<Gasto> gastos, Double total){
        new GastosResponse( responseParaCadaGasto(gastos), total)
    }

    def responseFor(Double indiceAnual, Iterable<ItemDetalleInflacionario> detalles){
        new IndiceResponse(indiceAnual, detalles)
    }

    def responseParaCadaGasto(Iterable<Gasto> gastos){
        var gastosReducidos = newArrayList()

        for(gasto:gastos){
            gastosReducidos.add(new GastoResponse(gasto.monto, gasto.descripcion, gasto.fechaCreacion))
        }

        gastosReducidos

    }
}