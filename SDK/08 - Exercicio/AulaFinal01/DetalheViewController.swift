import UIKit

class DetalheViewController: UIViewController {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var sobrenome: UILabel!
    @IBOutlet weak var telefone: UILabel!
    @IBOutlet weak var botaoFavorito: UIButton!
    
    var listaContatos: [Contato]!
    var contato: Contato!
    var posicaoSelecionada: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contato = self.listaContatos[self.posicaoSelecionada]
        
        self.nome.text = self.contato.nome
        self.sobrenome.text = self.contato.sobrenome
        self.telefone.text = self.contato.telefone
        
        self.ajustarInterface()
    }

    @IBAction func botaoFavoritoPressionado(sender: AnyObject) {
        self.contato.favorito = !self.contato.favorito
        self.listaContatos[self.posicaoSelecionada] = self.contato
        GerenciadorArquivo.atualizarLista(self.listaContatos)
        self.ajustarInterface()
    }
    
    func ajustarInterface(){
        if self.contato.favorito{
            self.botaoFavorito.setTitle("Remover favorito", forState: .Normal)
        }
        else{
            self.botaoFavorito.setTitle("Adicionar favorito", forState: .Normal)
        }
    }
}
