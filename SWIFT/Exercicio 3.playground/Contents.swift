//: Playground - noun: a place where people can play

import UIKit

let notas = [1.2,10.0,7.5,3.3]
let faltas = 30
var totalNotas = 0.0

for nota in notas {
    totalNotas += nota
}

let media = totalNotas/Double(notas.count)

if media >= 6.0 && faltas <= 25 {
    println("Aluno passou!")
}
else {
    if media < 6.0 {
        println("Aluno reprovado por media baixa: \(media)")
    }
    if faltas > 25 {
        println("Aluno reprovado por faltas: \(faltas)")
    }
}
