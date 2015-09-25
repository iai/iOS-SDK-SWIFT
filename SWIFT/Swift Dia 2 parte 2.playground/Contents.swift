//: Playground - noun: a place where people can play

import UIKit

var listaDeCompras = ["Banana", "Maçã", "Alface", "Tomtate"]

println("Minha lista de compras tem \(listaDeCompras.count) itens")

println("O terceiro item da lista é \(listaDeCompras[2])")

// LISTA VAZIA
var listaDeComprasVazia : [String] = Array()
var listaDeComprasVazia2 = [String]()

listaDeComprasVazia.append("Carne")
listaDeComprasVazia += ["Yogurte", "Leite", "Requeijão", "Brie"]
listaDeComprasVazia.append("Sorvete")

if listaDeComprasVazia.isEmpty {
    println("lista esta vazia")
}
else {
    println("lista NÃO esta vazia")
}

// MODIFICAR ARRAY
println(listaDeComprasVazia)

listaDeComprasVazia[0] = "Frango"
println(listaDeComprasVazia)

listaDeComprasVazia.insert("Carne", atIndex: 1)

listaDeComprasVazia.removeAtIndex(3)
println(listaDeComprasVazia)

listaDeComprasVazia[1...2] = [
    "x",
    "y",
    "z",
    "c"
]

println(listaDeComprasVazia)

listaDeComprasVazia.removeLast()

println(listaDeComprasVazia)

for (index, item) in enumerate(listaDeComprasVazia) {
    println("O item na posição \(index) é o \(item)")
}

for var i = 0; i < listaDeComprasVazia.count; i++ {
    let item = listaDeComprasVazia[i]
    println("O item na posição \(i) é o \(item)")
}



