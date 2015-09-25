//
//  MeuSQL.swift
//  BancoDeDados
//
//  Created by Lucas Longo on 8/24/15.
//  Copyright (c) 2015 iai. All rights reserved.
//

import Foundation
import UIKit
import SQLite

var db : Database!

class MeuSQL {
    
    class func initializeDB() {
        
        let path = NSHomeDirectory().stringByAppendingPathComponent("Documents/db.sqlite3")
        
        println(path)
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) == false {
            if let bundlePath = NSBundle.mainBundle().pathForResource("db", ofType: "sqlite3") {
                NSFileManager.defaultManager().copyItemAtPath(bundlePath, toPath: path, error: nil)
            }
        }
        
        db = Database(path)
    }
    
    class func criarTabelas() {
        db.run("CREATE TABLE IF NOT EXISTS usuarios (id INTEGER PRIMARY KEY,nome TEXT,sobrenome TEXT);")
        db.run("CREATE TABLE IF NOT EXISTS emails (id INTEGER PRIMARY KEY,usuario_id INTEGER,email TEXT);")
        db.run("CREATE TABLE IF NOT EXISTS telefones (id INTEGER PRIMARY KEY,usuario_id INTEGER,telefone INTEGER);")
    }

    class func inserirDados() {
        
        let users = [(1, "lucas", "longo"),(2, "elena", "lyra")]
        
        for (id, nome, sobrenome) in users {
            db.run("INSERT INTO usuarios (id, nome, sobrenome) VALUES((?),(?),(?));", id, nome, sobrenome)
        }
        
        let emails = [(1, "lucas@iai.art.br"),(1, "lucas2@iai.art.br"),(2, "elena@iai.art.br"),(2, "elena2@iai.art.br")]

        for (usuario_id, email) in emails {
            db.run("INSERT INTO emails (usuario_id, email) VALUES((?),(?));", usuario_id, email)
        }
        
        let telefones = [(1, "123"),(1, "456"),(2, "444"),(2, "555")]
        
        for (usuario_id, telefone) in telefones {
            db.run("INSERT INTO telefones (usuario_id, telefone) VALUES((?),(?));", usuario_id, telefone)
        }
    }
    
    class func getAllUsers() -> NSMutableArray {
        
        var array = NSMutableArray()
        for row in db.prepare("SELECT id, nome, sobrenome FROM usuarios") {
            if let id = row[0] as? Int64, nome = row[1] as? String, sobrenome = row[2] as? String {
                var usuario = Usuario(id: id, nome: nome, sobreNome: sobrenome)
                array.addObject(usuario)
            }
        }
        return array
    }
    
    class func updateUser(usuario: Usuario) -> Bool {
        
        db.run("UPDATE usuarios SET nome=(?), sobrenome=(?) WHERE id=(?)", usuario.nome, usuario.sobreNome, usuario.id)
        
        if let emails = usuario.emails {
            for e in emails {
                if let email = e as? Email {
                    db.run("UPDATE emails SET email=(?) WHERE id=(?)", email.email, email.id)
                }
            }
        }

        if let telefones = usuario.telefones {
            for t in telefones {
                if let telefone = t as? Telefone {
                    db.run("UPDATE telefones SET telefone=(?) WHERE id=(?)", telefone.telefone, telefone.id)
                }
            }
        }
        
        return (db.totalChanges > 0)
    }
    
    class func createUser(usuario: Usuario) -> Bool {
        db.run("INSERT INTO usuarios (nome, sobrenome) VALUES((?),(?));", usuario.nome, usuario.sobreNome)
        
        for row in db.prepare("SELECT MAX(id) as id FROM usuarios;") {
            if let id = row[0] as? Int64 {
                usuario.id = id
                
                if let emails = usuario.emails {
                    for e in emails {
                        if let email = e as? Email {
                            db.run("INSERT INTO emails (usuario_id, email) VALUES((?),(?));", id, email.email)
                        }
                    }
                }
                
                if let telefones = usuario.telefones {
                    for t in telefones {
                        if let telefone = t as? Telefone {
                            db.run("INSERT INTO telefones (usuario_id, telefone) VALUES((?),(?));", id, telefone.telefone)
                        }
                    }
                }
            }
        }
        
        return (db.totalChanges > 0)
    }
    
    class func deleteUser(usuario: Usuario) -> Bool {
        
        db.run("DELETE FROM usuarios WHERE id=(?);", usuario.id)
        db.run("DELETE FROM emails WHERE usuario_id=(?);", usuario.id)
        db.run("DELETE FROM telefones WHERE usuario_id=(?);", usuario.id)
        
        return (db.totalChanges > 0)
    }
    
    class func deleteEmail(email: Email) -> Bool {
        
        db.run("DELETE FROM emails WHERE id=(?);", email.id)
        
        return (db.totalChanges > 0)
    }
    
    class func deleteTelefone(telefone: Telefone) -> Bool {
        
        db.run("DELETE FROM telefones WHERE id=(?);", telefone.id)
        
        return (db.totalChanges > 0)
    }
}

