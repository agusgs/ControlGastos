package responses

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class FechaResponse {
    Integer dia
    Integer mes
    Integer anio

    new(Integer dia, Integer mes, Integer anio){
        this.dia = dia
        this.mes = mes
        this.anio = anio
    }
}