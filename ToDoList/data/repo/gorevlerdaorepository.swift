//
//  gorevlerdaorepository.swift
//  ToDoList
//
//  Created by Mürşide Gökçe on 13.10.2024.
//

import Foundation
import RxSwift

class GorevlerdaoRepository {
    
    var gorevlerListesi = BehaviorSubject<[Gorevler]>(value: [Gorevler]())
    
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniurl = URL(fileURLWithPath:hedefYol).appendingPathComponent("todolist.sqlite")
        db = FMDatabase(path: veritabaniurl.path)
    }
    
    func kaydet(name:String){
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO gorevler (name) VALUES (?)", values: [name])

            
            
        }catch {
            print(error.localizedDescription)
            
        }


        db?.close()
    
    }
    
    
    
    
    
    func gorevleriyukle(){
    
        
        //kisileriListesi.onNext(kisilerListesi)
        
        db?.open()
        var liste = [Gorevler]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM gorevler", values: nil)
            
            while rs.next(){
                let gorev = Gorevler(id: Int(rs.string(forColumn: "id"))!
                                   , name: rs.string(forColumn: "name")!)
                
                liste.append(gorev)
            }
            gorevlerListesi.onNext(liste)
        }catch {
            print(error.localizedDescription)
            
        }
        
        
        db?.close()
    }
        
    
    
    
    func ara(aramakelimesi : String){
        
        
        db?.open()
        var liste = [Gorevler]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM gorevler WHERE name LIKE '%\(aramakelimesi)%' ", values: nil)
            
            while rs.next(){
                let gorev = Gorevler(id: Int(rs.string(forColumn: "id"))!
                                   , name: rs.string(forColumn: "name")!)
                
                liste.append(gorev)
            }
            gorevlerListesi.onNext(liste)//tetikleme
        }catch {
            print(error.localizedDescription)
            
        }


        db?.close()
    }
    
    
    func sil(id:Int){
        
       print("kişisil: \(id)")
        
        db?.open()
        
        
        do{
            try db!.executeUpdate("DELETE FROM gorevler WHERE id = ? ", values: [id])
            gorevleriyukle()
            
            
            
        }catch {
            print(error.localizedDescription)
            
        }


        db?.close()
        
    }
        
    func guncelle(id:Int, name:String){
        
        
        
        db?.open()
        
        
        do{
            try db!.executeUpdate("UPDATE gorevler SET name = ? WHERE id = ? ", values: [name,id])
            
            
        }catch {
            print(error.localizedDescription)
            
        }


        db?.close()
        
    }
    
    
    
    
}

