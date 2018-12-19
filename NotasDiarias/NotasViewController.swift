//
//  NotasViewController.swift
//  NotasDiarias
//
//  Created by Victor on 12/12/2018.
//  Copyright © 2018 Rinver. All rights reserved.
//

import UIKit
import CoreData

class NotasViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    @IBOutlet weak var texto: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //teclado carrega automatiamente
        self.texto.becomeFirstResponder()
       //recebendo dados da tela 1
        if anotacao != nil {
            if let dadoRecuperado = anotacao.value(forKey: "nota"){
                self.texto.text = dadoRecuperado as! String
            }
        }else {
            self.texto.text = ""
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        

    }

    @IBAction func salvar(_ sender: Any) {
        
        //action para editar anotacao
        if anotacao != nil {
           self.editarAnotacao()
        }else {
            self.salvarAnotacao()
        }
        self.navigationController?.popToRootViewController(animated: true)//retorna home
    }


    func salvarAnotacao (){
        
        //Cria Objeto Para Anotacao
        let novaNota = NSEntityDescription.insertNewObject(forEntityName: "Notas", into: context)
        
        //Configura Anotacao
        novaNota.setValue(self.texto.text, forKey: "nota")
        novaNota.setValue( Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar")

        } catch  {
            print("Erro ao salvar anotacao")
        }
    }
    
    func editarAnotacao(){
        
        anotacao.setValue(self.texto.text, forKey: "nota")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar")
            
        } catch  {
            print("Erro ao salvar anotacao")
        }
    }
       
    
}
