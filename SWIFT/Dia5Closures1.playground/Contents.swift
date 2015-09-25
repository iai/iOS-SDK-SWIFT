//: Playground - noun: a place where people can play

import UIKit

let nomes = ["Lucas", "Elena", "eduardo", "Suzana", "Adriana"]

func sortNames(s1: String, s2: String) -> Bool {
    
    var string1 = (s1 as NSString).substringFromIndex(3).uppercaseString
    var string2 = (s2 as NSString).substringFromIndex(3).uppercaseString
    
    return string1 < string2
}

let sortedArray = sorted(nomes, sortNames)

println(sortedArray)

let sortedArray2 = sorted(nomes,{(s1: String, s2: String) -> Bool in
    
    var string1 = (s1 as NSString).substringFromIndex(3).uppercaseString
    var string2 = (s2 as NSString).substringFromIndex(3).uppercaseString
    
    return string1 < string2
    })
println(sortedArray2)
let nomes2 = ["Lucas", "Elena", "eduardo", "Suzana", "Adriana"]
let sortedArray3 = sorted(nomes2, {s1, s2 in
    
    var string1 = (s1 as NSString).substringFromIndex(3).uppercaseString
    var string2 = (s2 as NSString).substringFromIndex(3).uppercaseString
    
    return string1 < string2
})
println(sortedArray3)


let sortedArray4 = sorted(nomes, {s1, s2 in s1 < s2})
println(sortedArray4)

let sortedArray5 = sorted(nomes, {$0 < $1})
println(sortedArray5)

let nomes3 = ["Lucas", "Elena", "eduardo", "Suzana", "Adriana"]
let sortedArray6 = sorted(nomes3) {s1, s2 in
    
    var string1 = (s1 as NSString).substringFromIndex(3).uppercaseString
    var string2 = (s2 as NSString).substringFromIndex(3).uppercaseString
    
    return string1 < string2
}
println(sortedArray6)




