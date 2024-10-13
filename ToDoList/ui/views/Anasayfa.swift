//
//  ViewController.swift
//  ToDoList
//
//  Created by Mürşide Gökçe on 13.10.2024.
//

import UIKit

class Anasayfa: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var gorevlerListesi = [Gorevler]()
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
       _=viewModel.gorevlerListesi.subscribe(onNext:{liste in self.gorevlerListesi=liste
           
        self.tableView.reloadData()
    })
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.gorevleriyukle()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            if let gorev = sender as? Gorevler{
                let gidicek = segue.destination as! gorevDetay
                gidicek.gorevi = gorev
                
            }
            
        }
    }
    


}

extension Anasayfa: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(ara_kriter: searchText)
    }
}

extension Anasayfa: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gorevlerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gorev = gorevlerListesi[indexPath.row]
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "gorevlerHucre", for: indexPath) as! gorevlerHucre
        
        hucre.labelGorev.text = "\(String(describing: gorev.id!))"
        hucre.labelAciklamasi.text = gorev.name
        
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gorev = gorevlerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: gorev)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let sil = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, sourceView, bool) in
            let gorev = self.gorevlerListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Görev Sil", message: "Görev silinsin mi?", preferredStyle: .alert)
            
            let iptal = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptal)
            
            let sil = UIAlertAction(title: "Sil", style: .destructive) { (action) in
                self.viewModel.sil(id: gorev.id!)
                
            }
            alert.addAction(sil)
            self.present(alert, animated: true)
            
   
            
        }
        return UISwipeActionsConfiguration(actions: [sil])
    }
    
}

