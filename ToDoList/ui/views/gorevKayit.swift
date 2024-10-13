//
//  gorevKayit.swift
//  ToDoList
//
//  Created by Mürşide Gökçe on 13.10.2024.
//

import UIKit

class gorevKayit: UIViewController {

    @IBOutlet weak var gorev: UITextField!
    var viewModel = GorevKayitViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func kaydetButonu(_ sender: Any) {
        if let g = gorev.text {
            viewModel.kaydet(name: g)
        }
    }
    
}
