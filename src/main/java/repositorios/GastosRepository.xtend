package repositorios

import java.util.List
import model.Gasto
import model.Usuario
import model.ValidadorParametros

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

    def getGastosPorDescripcion(Usuario usuario, String descripcionBuscada){
        getGastosPorUsuario(usuario).filter[gasto | gasto.descripcion == descripcionBuscada]
    }

    def getGastosPorAnioDescripcion(Integer anio, Usuario usuario, String descripcionBuscada){
        getGastosPorDescripcion(usuario, descripcionBuscada).filter[gasto | gasto.fechaCreacion.getYear() == anio]
    }

    def validarParametrosNoNulos(String descripcionGasto, Double montoGasto, Usuario usuarioGasto){
        ValidadorParametros.para("DESCRIPCION", descripcionGasto).validar()
        ValidadorParametros.para("MONTO", montoGasto).validar()
        ValidadorParametros.para("USARIO", usuarioGasto).validar()
    }
}