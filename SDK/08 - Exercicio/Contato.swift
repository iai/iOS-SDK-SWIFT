import Foundation

struct Contato {
    let nome: String
    let sobrenome: String
    let telefone: String
    var favorito: Bool
    
    var dicionario: NSDictionary {
        return ["nome":nome, "sobrenome": sobrenome, "telefone": telefone, "favorito": favorito]
    }
    
    init(nome:String, sobrenome:String, telefone:String){
        self.nome = nome
        self.sobrenome = sobrenome
        self.telefone = telefone
        self.favorito = false
    }
    
    init(info:NSDictionary){
        self.nome = info["nome"] as String
        self.sobrenome = info["sobrenome"] as String
        self.telefone = info["telefone"] as String
        self.favorito = info["favorito"] as Bool
    }
}


