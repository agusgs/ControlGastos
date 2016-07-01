package repositorios

import model.Gasto
import java.util.List
import model.Usuario

class GastosRepository {

    List<Gasto> gastos

    new(){
        this.gastos = newArrayList()
    }

    def create(String descripcionGasto, Double montoGasto, Usuario usuarioGasto){
        validarParametrosNoNulos(descripcionGasto, montoGasto, usuarioGasto)

        val gastoNuevo = new Gasto(descripcionGasto, montoGasto, usuarioGasto)
        this.gastos.add(gastoNuevo)

        gastoNuevo
    }

    def getGastosPorUsuario(Usuario usuario){
        this.gastos.filter[gasto | gasto.usuario == usuario]
    }
}