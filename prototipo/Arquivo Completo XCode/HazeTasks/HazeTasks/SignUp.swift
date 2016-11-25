//
//  SignUp.swift
//  HazeTasks
//
//  Created by Renato Nobre on 17/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import UIKit
import CoreData

class SignUp: UIViewController, UIPickerViewDataSource,  UIPickerViewDelegate{
    
    // Variaveis da tela
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var roleField: UIPickerView!
    let control = Controller()
    var role: String = ""
    
    var pickerData: [String] = [String]()
    
    // Funcao basica da tela
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //Faz os assigns necessarios para a UIPickerView funcionar
        roleField.dataSource = self
        roleField.delegate = self
        
        // Popula as informacoes da picker view
        pickerData = ["Chefe Desenvolvimento WP", "Chefe Desenvolvimento iOS", "Chefe de Artes", "Artista", "Desenvolvedor WP", "Desenvolvedor iOS"]
    }

    //Funcao Basica da Tela
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    //Salva o usuario na entidade do banco de dados
    @IBAction func saveUser(_ sender: AnyObject) {
        control.addUser(name: nameField.text!, password: passwordField.text!, role: role)
        
        //Fecha a tela
        dismiss(animated: false, completion: nil)

    }
    
    //Funcao chamada ao selecionar um elemento na picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        role = pickerData[row]
    }
    
    // Numero de componentes por coluna na pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Numero de linhas na picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    


}
