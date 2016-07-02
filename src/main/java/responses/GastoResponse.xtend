package responses

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class GastoResponse {

    Double monto
    String descripcion
    FechaResponse fechaCreacion

    new(Double monto, String descripcion, DateTime fechaCreacion){
        this.monto = monto
        this.descripcion = descripcion
        this.fechaCreacion = crearFechaResponse(fechaCreacion)
    }

    def crearFechaResponse(DateTime fecha){
        new FechaResponse(fecha.getDayOfMonth(), fecha.getMonthOfYear(), fecha.getYear())
    }
}