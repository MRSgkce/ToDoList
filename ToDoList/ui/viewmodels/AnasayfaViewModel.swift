//
//  AnasayfaViewModel.swift
//  ToDoList
//
//  Created by Mürşide Gökçe on 13.10.2024.
//
import Foundation
import RxSwift

class AnasayfaViewModel {
    var grepo = GorevlerdaoRepository()

    var gorevlerListesi = BehaviorSubject<[Gorevler]>(value: [Gorevler]())
    init() {
        veritabanikopyala()
        gorevlerListesi=grepo.gorevlerListesi
        gorevleriyukle()
        
    }
    
    func sil(id:Int){
        grepo.sil(id: id)
    }
    func ara (ara_kriter:String){
        grepo.ara(aramakelimesi: ara_kriter)
    }
    
    func gorevleriyukle(){
        grepo.gorevleriyukle()
    }
    
    func veritabanikopyala(){//ezbere bişi kopyalama için veri tabanından
        let bundleyolu = Bundle.main.path(forResource: "todolist", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakyer = URL(fileURLWithPath:hedefYol).appendingPathComponent("todolist.sqlite")
        let fileManager=FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakyer.path)
        {
            print("zaten veritabanı var")
        }else{
                do{
                    try fileManager.copyItem(atPath: bundleyolu!, toPath: kopyalanacakyer.path)
                }catch{
                    
                }
            }
        
    }
}
    

