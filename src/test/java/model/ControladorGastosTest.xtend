package model

import org.junit.Test
import org.junit.Before
import repositorios.GastosRepository
import static org.assertj.core.api.Assertions.*
import org.joda.time.DateTime

class ControladorGastosTest {

    ControladorGastos controladorGastos
    Usuario usuario

    @Before
    def void setUp(){
        this.usuario = new Usuario(1, "agus", "pass1")
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
        val otroUsuario = new Usuario(1, "otroUsuario", "pass1234")

        controladorGastos.agregarGasto("nuevo gasto", 100.0, usuario)
        controladorGastos.agregarGasto("otoro gasto", 200.0, usuario)

        controladorGastos.agregarGasto("gasto del otro usuario", 100.0, otroUsuario)

        assertThat(controladorGastos.total(usuario)).isEqualTo(300.0)
    }

    @Test
    def void siNoHayGastosIngresadosElResultadoDeFiltrarEsUnaListaVacia(){
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "descripcion").isEmpty).isTrue()
    }

    @Test
    def void siAgregoUnGastoYFiltroPorLaDescripcionDeEsteElResultadoEsUnaListaConEseGasto(){

        val miGasto = controladorGastos.agregarGasto("gasto ingresado", 1.0, usuario)

        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado").size).isEqualTo(1)
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado").get(0)).isEqualTo(miGasto)
    }

    @Test
    def void filtrarConVariosGastos(){
        val miGasto1 = controladorGastos.agregarGasto("gasto ingresado", 1.0, usuario)
        val miGasto2 = controladorGastos.agregarGasto("gasto ingresado", 2.0, usuario)
        val miGasto3 = controladorGastos.agregarGasto("otro gasto ingresado", 10.0, usuario)

        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado").size).isEqualTo(2)
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado")
            .exists[gasto | gasto == miGasto1])
            .isTrue()
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado")
            .exists[gasto | gasto == miGasto2])
            .isTrue()
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado")
            .exists[gasto | gasto == miGasto3])
            .isFalse()
    }

    @Test
    def void filtrarConVariosUsuariosConVariosGastos(){

        val otroUsuario = new Usuario(1, "otro usuario", "pass1234")

        val miGasto1 = controladorGastos.agregarGasto("gasto ingresado", 1.0, usuario)
        val miGasto2 = controladorGastos.agregarGasto("gasto ingresado", 2.0, usuario)
        val miGasto3 = controladorGastos.agregarGasto("gasto ingresado", 10.0, otroUsuario)

        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado").size).isEqualTo(2)
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado")
        .exists[gasto | gasto == miGasto1])
        .isTrue()
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado")
        .exists[gasto | gasto == miGasto2])
        .isTrue()
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto ingresado")
        .exists[gasto | gasto == miGasto3])
        .isFalse()
    }

    @Test
    def void filtrarPorConceptoAgregandoEspaciosALaDescripcionDaElMismoResultado(){
        val miGasto1 = controladorGastos.agregarGasto("gasto ingresado", 1.0, usuario)
        val miGasto2 = controladorGastos.agregarGasto("gasto ingresado", 2.0, usuario)

        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "   gasto ingresado ")
        .exists[gasto | gasto == miGasto1])
        .isTrue()
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "   gasto ingresado ")
        .exists[gasto | gasto == miGasto2])
        .isTrue()
    }

    @Test
    def void filtrarPorConceptoNoEsCaseSensitive(){
        val miGasto1 = controladorGastos.agregarGasto("gasto ingresado", 1.0, usuario)
        val miGasto2 = controladorGastos.agregarGasto("gasto ingresado", 2.0, usuario)

        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "GASTO ingresado")
        .exists[gasto | gasto == miGasto1])
        .isTrue()
        assertThat(controladorGastos.filtrarPorDescripcion(usuario, "gasto INGREsado")
        .exists[gasto | gasto == miGasto2])
        .isTrue()
    }

    @Test
    def void siNoHayGastosIngresadosElIndiceInflacionarioEs0(){
        assertThat(controladorGastos.calcularIndiceInflacionarioAnual(2016, "un gasto", usuario)).isEqualTo(0.0)
    }

    @Test
    def void siHayUnGastoIngresadoElIndiceEs0(){
        controladorGastos.agregarGasto("un gasto", 1.0, usuario)
        assertThat(controladorGastos.calcularIndiceInflacionarioAnual(2016, "un gasto", usuario)).isEqualTo(0.0)
    }

    @Test
    def void indiceConDosGastosElMismoAnio(){
        controladorGastos.agregarGasto("papas", 1.0, usuario)
        controladorGastos.agregarGasto("papas", 2.0, usuario)

        assertThat(controladorGastos.calcularIndiceInflacionarioAnual(2016, "papas", usuario)).isEqualTo(50.0)
    }

    @Test
    def void indiceConVariosGastosElMismoAnioEnDistintosMeses(){
        val miGasto1 = controladorGastos.agregarGasto("papas", 1.0, usuario)
        val miGasto2 = controladorGastos.agregarGasto("papas", 2.0, usuario)
        val miGasto3 = controladorGastos.agregarGasto("papas", 5.0, usuario)

        miGasto1.fechaCreacion = new DateTime(2016, 6, 6, 6, 6)
        miGasto2.fechaCreacion = new DateTime(2016, 7, 6, 6, 6)
        miGasto3.fechaCreacion = new DateTime(2016, 8, 6, 6, 6)

        assertThat(controladorGastos.calcularIndiceInflacionarioAnual(2016, "papas", usuario)).isEqualTo(80.0)
    }

    @Test
    def void indiceConGastosEnDistintosAnios(){
        val miGasto1 = controladorGastos.agregarGasto("papas", 1.0, usuario)
        val miGasto2 = controladorGastos.agregarGasto("papas", 2.0, usuario)
        val miGasto3 = controladorGastos.agregarGasto("papas", 5.0, usuario)
        val miGasto4 = controladorGastos.agregarGasto("papas", 123.0, usuario)

        miGasto1.fechaCreacion = new DateTime(2016, 6, 6, 6, 6)
        miGasto2.fechaCreacion = new DateTime(2016, 7, 6, 6, 6)
        miGasto3.fechaCreacion = new DateTime(2015, 8, 6, 6, 6)
        miGasto4.fechaCreacion = new DateTime(2015, 8, 6, 6, 6)

        assertThat(controladorGastos.calcularIndiceInflacionarioAnual(2016, "papas", usuario)).isEqualTo(50.0)
    }

    @Test
    def void siNoHayGastosIngresadosElDetalleDeIndiceElListaVacia(){
        assertThat(controladorGastos.calcularDetalleIndiceInflacionario(2016, "un gasto", usuario).isEmpty())
            .isTrue()
    }

    @Test
    def void siHayUnGastoIngresadoElDetalleDeIndiceEsUnItemDe0(){
        controladorGastos.agregarGasto("un gasto", 1.0, usuario)
        val detalleIndice = controladorGastos.calcularDetalleIndiceInflacionario(2016, "un gasto", usuario)

        assertThat(detalleIndice.size()).isEqualTo(1)
        assertThat(detalleIndice.get(0).indice).isEqualTo(0.0)
    }

    @Test
    def void calculoDeDetalleDeIndice(){
        val miGasto1 = controladorGastos.agregarGasto("papas", 1.0, usuario)
        val miGasto2 = controladorGastos.agregarGasto("papas", 2.0, usuario)
        val miGasto3 = controladorGastos.agregarGasto("papas", 5.0, usuario)
        val miGasto4 = controladorGastos.agregarGasto("papas", 123.0, usuario)

        miGasto1.fechaCreacion = new DateTime(2016, 6, 6, 6, 6)
        miGasto2.fechaCreacion = new DateTime(2016, 7, 6, 6, 6)
        miGasto3.fechaCreacion = new DateTime(2016, 8, 6, 6, 6)
        miGasto4.fechaCreacion = new DateTime(2015, 8, 6, 6, 6)

        val detalleIndice = controladorGastos.calcularDetalleIndiceInflacionario(2016, "papas", usuario)

        assertThat(detalleIndice.size()).isEqualTo(3)
        assertThat(detalleIndice.get(0).indice).isEqualTo(0.0)
        assertThat(detalleIndice.get(1).indice).isEqualTo(50.0)
        assertThat(detalleIndice.get(2).indice).isEqualTo(60.0)
    }


}