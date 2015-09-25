//: Playground - noun: a place where people can play

import UIKit

var pessoa = [
    "nome":"Lucas",
    "idade":"40",
    "altura":"1.85",
]

var nome = pessoa["nome"]
var idade = pessoa["idade"]
var filhos = pessoa["filhos"]

println("O nome da pessoa é \(nome)")
println("\(nome) tem \(idade) anos")
println("\(nome) tem \(filhos) filhos")

if let nome = pessoa["nome"] {
    println("O nome da pessoa é \(nome)")
}

pessoa["filhos"] = "João e Maria"

if let filhos = pessoa["filhos"] {
    println("Meus filhos são \(filhos)")
}
else {
    println("Não tem filhos")
}

var pessoas = [pessoa]

pessoa = [
    "nome":"Elena",
    //"idade":"39",
    "altura":"1.70"
]

pessoas.append(pessoa)

pessoas.count

let irma = pessoas[1]
let nomeIrma = irma["nome"]
let idadeIrma = irma["idade"]

for pessoa in pessoas {
    if let nome = pessoa["nome"] {
        if let idade = pessoa["idade"] {
            println("\(nome) tem \(idade) anos de idade")
        }
        else {
            println("Não sei quantos anos tem \(nome)")
        }
    }
}

