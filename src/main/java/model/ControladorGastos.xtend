package model

import repositorios.GastosRepository

class ControladorGastos {

    GastosRepository gastosRepo

    new(GastosRepository gastosRepo){
        this.gastosRepo = gastosRepo
    }

    def agregarGasto(String descripcionGasto, Double montoGasto, Usuario usuarioGasto){
        gastosRepo.create( normalizar(descripcionGasto), montoGasto, usuarioGasto)
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

    def filtrarPorDescripcion(Usuario usuario, String descripcionBuscada){
        gastosRepo.getGastosPorDescripcion(usuario, normalizar(descripcionBuscada))
    }

    def normalizar(String textoANormalizar){
        var textoNormalizado = textoANormalizar
        textoNormalizado = textoNormalizado.toUpperCase()
        textoNormalizado = textoNormalizado.trim()
        System.out.println(textoNormalizado.trim())
        System.out.println(textoNormalizado)
        textoNormalizado
    }
}