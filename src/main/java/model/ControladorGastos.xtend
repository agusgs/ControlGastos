package model

import repositorios.GastosRepository

class ControladorGastos {

    GastosRepository gastosRepo

    new(GastosRepository gastosRepo){
        this.gastosRepo = gastosRepo
    }

    def agregarGasto(String descripcionGasto, Double montoGasto, Usuario usuarioGasto){

        gastosRepo.create( descripcionGasto, montoGasto, usuarioGasto)
    }

    def todosLosGastos(Usuario usuario){
        gastosRepo.getGastosPorUsuario(usuario)
    }

    def total(Usuario usuario){
        val gastosDelUsuario = this.gastosRepo.getGastosPorUsuario(usuario)
        var double sum = 0

        for(gasto:gastosDelUsuario){
            sum = sum + gasto.monto
        }

        sum
    }
}