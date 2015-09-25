//: Playground - noun: a place where people can play

import UIKit

class Veiculo {
    var marca : String
    var delegate : guiarVeiculo?
    
    init(marca: String) {
        self.marca = marca
    }
    
    func executarManobra() {
        println("Estou executando a manobra")
        delegate?.encherTanque()
    }
}

protocol guiarVeiculo {
    var veiculo : Veiculo { get }
    func virarCarro(angulo: Double, tempo: Double)
    func encherTanque()
}

class Pessoa : guiarVeiculo {
    var veiculo : Veiculo
    var nome : String
    
    init(veiculo: Veiculo, nome: String) {
        self.veiculo = veiculo
        self.nome = nome
    }
    
    func virarCarro(angulo: Double, tempo: Double) {
        veiculo.executarManobra()
    }
    
    func encherTanque() {
        println("Estou indo no posto de gasolina")
    }
}

var meuVeiculo = Veiculo(marca: "Volkswagen")
var umaPessoa = Pessoa(veiculo: meuVeiculo, nome: "Lucas")
meuVeiculo.delegate = umaPessoa

println("A pessoa \(umaPessoa.nome) tem um carro da marca \(umaPessoa.veiculo.marca)")

umaPessoa.virarCarro(10.0, tempo: 2.0)
