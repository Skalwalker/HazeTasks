//
//  Reports.swift
//  HazeTasks
//
//  Created by Renato Nobre on 20/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import UIKit
import CoreData

class Reports: UIViewController {

    //Define os labels da tela
    @IBOutlet weak var donePercantage: UILabel!
    @IBOutlet weak var toDoPercentage: UILabel!
    
    
    //Define as variaveis que serao passadas por parametro nesta tela
    var passedBoard: Int = 0
    var passedTasks = [NSManagedObject]()
    var passedTasksArtists = [NSManagedObject]()
    var passedTasksWindowsPhone = [NSManagedObject]()
    var passedRole: String = ""
    var passedUser: String = ""
    //Funcao basia de load da tela
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Calcula a porcentagem de tarefas do quadro de windowsphone concluidas / a fazer
    func calcWPCell(){
        var geral = 0.0
        var done = 0.0
        var ondue = 0.0
        
        for wpcell in passedTasksWindowsPhone{
            if wpcell.value(forKey: "status") as! Bool! == false{
                ondue += 1.0
                geral += 1.0
            } else {
                done += 1.0
                geral += 1.0
            }
        }
        
        ondue = (ondue/geral) * 100
        done = (done/geral) * 100
        
        ondue = round(ondue * 1000)/1000
        done = round(done * 1000)/1000
        
        //Coloca o valor na tela
        self.donePercantage.text = String(done).appending("%")
        self.toDoPercentage.text = String(ondue).appending("%")
    }
    
    //Calcula a porcentagem de tarefas do quadro de artistas concluidas / a fazer
    func calcArtistCell(){
        var geral = 0.0
        var done = 0.0
        var ondue = 0.0
        
        for artistCell in passedTasksArtists{
            if artistCell.value(forKey: "status") as! Bool! == false{
                ondue += 1.0
                geral += 1.0
            } else {
                done += 1.0
                geral += 1.0
            }
        }
        
        ondue = (ondue/geral) * 100
        done = (done/geral) * 100
        
        ondue = round(ondue * 1000)/1000
        done = round(done * 1000)/1000
        
        //Coloca o valor na tela
        self.donePercantage.text = String(done).appending("%")
        self.toDoPercentage.text = String(ondue).appending("%")

    }
    
    //Calcula a porcentagem de tarefas do quadro de ios concluidas / a fazer
    func calciOSCell(){
        var geral = 0.0
        var done = 0.0
        var ondue = 0.0
        
        for iosTask in passedTasks{
            if iosTask.value(forKey: "status") as! Bool! == false{
                ondue += 1.0
                geral += 1.0
            } else {
                done += 1.0
                geral += 1.0
            }
        }
        
        ondue = (ondue/geral) * 100
        done = (done/geral) * 100
        
        ondue = round(ondue * 1000)/1000
        done = round(done * 1000)/1000
        
        //Coloca o valor na tela
        self.donePercantage.text = String(done).appending("%")
        self.toDoPercentage.text = String(ondue).appending("%")
    }
    
    
    //Chama a funcao que calcula a porcentagem correta de acordo com o quadro passado pela tela anterior
    override func viewWillAppear(_ animated: Bool) {
        if ((self.passedRole == "Chefe de Artes") || (self.passedRole == "Artista")){
          calcArtistCell()
        } else if ((self.passedRole == "Chefe Desenvolvimento iOS") || (self.passedRole == "Desenvolvedor iOS")){
            if(self.passedRole == "Desenvolvedor iOS"){
                if(passedBoard == 0){
                    calciOSCell()
                } else {
                    calcArtistCell()
                }
            } else {
                calciOSCell()
            }
        } else if((self.passedRole == "Chefe Desenvolvimento WP") || (self.passedRole == "Desenvolvedor WP")){
            if(self.passedRole == "Desenvolvedor WP"){
                if(passedBoard == 0){
                    calcWPCell()
                } else {
                    calcArtistCell()
                }
            } else {
                calcWPCell()
            }
        }

    }
    
    //Funcao basica da tela
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Manda as informacoes de que quadro foi passado de volta para a tela principal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToBoards"{
            let vc = segue.destination as! Boards
            vc.passedRole = self.passedRole
            vc.passedUser = self.passedUser
        }
    }

}
