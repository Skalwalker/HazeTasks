//
//  NewTask.swift
//  HazeTasks
//
//  Created by Renato Nobre on 18/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import UIKit
import CoreData

class NewTask: UIViewController, UITextViewDelegate {
    
    //Coloca os elementos na tela
    @IBOutlet weak var descr: UITextView!
    @IBOutlet weak var name: UITextField!
    //Inicializa a classe controladora e variaveis de outras instancias de tela
    let control = Controller()
    var passedRole:String = ""
    var passedBoard: Int = 0
    var passedUser: String = ""
    //Funcao basica de tela
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
        descr.delegate = self
        // Do any additional setup after loading the view.
    }

    //Funcao basica de tela
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Limpa o text view ao tentar editar
    func textViewDidBeginEditing(_ textView: UITextView) {
        descr.text = ""
    }
    
    //Salva a tarefa criada
    @IBAction func saveTask(_ sender: AnyObject) {
        //Chama as funcoes do controlador para adicionar a entidade respectiva no banco de dados
        if (passedRole == "Chefe Desenvolvimento iOS") || (passedRole == "Desenvolvedor iOS") {
            if (passedRole == "Desenvolvedor iOS"){
                if(passedBoard == 0){
                    control.addiOSTasks(name: name.text!, desc: descr.text!, user: self.passedUser)
                } else {
                     control.addArtistTasks(name: name.text!, desc: descr.text!, user: self.passedUser)
                }
            } else {
                control.addiOSTasks(name: name.text!, desc: descr.text!, user: self.passedUser)

            }
        } else if (passedRole == "Chefe de Artes") || (passedRole == "Artista"){
            control.addArtistTasks(name: name.text!, desc: descr.text!, user: self.passedUser)
        } else if (passedRole == "Chefe Desenvolvimento WP") || (passedRole == "Desenvolvedor WP"){
            if (passedRole == "Desenvolvedor WP"){
                if(passedBoard == 0){
                    control.addWPTasks(name: name.text!, desc: descr.text!, user: self.passedUser)
                } else {
                    control.addArtistTasks(name: name.text!, desc: descr.text!, user: self.passedUser)
                }
            } else {
                 control.addWPTasks(name: name.text!, desc: descr.text!, user: self.passedUser)
            }
            
        }

        //Volta para a tela principal
        performSegue(withIdentifier: "BackBoard", sender: sender)
     
    }
    
    
    //Manda informacoes da tela de volta para a tela principal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackBoard" || segue.identifier ==  "VoltarBoard"{
            let vc = segue.destination as! Boards
            vc.passedRole = self.passedRole
            vc.passedUser = self.passedUser
        }
    }
    
}
