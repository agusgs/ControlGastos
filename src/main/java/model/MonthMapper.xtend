package model

import org.joda.time.DateTime
import java.time.MonthDay

class MonthMapper {

    DateTime fecha

    static def forDate(DateTime fecha){
        new MonthMapper(fecha)
    }

    new(DateTime fecha){
        this.fecha = fecha
    }

    def getInSpanish(){
        val month = fecha.getMonthOfYear()

        switch(month){
            case 1:
                return "Enero"
            case 2:
                return "Febrero"
            case 3:
                return "Marzo"
            case 4:
                return "Abril"
            case 5:
                return "Mayo"
            case 6:
                return "Junio"
            case 7:
                return "Julio"
            case 8:
                return "Agosto"
            case 9:
                return "Septiembre"
            case 10:
                return "Octubre"
            case 11:
                return "Noviembre"
            case 12:
                return "Diciembre"
            default:
                throw new UnsupportedOperationException("Mes inexistente")
        }
    }
}