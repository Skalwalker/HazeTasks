//
//  EditTask.swift
//  HazeTasks
//
//  Created by Renato Nobre on 18/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import UIKit
import CoreData


class EditTask: UIViewController {

    //Variaveis de valores da tela
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var creator: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var swi: UISwitch!
    @IBOutlet weak var toDo: UILabel!
    
    //Variaveis logica do sistema
    var passedTasks = [NSManagedObject]()
    var passedTasksWindowsPhone = [NSManagedObject]()
    var passedTasksArtists = [NSManagedObject]()
    var passedIndexPath: Int = 0
    var passedRole: String = ""
    var passedBoard: Int = 0
    var passedUser: String = ""
    
    //Funcao basica da tela
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    //Carrega as celulas dos artistas
    func loadArtistCell(){
        //Carrega os valores an tela
        let task = self.passedTasksArtists[self.passedIndexPath]
            
        self.taskName.text = task.value(forKey: "nome") as? String
        let date = task.value(forKey: "date") as? Date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        self.date.text = dateFormater.string(from: date!)
        self.creator.text = task.value(forKey: "user") as? String
        let isOn: Bool = (task.value(forKey: "status") as? Bool)!
        self.swi.setOn(isOn, animated: false)
        self.textView.text = task.value(forKey: "desc") as? String
        
    }
    
    //Carrega as celulas dos WP
    func loadWPCell(){
        //Carrega os valores an tela
        let task = self.passedTasksWindowsPhone[self.passedIndexPath]
        
        self.taskName.text = task.value(forKey: "nome") as? String
        let date = task.value(forKey: "date") as? Date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        self.date.text = dateFormater.string(from: date!)
        self.creator.text = task.value(forKey: "user") as? String
        let isOn: Bool = (task.value(forKey: "status") as? Bool)!
        self.swi.setOn(isOn, animated: false)
        self.textView.text = task.value(forKey: "desc") as? String
    }
    
    //Carrega as celulas dos iOS
    func loadiOSCell(){
        //Carrega os valores an tela
        let task = self.passedTasks[self.passedIndexPath]
        
        self.taskName.text = task.value(forKey: "nome") as? String
        let date = task.value(forKey: "date") as? Date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        self.date.text = dateFormater.string(from: date!)
        self.creator.text = task.value(forKey: "user") as? String
        let isOn: Bool = (task.value(forKey: "status") as? Bool)!
        self.swi.setOn(isOn, animated: false)
        self.textView.text = task.value(forKey: "desc") as? String
    }
    
    //Essa função cria diversos condicionais para carregar na tela a tarefa correta de acordo com o cargo e o quadro de tarefas
    override func viewWillAppear(_ animated: Bool) {
        if ((self.passedRole == "Chefe de Artes") || (self.passedRole == "Artista")){
            loadArtistCell()
        } else if ((self.passedRole == "Chefe Desenvolvimento iOS") || (self.passedRole == "Desenvolvedor iOS")){
            if(self.passedRole == "Desenvolvedor iOS"){
                if(passedBoard == 0){
                    loadiOSCell()
                } else {
                    loadArtistCell()
                }
            } else {
                loadiOSCell()
            }
        } else if((self.passedRole == "Chefe Desenvolvimento WP") || (self.passedRole == "Desenvolvedor WP")){
            if(self.passedRole == "Desenvolvedor WP"){
                if(passedBoard == 0){
                   loadWPCell()
                } else {
                    loadArtistCell()
                }
            } else {
               loadWPCell()
            }
        }
        
        
        //Muda a mensagem quando concluido
        if(swi.isOn == false){
            toDo.text = "A fazer"
        } else {
            toDo.text = "Concluido"
        }
    }
    
    //Muda a mensagem quando concluido
    @IBAction func complete(_ sender: AnyObject) {
        if(swi.isOn == false){
           toDo.text = "A fazer"
        } else {
           toDo.text = "Concluido"
        }
    }
    
    //Atualiza a tarefa dos artistas
    func updateArtistCell(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
        //Passa os valores
        let task = self.passedTasksArtists[self.passedIndexPath]
        
        task.setValue(self.taskName.text, forKey: "nome")
        let isOn: Bool = swi.isOn
        task.setValue(isOn, forKey: "status")
        task.setValue(self.textView.text, forKey: "desc")
        
       
        appDelegate.saveContext()
        
    }
    
    //Atualiza a tarefa do WindowsPhone
    func updateWPCell(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Passa os valores
        let task = self.passedTasksWindowsPhone[self.passedIndexPath]
        
        task.setValue(self.taskName.text, forKey: "nome")
        let isOn: Bool = swi.isOn
        task.setValue(isOn, forKey: "status")
        task.setValue(self.textView.text, forKey: "desc")
        
        
        appDelegate.saveContext()
    }
    
    //Atualiza a tarefa do iOS
    func updateiOSCell(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Passa os valores
        let task = self.passedTasks[self.passedIndexPath]
        
        task.setValue(self.taskName.text, forKey: "nome")
        let isOn: Bool = swi.isOn
        task.setValue(isOn, forKey: "status")
        task.setValue(self.textView.text, forKey: "desc")
        
        
        appDelegate.saveContext()
    }
    
    
    //Salva as mudancas feitas na tela
    @IBAction func save(_ sender: AnyObject) {
        if ((self.passedRole == "Chefe de Artes") || (self.passedRole == "Artista")){
            updateArtistCell()
        } else if ((self.passedRole == "Chefe Desenvolvimento iOS") || (self.passedRole == "Desenvolvedor iOS")){
            if(self.passedRole == "Desenvolvedor iOS"){
                if(passedBoard == 0){
                    updateiOSCell()
                } else {
                    updateArtistCell()
                }
            } else {
                updateiOSCell()
            }
        } else if((self.passedRole == "Chefe Desenvolvimento WP") || (self.passedRole == "Desenvolvedor WP")){
            if(self.passedRole == "Desenvolvedor WP"){
                if(passedBoard == 0){
                    updateWPCell()
                } else {
                    updateArtistCell()
                }
            } else {
                updateWPCell()
            }
        }
        
        
        performSegue(withIdentifier: "SaveEdit", sender: sender)
    }
    
    
    //Prepara para mandar os valores para a tela principal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveEdit" || segue.identifier == "Back"{
         let vc = segue.destination as! Boards
            vc.passedRole = self.passedRole
            vc.passedUser = self.passedUser
        }
    }
    
    
     //Muda o nome na tela
    @IBAction func editName(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Name", message: "Add the new name", preferredStyle: .alert)
        
        let addNewAction = UIAlertAction(title: "Add", style: .default){(_) in
            let nameTextField = alert.textFields![0]
            self.taskName.text = nameTextField.text
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(addNewAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

     //Funcao basica da tela
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
