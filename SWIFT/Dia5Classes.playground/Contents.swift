//: Playground - noun: a place where people can play

import UIKit

class Veiculo {
    
    var debug = ""
    
    var numeroDeRodas : Int = 0 {
        willSet(novoNumeroDeRodas) {
            debug = "Este veiculo tem \(numeroDeRodas) rodas, e agora vai ter \(novoNumeroDeRodas) rodas"
        }
        didSet {
            debug = "Este veiculo agora tem \(numeroDeRodas) rodas"
        }
    }
    
    var description : String {
        get {
            return "Este veiculo tem \(numeroDeRodas) rodas"
        }
        set {
            
        }
    }
}

var meuVeiculo = Veiculo()
meuVeiculo.numeroDeRodas = 4
var rodas = meuVeiculo.numeroDeRodas
println(meuVeiculo.numeroDeRodas)
println(meuVeiculo.description)

