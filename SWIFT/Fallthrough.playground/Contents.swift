//: Playground - noun: a place where people can play

import UIKit

let numero = 5
var texto = "O numero \(numero) é "

switch numero {
case 2,3,5,7,11,13,17,19:
    texto += "um número primo, e também "
    fallthrough
case 5:
    texto += "igual a 5 e "
    fallthrough
case 4...5:
    texto += "entre 4 que 5 e "
    fallthrough
default:
    texto += "um inteiro"
}

println(texto)

var x = 0
while x < 100 {
    println(x)
    x++

    if (x * 20 > 200) {
        break
    }
    
}
