//: Playground - noun: a place where people can play

import UIKit

func mediaNotas(notasDoAluno notas: [Double]) -> Double {
    
    var total = 0.0
    for nota in notas {
        total += nota
    }
    return total / Double(notas.count)
}

func alunoAprovado(notasDoAluno notas: [Double], numeroDeFaltas faltas: Int) -> Bool {
    
    return mediaNotas(notasDoAluno: notas) >= 6.0 && faltas <= 25
}

var notas = [8.6,6.5,9.5,10.0,9.2]
var faltas = 21

if alunoAprovado(notasDoAluno: notas, numeroDeFaltas: faltas) {
    println("⭐️Parabéns!! Aluno passou!⭐️")
}
else {
    println("😩 Aluno reprovado 😩")
}

// OPCIONAL

// Em vez de um IF pode se usa a syntaxe de ternario - MESMO efeito que o IF acima
let resultado = alunoAprovado(notasDoAluno: notas, numeroDeFaltas: faltas) ? "⭐️Parabéns!! Aluno passou!⭐️" : "😩 Aluno reprovado 😩"

println(resultado)

// SINTAXE do ternário
//let resultado2 = teste ? valorSeVerdadeiro : valorSeFalso
