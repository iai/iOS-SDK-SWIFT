//: Playground - noun: a place where people can play

import UIKit

var cidades = [
    "São Paulo",
    "Belo Horizonte",
    "Rio de Janeiro",
    "Curitiba",
    "Vitoria",
    "Brasilia",
    "Salvador",
    "Natal",
    "Recife",
    "Manaus"
]

println("Tenho \(cidades.count) cidades")

cidades.removeLast()
cidades.removeAtIndex(0)

println("Tenho \(cidades.count) cidades")

cidades.append("New York")
cidades.append("Miami")

cidades += ["Chicago", "São Franciso"]

cidades.insert("Los Angeles", atIndex: 1)

println("Tenho \(cidades.count) cidades")