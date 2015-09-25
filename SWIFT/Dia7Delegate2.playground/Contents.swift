//: Playground - noun: a place where people can play

import UIKit

class Camera {
    
    var delegate : CameraDelegate?
    
    func tirarFoto() {
        println("Estou tirando a foto")
        delegate?.didTakePhoto("ISTO É UMA FOTO")
    }
}

protocol CameraDelegate {
    func didTakePhoto(photo: String)
}

class MeuApp : CameraDelegate {
    
    var minhaCamera : Camera?
    
    func didTakePhoto(photo: String) {
        println(photo)
    }
}

var app = MeuApp()
app.minhaCamera = Camera()
app.minhaCamera!.delegate = app
app.minhaCamera!.tirarFoto()

