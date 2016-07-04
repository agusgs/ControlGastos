package model

import exceptions.UsuarioInexistenteException
import org.junit.Before
import org.junit.Test
import static org.assertj.core.api.Assertions.*
import repositorios.UsuariosRepository
import exceptions.UsuarioYaEstaLogueadoException

class SessionFactoryTest {

    ControladorUsuarios sessionFactory
    UsuariosRepository repoUsuarios

    @Before
    def void setUp(){
        repoUsuarios = new UsuariosRepository()
        sessionFactory = new ControladorUsuarios(repoUsuarios)
    }

    @Test
    def void noSeDeberiaLoguarUnUsuarioQueNoExiste(){

        try{
            sessionFactory.login("UsuarioInexistente", "pass123")
            failBecauseExceptionWasNotThrown(UsuarioInexistenteException)
        }catch(UsuarioInexistenteException e){
            //NADA QUE VALIDAR
        }
    }

    @Test
    def void unUsuarioSeLogueaOk(){

        val usuarioTest = "interfaces"
        val passwordTest = "pass123"

        repoUsuarios.create(usuarioTest, passwordTest)
        sessionFactory.login(usuarioTest, passwordTest)

        val usuario = repoUsuarios.getUsuarioPorNombre(usuarioTest)

        assertThat(usuario.logueado).isTrue
    }

}