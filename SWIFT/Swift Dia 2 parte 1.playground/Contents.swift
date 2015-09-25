//: Playground - noun: a place where people can play

import UIKit

var str = "Minha idade é "
var idade = 10 + 40
var nome = "Lucas"

var resultado = str + String(idade)
println(resultado)

var r2 = "Minha idade e \(idade) e me chamo \(nome)"

var stringVazia = ""

if stringVazia.isEmpty {
    println("string vazio")
}

println(resultado + " " + r2 + String(idade))

println(resultado + " " + r2 + "\(idade)")

for char in resultado {
    println(char)
}

var stringVazio : String? = "inicializa"
let character : Character = "x"
str.append(character)

let multiplicador = 3
let res = Double(multiplicador) * 3.5
let mensagem = "O multiplicador é \(multiplicador) x 3.5 resulta em \(res)"


var array = [
    "Ato 1 : Cena 1",
    "Ato 1 : Cena 2",
    "Ato 2 : Cena 1",
]

var count = 0
var count2 = 0

for cena in array {
    if cena.hasPrefix("Ato 2") {
        count++
    }
    if cena.hasSuffix("Cena 1") {
        count2++
    }
}

println("Encontrei \(count) prefix no array")
println("Encontrei \(count2) sufix no array")

var 😝 = "cara louca é 😝"
var 🎃 = 1000.04

println(😝)


















