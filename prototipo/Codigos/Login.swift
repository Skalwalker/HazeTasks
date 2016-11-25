//
//  Login.swift
//  HazeTasks
//
//  Created by Renato Nobre on 18/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import UIKit
import CoreData

class Login: UIViewController {

    //Define o array de usuarios
    var users = [NSManagedObject]()
    //Define elementos na tela
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    //Define o cargo do usuario logado
    var role:String = ""
    
    //Funcao basica da tela
    override func viewDidLoad() {
        super.viewDidLoad()
        //Remove o teclado ao clicar fora da tela
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    //Funcao basica da tela
    override func viewWillAppear(_ animated: Bool) {
        
        //Inicializa na memoria os usuários do banco de dados
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        //Requere as informacoes do atributo User
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        
        do {
            //Tenta incorporar na array, caso falhe mostra mensagem de erro
            let results = try managedContext.fetch(request)
            self.users = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    //Funcao basica da tela
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Verifica se o usuario realmente existe
    @IBAction func loginAuth(_ sender: AnyObject) {
        var found = false
        
        //Procura nos usuarios o usuario requerido
        for user in users{
            if user.value(forKey: "nome") as? String == self.user.text{
                if user.value(forKey: "senha") as? String == self.password.text{
                    found = true
                    self.role = (user.value(forKey: "cargo") as? String)!
                    performSegue(withIdentifier: "Login", sender: sender)
                    break
                }
            }
        }
        
        //Se nao achar mostra uma mensagem de erro
        if found == false{
            let alert = UIAlertController(title: "Login Inválido", message: "Usuário ou senha incorretos", preferredStyle: .alert)
            
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    //Prepara para passar a informacao do cargo do usuario para a tela principal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Login"{
            let vc = segue.destination as! Boards
            vc.passedRole = self.role
            vc.passedUser = self.user.text!
        }
    }
}


//Extensao que faz a funcao de esconder o teclado funcionar
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
