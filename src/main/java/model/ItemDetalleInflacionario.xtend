package model

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ItemDetalleInflacionario {
    String mes
    Double monto
    Double indice

    new(DateTime fechaCreacion, Double monto, Double indice){
        this.mes = MonthMapper.forDate(fechaCreacion).getInSpanish()
        this.monto = monto
        this.indice = indice
    }
}