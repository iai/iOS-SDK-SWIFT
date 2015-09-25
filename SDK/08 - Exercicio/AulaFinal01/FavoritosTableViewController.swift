//
//  FavoritosTableViewController.swift
//  AulaFinal01
//
//  Created by Eduardo Lima on 9/30/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

import UIKit

class FavoritosTableViewController: UITableViewController {

    var listaContatos: [Contato]!
    var listaFavoritos: [Contato]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listaContatos = GerenciadorArquivo.listaContatos
        self.listaFavoritos = self.listaFiltrada()
        self.tableView.reloadData()
    }
    
    func listaFiltrada() -> [Contato]{
        var lista = [Contato]()
        for contato in self.listaContatos{
            if contato.favorito{
                lista.append(contato)
            }
        }
        return lista
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaFavoritos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoritoCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = self.listaFavoritos[indexPath.row].nome
        cell.detailTextLabel?.text = self.listaFavoritos[indexPath.row].sobrenome
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.destinationViewController.isKindOfClass(DetalheViewController.classForCoder()){
            let detalhe = segue.destinationViewController as DetalheViewController
            detalhe.listaContatos = self.listaFavoritos
            detalhe.posicaoSelecionada = self.tableView.indexPathForSelectedRow()!.row
        }
    }

}
