//: Playground - noun: a place where people can play

import UIKit

// Função sem parametros de entrada e sem valor de retorno
func sairDoPrograma() {
    println("Estou saindo do programa")
}

sairDoPrograma()

// Função com 1 parametro de entrada e sem valor de retorno
func digaOlaPara(nome: String) {
    let text = "Olá " + nome + "!"
    //text = "Olá \(nome)!"
    println(text)
}

digaOlaPara("Lucas")

// Função com 2 parametros de entrada e sem valor de retorno
func somar(primeiroNumero: Int, comSegundoNumero: Int) {
    let soma = primeiroNumero + comSegundoNumero
    println(soma)
}

somar(40,50)

// Função sem parametros de entrada e com valor de retorno
func temperaturaAtual() -> Double {
    let temperatura = 36.5
    return temperatura
}

let minhaTemperatura = temperaturaAtual()
println(minhaTemperatura)

// Função com 1 parametro de entrada e com valor de retorno
func converterParaFarenheit(temperaturaEmCelcius: Double) -> Double {
    let farenheit = temperaturaEmCelcius * (9/5) + 32
    return farenheit
}

let tempEmFar = converterParaFarenheit(15)
println(tempEmFar)

// Função com 1 parametro de entrada e com multiplos valores de retorno

func estatisticas(listaDeNumeros: [Double]) -> (min: Double, max: Double, media: Double) {
    
    var minVal = listaDeNumeros[0]
    var maxVal = minVal
    
    for val in listaDeNumeros[1..<listaDeNumeros.count] {
        if val < minVal {
            minVal = val
        }
        if val > maxVal {
            maxVal = val
        }
    }
    
    var total = 0.0
    for val in listaDeNumeros {
        total += val
    }
    
    let mediaVal = total / Double(listaDeNumeros.count)
    
    return(minVal, maxVal, mediaVal)
}

let numeros = [22.3,25.5,235.5,51.0,-266.2,1000000.0]
let resultado = estatisticas(numeros)
println("Min: \(resultado.min) Max: \(resultado.max) Media: \(resultado.media)")

// Função que não requer nome de parametros
func join(s1: String, s2: String, separador: String) -> String {
    return s1 + separador + s2
}

var text = join("texto 1", "texto 2", " *** ")

// Função que requer o nome dos parametros na chamada
func joinNamed(textoInicial s1: String, textoFinal s2: String, textoMeio separador: String) -> String {
    return s1 + separador + s2
}

text = joinNamed(textoInicial: "texto 1", textoFinal: "texto 2", textoMeio: " *** ")

// Função com um dos parametros com valor inicial (default) e portanto é um parametro opcional na chamada
func joinNamedOcional(var textoInicial s1: String, textoFinal s2: String, textoMeio separador: String = " - ") -> String {
    s1 = "xpto"
    return s1 + separador + s2
}
// Repare que na chamada não passamos o textoMeio (separador)
text = joinNamedOcional(textoInicial: "texto 1", textoFinal: "texto 2")

// Passagem de parametros via referencia (pointer)
func trocar2Ints(inout a: Int, inout b:Int) {
    let aTmp = a
    a = b
    b = aTmp
}

var aOriginal = 10
var bOriginal = 99

trocar2Ints(&aOriginal, &bOriginal)
println("\(aOriginal) \(bOriginal)")


// Atribuir uma função a uma variavel
func soma2Ints(int1: Int, int2: Int) -> Int {
    return int1 + int2
}
func sub2Ints(int1: Int, int2: Int) -> Int {
    return int1 - int2
}

var mathFunc : (Int, Int) -> Int

let test = false

if test {
    mathFunc = soma2Ints
}
else {
    mathFunc = sub2Ints
}

mathFunc(3,4)


