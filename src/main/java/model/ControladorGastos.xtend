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
        sumarizar(gastosDelUsuario)
    }

    def totalParcial(Iterable<Gasto> gastos){
        sumarizar(gastos)
    }

    def sumarizar(Iterable<Gasto> gastos){
        var double sum = 0

        for(gasto:gastos){
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
        textoNormalizado
    }

    def calcularIndiceInflacionarioAnual(Integer anio, String descripcion, Usuario usuario){
        val gastosDelUltimoAnio = gastosDelUltimoAnioOrdenadosPorFecha(anio, descripcion, usuario)

        if(gastosDelUltimoAnio.isEmpty){
            return 0
        }

        CalculadorIndiceInflacionario.para(
                gastosDelUltimoAnio.last().monto,
                gastosDelUltimoAnio.head().monto)
        .calcular()
    }

    def calcularDetalleIndiceInflacionario(Integer anio, String descripcion, Usuario usuario){
        val gastosDelUltimoAnio = gastosDelUltimoAnioOrdenadosPorFecha(anio, descripcion, usuario)
        if(gastosDelUltimoAnio.isEmpty){
            return newArrayList()
        }
        CalculadorDetalleInflacionario.para(gastosDelUltimoAnio).calcular()
    }

    def gastosDelUltimoAnioOrdenadosPorFecha(Integer anio, String descripcion, Usuario usuario){
        var gastosDelUltimoAnio = gastosRepo.getGastosPorAnioDescripcion(anio, usuario, normalizar(descripcion))
        gastosDelUltimoAnio.sortBy[fechaCreacion]
    }
}