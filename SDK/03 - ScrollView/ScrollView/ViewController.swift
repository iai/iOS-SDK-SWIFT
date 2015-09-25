//
//  ViewController.swift
//  ScrollView
//
//  Created by Eduardo Lima on 9/25/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var meuScrollView: UIScrollView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.criarConteudo()
    }
    
    func criarConteudo(){
        let meuScrollView = UIScrollView()
        meuScrollView.frame = CGRect(x: 20, y: 20, width: 300, height: 300)
        meuScrollView.contentSize = CGSize(width: 600, height: 300)
        
        let quantidadeImagens = 4
        let larguraScroll = Double(self.meuScrollView.frame.size.width)
        let alturaScroll = Double(self.meuScrollView.frame.size.height)
        
        let larguraConteudo = larguraScroll * Double(quantidadeImagens)
        let alturaConteudo = alturaScroll
        
        let tamanhoConteudo = CGSize(width: larguraConteudo, height: alturaConteudo)
        
        let foto1 = UIImage(named: "foto1")
        let foto2 = UIImage(named: "foto2")
        let foto3 = UIImage(named: "foto3")
        let foto4 = UIImage(named: "foto4")
        
        let fotoView1 = UIImageView(image: foto1)
        let fotoView2 = UIImageView(image: foto2)
        let fotoView3 = UIImageView(image: foto3)
        let fotoView4 = UIImageView(image: foto4)
        
        fotoView1.frame = CGRect(x: 0.0, y: 0.0, width: larguraScroll, height: alturaScroll)
        
        fotoView2.frame = CGRect(x: larguraScroll, y: 0.0, width: larguraScroll, height: alturaScroll)
        fotoView3.frame = CGRect(x: larguraScroll * 2.0, y: 0.0, width: larguraScroll, height: alturaScroll)
        fotoView4.frame = CGRect(x: larguraScroll * 3.0, y: 0.0, width: larguraScroll, height: alturaScroll)
        
        self.containerView = UIView(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: tamanhoConteudo))
        
        self.containerView.addSubview(fotoView1)
        self.containerView.addSubview(fotoView2)
        self.containerView.addSubview(fotoView3)
        self.containerView.addSubview(fotoView4)
        
        self.meuScrollView.contentSize = tamanhoConteudo
        self.meuScrollView.addSubview(self.containerView)
        
        self.meuScrollView.pagingEnabled = true
        self.meuScrollView.bounces = false
    }
    
    
    @IBAction func ligaDesliga(sender: AnyObject) {
        self.meuScrollView.hidden = !self.meuScrollView.hidden
    }
   
    @IBAction func segmentoMudouValor(sender: UISegmentedControl) {
        let novoPontoOrigem = CGPoint(x:Double(sender.selectedSegmentIndex) * Double(self.meuScrollView.frame.size.width) , y: 0.0)
        
        let novoFrame = CGRect(origin: novoPontoOrigem, size: self.meuScrollView.frame.size)
        
        self.meuScrollView.scrollRectToVisible(novoFrame, animated: true)
    }
}

