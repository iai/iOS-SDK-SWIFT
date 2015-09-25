//
//  MeusObjetos.swift
//  BancoDeDados
//
//  Created by Lucas Longo on 8/25/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import UIKit
import SQLite

class Usuario {
    var id : Int64!
    var nome : String!, sobreNome : String!
    var emails : NSMutableArray?, telefones : NSMutableArray?
    
    init(id: Int64, nome: String, sobreNome: String) {
        self.id = id
        self.nome = nome
        self.sobreNome = sobreNome
        self.emails = NSMutableArray()
        self.telefones = NSMutableArray()
        
        for rowEmail in db.prepare("SELECT id, email FROM emails WHERE usuario_id=(?)", id) {
            if let id = rowEmail[0] as? Int64, email = rowEmail[1] as? String {
                let email = Email(id: id, email: email, user: self)
                self.emails?.addObject(email)
            }
        }
        
        for rowTelefone in db.prepare("SELECT id, telefone FROM telefones WHERE usuario_id=(?)", id) {
            if let id = rowTelefone[0] as? Int64, telefone = rowTelefone[1] as? Int64 {
                let telefone = Telefone(id: id, telefone: telefone, user: self)
                self.telefones?.addObject(telefone)
            }
        }
    }
    
    init() {
        self.id = -1
        self.nome = ""
        self.sobreNome = ""
        self.emails = NSMutableArray()
        self.telefones = NSMutableArray()
    }
    
    func reloadUser() {
        
        self.emails = NSMutableArray()
        self.telefones = NSMutableArray()
        
        if id != -1 {
            for rowEmail in db.prepare("SELECT id, email FROM emails WHERE usuario_id=(?)", id) {
                if let id = rowEmail[0] as? Int64, email = rowEmail[1] as? String {
                    let email = Email(id: id, email: email, user: self)
                    self.emails?.addObject(email)
                }
            }
            
            for rowTelefone in db.prepare("SELECT id, telefone FROM telefones WHERE usuario_id=(?)", id) {
                if let id = rowTelefone[0] as? Int64, telefone = rowTelefone[1] as? Int64 {
                    let telefone = Telefone(id: id, telefone: telefone, user: self)
                    self.telefones?.addObject(telefone)
                }
            }
        }
    }
}

class Email {
    var id : Int64!
    var email : String!
    var usuarioId : Int64!
    
    init(id: Int64, email: String, user: Usuario) {
        self.id = id
        self.email = email
        self.usuarioId = user.id
    }
    
    init(email: String, user: Usuario) {
        self.email = email
        self.usuarioId = user.id
        
        db.run("INSERT INTO emails (email, usuario_id)  VALUES((?), (?))", email, user.id)
    }
    
    func update(emailString: String) {
        db.run("UPDATE emails SET email=(?) WHERE id=(?)", emailString, self.id)
    }
}

class Telefone {
    var id : Int64!
    var telefone : Int64!
    var usuarioId : Int64!

    init(id: Int64, telefone: Int64, user: Usuario) {
        self.id = id
        self.telefone = telefone
        self.usuarioId = user.id
    }
    
    init(telefone: Int64, user: Usuario) {
        self.telefone = telefone
        self.usuarioId = user.id
        
        db.run("INSERT INTO telefones (telefone, usuario_id)  VALUES((?), (?))", telefone, user.id)
    }
    
    func update(telefoneString: String) {
        
        db.run("UPDATE telefones SET telefone=(?) WHERE id=(?)", telefoneString, self.id)
    }
}