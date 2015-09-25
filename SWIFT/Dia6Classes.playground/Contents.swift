//: Playground - noun: a place where people can play

import UIKit

class umaClasse {
    
    var nome : String
    
    init (oNome: String) {
        self.nome = oNome
    }
    
}

var classe1 = umaClasse(oNome: "Lucas")
classe1.nome

var classe2 = classe1
classe2.nome
classe2.nome = "Elena"

classe1.nome
classe2.nome

// EXEMPLO DE ESTRUTURA
struct umStruct {
    
    var nome : String
    
    init (oNome: String) {
        self.nome = oNome
    }
    
}

var umStruct1 = umStruct(oNome: "Lucas")
umStruct1.nome

var umStruct2 = umStruct1
umStruct2.nome
umStruct2.nome = "Elena"

umStruct1.nome
umStruct2.nome


// EXEMPLO DE INICIALIZACAO
struct outraClasse {
    var nome : String
    var idade : Int
    
    init (nome: String, idade: Int) {
        self.nome = nome
        self.idade = idade
    }
    
    init () {
        self.nome = "Nome default"
        self.idade = 10
    }
}
var myOutraClasse = outraClasse(nome: "XPTO", idade: 3)
var myOutraClasse2 = outraClasse()

// EXTENSÕES
extension outraClasse {
    func description() {
        println("Meu nome é \(nome) e tenho \(idade) anos de idade")
    }
}

myOutraClasse.description()





