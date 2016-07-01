package model

import org.joda.time.DateTime
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Gasto {
    
    DateTime fechaCreacion
    String descripcion
    Double monto
    Usuario usuario

    new(String descripcion, Double monto, Usuario usuario){
        this.fechaCreacion = DateTime.now()
        this.descripcion = descripcion
        this.monto = monto
        this.usuario = usuario
    }
}