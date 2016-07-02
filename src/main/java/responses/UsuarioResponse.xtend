package responses

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class UsuarioResponse {

    Integer id
    String nombre

    new(Integer id, String nombre){
        this.id = id
        this.nombre = nombre
    }
}