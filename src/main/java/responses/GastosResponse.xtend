package responses

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class GastosResponse {

    Iterable<GastoResponse> gastos
    Double total

    new(Iterable<GastoResponse> gastos, Double total){
        this.gastos = gastos
        this.total = total
    }
}