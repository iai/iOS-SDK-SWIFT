//: Playground - noun: a place where people can play

import UIKit

func incremente(paraIncrementar montante: Int) -> () -> Int {
    
    var totalGeral = 0
    func incrementador() -> Int {
        totalGeral += montante
        return totalGeral
    }
    return incrementador
}

let funcaoResultante = incremente(paraIncrementar: 10)

funcaoResultante()
funcaoResultante()

let outraFuncaoResultante = funcaoResultante
outraFuncaoResultante()
outraFuncaoResultante()

let maisUma = incremente(paraIncrementar: 5)
maisUma()

outraFuncaoResultante()
funcaoResultante()