//: Playground - noun: a place where people can play

import UIKit

enum RegulagemDeAltura {
    case Baixo, Medio, Alto
    
    mutating func next() {
        switch self {
        case Baixo:
            self = Medio
        case Medio:
            self = Alto
        case Alto:
            self = Baixo
        }
    }
    
    func description() -> String {
        switch self {
        case Medio:
            return "Regulagem: Media"
        case Alto:
            return "Regulagem: Alta"
        case Baixo:
            return "Regulagem: Baixa"
        }
    }
}

var alturaDoCarro = RegulagemDeAltura.Medio
println(alturaDoCarro.description())
alturaDoCarro.next()
println(alturaDoCarro.description())
alturaDoCarro.next()
println(alturaDoCarro.description())

