package controller

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import model.Session

@Controller
class ControlGastosController {

    Session session

    new(){
        session = new Session()
    }

    @Post("/login/:usuarioNombre/:usuarioPassword")
    def loginEndpoint(){
        response.contentType = "application/json"
        val iUsuarioNombre = String.valueOf(usuarioNombre)
        val iUsuarioPassword = String.valueOf(usuarioPassword)

        try {
            efectuarLogin(iUsuarioNombre, iUsuarioPassword)
            ok()
        }
        catch (RuntimeException e) {
            forbidden(e.message);
        }
    }

    def efectuarLogin(String usuarioNombre, String usuarioPassword){
        session.login(usuarioNombre, usuarioPassword)
    }
}