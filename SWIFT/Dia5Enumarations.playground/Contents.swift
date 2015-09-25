//: Playground - noun: a place where people can play

import UIKit

enum Bussola {
    case Norte, Sul, Leste, Oeste
}

let direcaoAtual = Bussola.Leste

switch direcaoAtual {
case .Norte:
    println("Estamos indo para o Norte")
case .Sul:
    println("Estamos indo para o Sul")
case .Leste:
    println("Estamos indo para o Leste")
case .Oeste:
    println("Estamos indo para o Oeste")
default:
    println("Você esta no espaço")
}

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

var meuBarCodeUPCA = Barcode.UPCA(1, 2, 3)
var meuBarCodeQR = Barcode.QRCode("XPTO")


enum Planeta : Int {
    case Mercurio = 1, Venus, Terra, Marte, Plutao
}

let posicaoDoPlaneta = Planeta.Terra.rawValue
let umPlaneta = Planeta(rawValue: 12)
let posicao2 = umPlaneta?.rawValue

let outroPlaneta = Planeta.Venus
let posicao3 = outroPlaneta.rawValue





