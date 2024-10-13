//
//  gorevKayitViewModel.swift
//  ToDoList
//
//  Created by Mürşide Gökçe on 13.10.2024.
//

import Foundation
class GorevKayitViewModel {
    var grepo = GorevlerdaoRepository()
    func kaydet(name:String){
        grepo.kaydet(name: name)
        
    }
}
