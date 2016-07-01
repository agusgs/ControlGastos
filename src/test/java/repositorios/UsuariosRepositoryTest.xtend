package repositorios

import org.junit.Test
import static org.assertj.core.api.Assertions.*
import repositorios.UsuariosRepository
import org.junit.Before
import exceptions.UsuarioDuplicadoException
import exceptions.PasswordMalFormadaException

class UsuariosRepositoryTest {

    UsuariosRepository usuariosRepo

    @Before
    def void setUp(){
        this.usuariosRepo = new UsuariosRepository()
    }

    @Test
    def void crearUnUsuarioOk(){
        val usuarioNombre = "rober"
        val usuarioPassword = "password1"

        val usuarioCreado = usuariosRepo.create(usuarioNombre, usuarioPassword)

        assertThat(usuarioCreado.nombre).isEqualTo(usuarioNombre)
        assertThat(usuarioCreado.password).isEqualTo(usuarioPassword)
        assertThat(usuariosRepo.all.size).isEqualTo(1)
    }

    @Test
    def void noSeDeberiaCrearUnUsuarioConUnNombreYaExistente(){

        val primerUsuarioNombre = "roberto"
        val primerUsuarioPassword = "password1"
        usuariosRepo.create(primerUsuarioNombre, primerUsuarioPassword)

        try{
            usuariosRepo.create("roberto", "otrapass123")
            failBecauseExceptionWasNotThrown(UsuarioDuplicadoException)
        }catch(UsuarioDuplicadoException e){
            val usuarios = usuariosRepo.all

            assertThat(usuarios.size()).isEqualTo(1)
            assertThat(usuarios.get(0).nombre).isEqualTo(primerUsuarioNombre)
            assertThat(usuarios.get(0).password).isEqualTo(primerUsuarioPassword)
        }
    }

    @Test
    def void noSeDeberiaCrearUnUsuarioConUnaPasswordSinUnNumero(){
        try{
            usuariosRepo.create("roberto", "lalalala")
            failBecauseExceptionWasNotThrown(PasswordMalFormadaException)
        }catch(PasswordMalFormadaException e){
            assertThat(usuariosRepo.all.size).isEqualTo(0)
        }
    }

    @Test
    def void noSeDeberiaCrearUnUsuarioConUnaPasswordDeMenosDe5Caracteres(){
        try{
            usuariosRepo.create("roberto", "12la")
            failBecauseExceptionWasNotThrown(PasswordMalFormadaException)
        }catch(PasswordMalFormadaException e){
            assertThat(usuariosRepo.all.size).isEqualTo(0)
        }
    }

}

