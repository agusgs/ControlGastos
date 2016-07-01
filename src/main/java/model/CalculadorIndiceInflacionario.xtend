package model

class CalculadorIndiceInflacionario {

    Double indiceFinal
    Double indiceInicial
    def static para(Double indiceFinal, Double indiceInicial){
        new CalculadorIndiceInflacionario(indiceFinal, indiceInicial)
    }

    new(Double indiceFinal, Double indiceInicial){
        this.indiceFinal = indiceFinal
        this.indiceInicial = indiceInicial
    }

    def calcular(){
        ((indiceFinal - indiceInicial) / indiceFinal) * 100
    }
}