//
//  GerenciadorArquivo.swift
//  AulaFinal01
//
//  Created by Eduardo Lima on 9/30/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import Foundation

class GerenciadorArquivo {
    
    class var path: String {
       return NSHomeDirectory().stringByAppendingString("/Documents/contatos.plist")
    }
    
    class var listaContatos: [Contato]{

        var lista = [Contato]()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            let listaArquivo = NSArray(contentsOfFile:path)
            for dicionario in listaArquivo{
                let contato = Contato(info: dicionario as NSDictionary)
                lista.append(contato)
            }
        }
        
        return lista
    }
    
    class func atualizarLista(lista:[Contato]){
        var listaAtualizada = NSMutableArray()
        for contato in lista{
            listaAtualizada.addObject(contato.dicionario)
        }
        listaAtualizada.writeToFile(path, atomically: true)
    }
    
    class func adicionarNovoContato(contato:Contato){
        var listaArquivo = NSMutableArray(contentsOfFile:path)
        listaArquivo.addObject(contato.dicionario)
        listaArquivo.writeToFile(path, atomically: true)
    }
}