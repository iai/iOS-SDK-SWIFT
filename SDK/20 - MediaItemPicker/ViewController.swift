//
//  ControlesViewController.swift
//  MediaItemPicker
//
//  Created by Eduardo Lima on 11/16/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var items = [MPMediaItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MPMusicPlayerController.applicationMusicPlayer().beginGeneratingPlaybackNotifications()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "atualizarSelecao", name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.buscarTodasMusicas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func anteriorPressionado(sender: AnyObject) {
        MPMusicPlayerController.applicationMusicPlayer().skipToPreviousItem()
    }
    
    @IBAction func stopPressionado(sender: AnyObject) {
        MPMusicPlayerController.applicationMusicPlayer().stop()
    }
    
    @IBAction func playPressionado(sender: AnyObject) {
        MPMusicPlayerController.applicationMusicPlayer().play()
    }
    
    @IBAction func pausePressionado(sender: AnyObject) {
        MPMusicPlayerController.applicationMusicPlayer().pause()
    }
    
    @IBAction func proximaPressionado(sender: AnyObject) {
        MPMusicPlayerController.applicationMusicPlayer().skipToNextItem()
    }

    @IBAction func criarNovaPlaylist(sender: AnyObject) {
        let selecaoMusicas = MPMediaPickerController()
        selecaoMusicas.delegate = self
        selecaoMusicas.allowsPickingMultipleItems = true
        self.presentViewController(selecaoMusicas, animated: true, completion: nil)
    }
    
    func atualizarSelecao(){
        
        if MPMusicPlayerController.applicationMusicPlayer().nowPlayingItem == nil{
            return
        }
        
        if let posicao = find(self.items, MPMusicPlayerController.applicationMusicPlayer().nowPlayingItem){
            let novoIndex = NSIndexPath(forRow: posicao, inSection: 0)
            self.tableView.selectRowAtIndexPath(novoIndex, animated: true, scrollPosition: UITableViewScrollPosition.Top)
        }
    }
    
    func buscarTodasMusicas(){
        
        let busca = MPMediaQuery.songsQuery()
        let filtro = MPMediaPropertyPredicate(value: "Rock", forProperty: MPMediaItemPropertyGenre)
        busca.filterPredicates = NSSet(object: filtro)
        
        let colecao = MPMediaItemCollection(items: busca.items)
        self.items = colecao.items as [MPMediaItem]
        
        MPMusicPlayerController.applicationMusicPlayer().setQueueWithItemCollection(colecao)
        
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MPMusicPlayerController.applicationMusicPlayer().nowPlayingItem = self.items[indexPath.row]
        MPMusicPlayerController.applicationMusicPlayer().play()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        let mediaItem = self.items[indexPath.row]
        cell.textLabel.text = mediaItem.valueForProperty(MPMediaItemPropertyTitle) as? String
        cell.detailTextLabel?.text = mediaItem.valueForProperty(MPMediaItemPropertyArtist) as? String
        
        let capa = mediaItem.valueForProperty(MPMediaItemPropertyArtwork) as? MPMediaItemArtwork
        cell.imageView.image = capa?.imageWithSize(CGSize(width: 20, height: 20))
        
        return cell
    }
}

extension ViewController: MPMediaPickerControllerDelegate{
    func mediaPicker(mediaPicker: MPMediaPickerController!, didPickMediaItems mediaItemCollection: MPMediaItemCollection!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        MPMusicPlayerController.applicationMusicPlayer().setQueueWithItemCollection(mediaItemCollection)
        self.items = mediaItemCollection.items as [MPMediaItem]
        self.tableView.reloadData()
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}















