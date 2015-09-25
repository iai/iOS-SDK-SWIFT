//: Playground - noun: a place where people can play

import UIKit

var filme = [
    "nome":"Pulp Fiction",
    "diretor":"Tarantino",
    "genero":"Suspense",
    "ano":"2007"
]

filme.count

filme.removeValueForKey("diretor")

filme.count

filme["pais"] = "USA"

filme.count

for (chave,valor) in filme {
    println("\(chave) : \(valor)")
}

