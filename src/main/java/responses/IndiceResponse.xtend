package responses

import org.eclipse.xtend.lib.annotations.Accessors

import model.ItemDetalleInflacionario

@Accessors
class IndiceResponse {

    Double indiceAnual
    Iterable<ItemDetalleInflacionario> detalles

    new(Double indiceAnual, Iterable<ItemDetalleInflacionario> detalles){
        this.indiceAnual = indiceAnual
        this.detalles = detalles
    }
}