//: Playground - noun: a place where people can play

import UIKit

struct Tamanho {
    var largura = 0.0
    var altura = 0.0
}

struct Ponto {
    var x = 0.0
    var y = 0.0
}

struct Rect {
    var origem = Ponto()
    var tamanho = Tamanho()
}

var rectZero = Rect()

var origem = Ponto(x: 3.4, y: 4.5)
var tamanho = Tamanho(largura: 10.0, altura: 20.0)
var novoRect = Rect(origem: origem, tamanho: tamanho)

extension Rect {
    init(pontoCentral: Ponto, tamanho: Tamanho) {
        self.origem.x = pontoCentral.x - tamanho.largura/2
        self.origem.y = pontoCentral.y - tamanho.altura/2
        self.tamanho = tamanho
    }
}

var pontoCentral = Ponto(x: 4.5, y: 3.4)
var tamanho2 = Tamanho(largura: 10.0, altura: 10.0)
var rect2 = Rect(pontoCentral: pontoCentral, tamanho: tamanho2)

// EXTENSAO PARTE 2
extension Int {
    func repeticoes(tarefa: () -> ()) {
        for i in 0..<self {
            tarefa()
        }
    }
    
    mutating func quadrada() {
        self = self * self
    }
    
    enum Kind {
        case Negativo
        case Zero
        case Positivo
    }
    
    var kind : Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positivo
        default:
            return .Negativo
        }
    }
}

var meuInt = 3

meuInt.repeticoes({
    println("Olá")
})

meuInt.quadrada()

func retornarKinds(ints: [Int]) {
    for i in ints {
        switch i.kind {
        case .Negativo:
            println("- ")
        case .Positivo:
            println("+ ")
        case .Zero:
            println("0 ")
        default:
            println("ooops... não sei o que é isso")
        }
    }
}

retornarKinds([20,366,-65,0,-55,500])






