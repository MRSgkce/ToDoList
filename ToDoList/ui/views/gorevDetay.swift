//
//  gorevDetay.swift
//  ToDoList
//
//  Created by Mürşide Gökçe on 13.10.2024.
//

import UIKit

class gorevDetay: UIViewController {
    var viewModel = gorevDetayViewModel()

    
    @IBOutlet weak var gorev: UITextField!
    var gorevi:Gorevler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let g = gorevi{
            gorev.text = g.name
        }
        
    }

    @IBAction func guncelleButonu(_ sender: Any) {
        if let g = gorev.text,let k = gorevi{
            viewModel.guncelle(id: k.id!, name: g)
        }
    }
    
}
