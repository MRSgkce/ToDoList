//
//  gorevDetayViewModel.swift
//  ToDoList
//
//  Created by Mürşide Gökçe on 13.10.2024.
//

import Foundation

class gorevDetayViewModel{
    var grepo = GorevlerdaoRepository()
    func guncelle(id:Int, name:String){
        grepo.guncelle(id: id, name: name)
    }
}

