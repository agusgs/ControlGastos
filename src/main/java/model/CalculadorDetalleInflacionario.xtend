package model

import java.util.List

class CalculadorDetalleInflacionario {

    Iterable<Gasto> gastos
    final Double INDICE_INICIAL = 0.0

    static def para(Iterable<Gasto> gastos){
        new CalculadorDetalleInflacionario(gastos)
    }

    new(Iterable<Gasto> gastos){
        this.gastos = gastos
    }

    def calcular(){
        val List<ItemDetalleInflacionario> detalleInflacionario = newArrayList()
        var indice = 0

        while(indice < gastos.size) {
            val gasto = gastos.get(indice)
            if(indice == 0){
                detalleInflacionario.add(new ItemDetalleInflacionario(gasto.fechaCreacion, gasto.monto, INDICE_INICIAL))
            }else{
                val montoActual = gasto.monto
                val mesAnterior = gastos.get(indice - 1).monto
                detalleInflacionario.add(
                        new ItemDetalleInflacionario(
                                gasto.fechaCreacion,
                                gasto.monto,
                                CalculadorIndiceInflacionario.para(montoActual, mesAnterior).calcular))
            }
            indice ++
        }
        return detalleInflacionario
    }
}