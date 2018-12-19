//
//  ListarNotasTableViewController.swift
//  NotasDiarias
//
//  Created by Victor on 12/12/2018.
//  Copyright © 2018 Rinver. All rights reserved.
//

import UIKit
import CoreData

class ListarNotasTableViewController: UITableViewController {

    var context: NSManagedObjectContext!
    var anotacoes:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    //chama atualizacao dados da table
    override func viewDidAppear(_ animated: Bool) {
        self.recuperarNotas()
    }
    
    func recuperarNotas (){
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Notas")
        
        do {
           let notasRecuperadas =  try context.fetch(requisicao)
            self.anotacoes = notasRecuperadas as! [NSManagedObject]
            self.tableView.reloadData()
            print("nota recuperada com sucesso")
        } catch  {
            print("Nao pode recuperar as anotacoes")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.anotacoes.count
    }

    //seleciona elemento da celula /get
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let indice = indexPath.row
        let anotacao = self.anotacoes[indice]
        self.performSegue(withIdentifier: "verNota", sender:anotacao )
    }
    
    //acao de proxima tela
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "verNota" {
            let viewDestino = segue.destination as! NotasViewController
            viewDestino.anotacao = sender as? NSManagedObject
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        let anotacao = self.anotacoes[indexPath.row]
        let textoRecuperado = anotacao.value(forKey: "nota")
        let dataRecuperada = anotacao.value(forKey: "data")
        
        //formartar data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        
        let novaData = dateFormatter.string(from: dataRecuperada as! Date)
        
        
        cell.textLabel?.text = textoRecuperado as? String
        cell.detailTextLabel?.text = novaData
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
