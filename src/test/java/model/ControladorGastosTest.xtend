package model

import org.junit.Test
import org.junit.Before
import repositorios.GastosRepository
import static org.assertj.core.api.Assertions.*

class ControladorGastosTest {

    ControladorGastos controladorGastos
    Usuario usuario

    @Before
    def void setUp(){
        this.usuario = new Usuario("agus", "pass1")
        this.controladorGastos = new ControladorGastos(new GastosRepository)
    }

    @Test
    def void siAgregoUnGastoElTotalDeGastosEsIgualAElMontoDelGasto(){
        controladorGastos.agregarGasto("nuevo gasto", 105.65, usuario)

        assertThat(controladorGastos.total(usuario)).isEqualTo(105.65)
    }

    @Test
    def void elTotalDeGastosEs0CuandoNoHayGastos(){
        assertThat(controladorGastos.total(usuario)).isEqualTo(0)
    }

    @Test
    def void elTotalDeGastosEsLaSumaDeLosGastosExistentes(){
        controladorGastos.agregarGasto("nuevo gasto", 100.0, usuario)
        controladorGastos.agregarGasto("otoro gasto", 200.0, usuario)
        controladorGastos.agregarGasto("otoro gasto mas", 300.0, usuario)

        assertThat(controladorGastos.total(usuario)).isEqualTo(600)
    }

    @Test
    def void elTotalDeGastosEsLaSumaDeLosGastosDeUnUsuario(){
        val otroUsuario = new Usuario("otroUsuario", "pass1234")

        controladorGastos.agregarGasto("nuevo gasto", 100.0, usuario)
        controladorGastos.agregarGasto("otoro gasto", 200.0, usuario)

        controladorGastos.agregarGasto("gasto del otro usuario", 100.0, otroUsuario)

        assertThat(controladorGastos.total(usuario)).isEqualTo(300.0)
    }
}