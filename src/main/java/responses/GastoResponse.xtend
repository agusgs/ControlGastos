package responses

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors
import model.MonthMapper

@Accessors
class GastoResponse {

    Double monto
    String descripcion
    String mesAnio

    new(Double monto, String descripcion, DateTime fechaCreacion){
        this.monto = monto
        this.descripcion = descripcion
        this.mesAnio = armarMesAnio(fechaCreacion)
    }

    def armarMesAnio(DateTime fecha){
        var mesAnio = MonthMapper.forDate(fecha).getInSpanish()
        mesAnio += " (" + fecha.getYear().toString() + ")"
        mesAnio
    }
}