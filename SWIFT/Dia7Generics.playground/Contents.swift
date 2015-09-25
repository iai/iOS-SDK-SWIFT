//: Playground - noun: a place where people can play

import UIKit

func trocarItens<T>(inout a: T, inout b:T) {
    let tempA = a
    a = b
    b = tempA
}

var umInt = 1
var outroInt = 2

trocarItens(&umInt, &outroInt)
println("\(umInt) \(outroInt)")

var umString = "string 1"
var outroString = "string 2"

trocarItens(&umString, &outroString)
println("\(umString) \(outroString)")

// As duas variaveis passadas, tem que ser do mesmo tipo
//trocarItens(&umInt, &umString)
