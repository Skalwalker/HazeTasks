//
//  Boards.swift
//  HazeTasks
//
//  Created by Renato Nobre on 18/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import UIKit
import CoreData

class Boards: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Create the Object Array
    var tasks = [NSManagedObject]()
    var tasksWindowsPhone = [NSManagedObject]()
    var tasksArtists = [NSManagedObject]()
    var passedRole: String = ""
    var indexPath = 0
    var passedUser: String = ""
    
    //View objects
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    //Set the view state when it loads
    override func viewDidLoad() {
        super.viewDidLoad()
         segment.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self 
    }
    
    //Set the view when it appears
    //This big function fetches the database of the tasks for each role and each board
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if ((self.passedRole == "Chefe de Artes") || (self.passedRole == "Artista")){
            let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TasksArtist")
            
            do {
                let results = try managedContext.fetch(request)
                self.tasksArtists = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            
        } else if ((self.passedRole == "Chefe Desenvolvimento iOS") || (self.passedRole == "Desenvolvedor iOS")){
            if self.passedRole == "Desenvolvedor iOS"{
                self.segment.isHidden = false
                
                let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TasksArtist")
                
                do {
                    let results = try managedContext.fetch(request)
                    self.tasksArtists = results as! [NSManagedObject]
                } catch let error as NSError {
                    print("Could not fetch \(error), \(error.userInfo)")
                }
            }
            
            let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tasks")
            
            do {
                let results = try managedContext.fetch(request)
                self.tasks = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        } else if((self.passedRole == "Chefe Desenvolvimento WP") || (self.passedRole == "Desenvolvedor WP")){
            
            if self.passedRole == "Desenvolvedor WP"{
                 self.segment.isHidden = false
                
                let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TasksArtist")
                
                do {
                    let results = try managedContext.fetch(request)
                    self.tasksArtists = results as! [NSManagedObject]
                } catch let error as NSError {
                    print("Could not fetch \(error), \(error.userInfo)")
                }
            }
            
            let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TasksWP")
            
            do {
                let results = try managedContext.fetch(request)
                self.tasksWindowsPhone = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        
        self.tableView.reloadData()
    }
    
    //Basic view function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    //Number of sections in the table view, just using 1
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //Number of cells in the table view, this depends on the board and the role, that explains the large amuot of if - elses
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count = 0;
        
        if passedRole == "Chefe de Artes" || passedRole == "Artista"{
            count = self.tasksArtists.count
        } else if passedRole == "Desenvolvedor WP"{
            if segment.selectedSegmentIndex == 0{
                count = self.tasksWindowsPhone.count
            } else{
               count = self.tasksArtists.count
            }
        } else if passedRole == "Chefe Desenvolvimento WP"{
            count = self.tasksWindowsPhone.count
        } else if passedRole == "Chefe Desenvolvimento iOS"{
            count = self.tasks.count
        } else if passedRole == "Desenvolvedor iOS"{
            if segment.selectedSegmentIndex == 0{
                count = self.tasks.count
            } else{
                count = self.tasksArtists.count
            }
        }
        
        return count
        
    }
    
    //Carrega as tarefas de artistas
    func loadArtistCell(cell: Cell, indexPath: IndexPath) -> Cell{
        if self.tasksArtists.count != 0 {
            //Atribui valores para as seções das celulas
            let task = self.tasksArtists[indexPath.row]
            
            cell.name.text = task.value(forKey: "nome") as? String
            
            let date = task.value(forKey: "date") as? Date
            print(date!)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            if task.value(forKey: "status") as? Bool == true{
                cell.backgroundColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 0.4)
            } else {
                cell.backgroundColor = UIColor.clear
            }
            print(dateFormater.string(from: date!))
            
            cell.data.text = dateFormater.string(from: date!)
            
        }
        
         //Retorna as celula carregada
        return cell
    }
    
    //Carrega as tarefas de windows phone
    func loadWPCell(cell: Cell, indexPath: IndexPath) -> Cell{
        if self.tasksWindowsPhone.count != 0 {
            //Atribui valores para as seções das celulas
            let task = self.tasksWindowsPhone[indexPath.row]
            
            cell.name.text = task.value(forKey: "nome") as? String
            
            let date = task.value(forKey: "date") as? Date
            print(date!)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            if task.value(forKey: "status") as? Bool == true{
                 cell.backgroundColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 0.4)
            } else {
                cell.backgroundColor = UIColor.clear
            }
            print(dateFormater.string(from: date!))
            
            cell.data.text = dateFormater.string(from: date!)
        }
        
         //Retorna as celula carregada
        return cell;
    }
    
    //Carrega as tarefas de ios
    func loadiOSCell(cell: Cell, indexPath: IndexPath) -> Cell{
        if self.tasks.count != 0 {
            //Atribui valores para as seções das celulas
            let task = self.tasks[indexPath.row]
            
            cell.name.text = task.value(forKey: "nome") as? String
            
            let date = task.value(forKey: "date") as? Date
            print(date!)
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            if task.value(forKey: "status") as? Bool == true{
                cell.backgroundColor = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 0.0/255.0, alpha: 0.4)
            } else {
                cell.backgroundColor = UIColor.clear
            }
            print(dateFormater.string(from: date!))
            
            cell.data.text = dateFormater.string(from: date!)
            
        }
        
        
        //Retorna a celula carregada
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! Cell
        
        if passedRole == "Chefe de Artes" || passedRole == "Artista"{
            cell = self.loadArtistCell(cell: cell, indexPath: indexPath)
        } else if passedRole == "Desenvolvedor WP" || passedRole == "Chefe Desenvolvimento WP"{
            if(passedRole == "Desenvolvedor WP"){
                if segment.selectedSegmentIndex == 0{
                   cell = self.loadWPCell(cell: cell, indexPath: indexPath)
                } else {
                    cell = self.loadArtistCell(cell: cell, indexPath: indexPath)
                }
            } else {
               cell = self.loadWPCell(cell: cell, indexPath: indexPath)
            }
        } else if passedRole == "Desenvolvedor iOS" || passedRole == "Chefe Desenvolvimento iOS"{
            if(passedRole == "Desenvolvedor iOS"){
                if segment.selectedSegmentIndex == 0{
                    cell = self.loadiOSCell(cell: cell, indexPath: indexPath)
                } else {
                   cell = self.loadArtistCell(cell: cell, indexPath: indexPath)
                }
            } else {
               cell = self.loadiOSCell(cell: cell, indexPath: indexPath)
            }
        }
        
        return cell
     }
    
    
     //Permite editar a celula
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
        return true
     }
    
     // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //Exclui a celula do array e do banco de dados de acordo com o cargo e quadro passados
         if editingStyle == .delete {
             // Delete the row from the data source
            if passedRole == "Chefe de Artes" || passedRole == "Artista"{
                removeArtistTask(indexPath: indexPath)
            } else if passedRole == "Desenvolvedor WP" || passedRole == "Chefe Desenvolvimento WP"{
                if passedRole == "Desenvolvedor WP"{
                    if segment.selectedSegmentIndex == 0{
                        removeWPTask(indexPath: indexPath)
                    } else {
                         removeArtistTask(indexPath: indexPath)
                    }
                } else {
                    removeWPTask(indexPath: indexPath)
                }
            } else if passedRole == "Desenvolvedor iOS" || passedRole == "Chefe Desenvolvimento iOS"{
                if passedRole == "Desenvolvedor iOS"{
                    if segment.selectedSegmentIndex == 0{
                       removeiOSTask(indexPath: indexPath)
                    } else {
                        removeArtistTask(indexPath: indexPath)
                    }
                } else {
                    removeiOSTask(indexPath: indexPath)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
         }
     }
    
    
    //Atualiza a table view
    @IBAction func updateTable(_ sender: AnyObject){
        self.tableView.reloadData()
    }
    
    
    //Realiza as acoes quando uma celula e selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath.row
        performSegue(withIdentifier: "EditTask", sender: indexPath)
    }
    
    
    //Envia informacoes para celulas secundarias
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewTask"{
            let vc = segue.destination as! NewTask
            vc.passedRole = self.passedRole
            vc.passedBoard = segment.selectedSegmentIndex
            vc.passedUser = self.passedUser
        } else if segue.identifier == "EditTask"{
            let vc = segue.destination as! EditTask
            vc.passedRole = self.passedRole
            vc.passedBoard = segment.selectedSegmentIndex
            vc.passedTasks = self.tasks
            vc.passedTasksWindowsPhone = self.tasksWindowsPhone
            vc.passedTasksArtists = self.tasksArtists
            vc.passedIndexPath = self.indexPath
            vc.passedUser = self.passedUser
        } else if segue.identifier == "ToReports"{
            let vc = segue.destination as! Reports
            vc.passedRole = self.passedRole
            vc.passedBoard = segment.selectedSegmentIndex
            vc.passedTasks = self.tasks
            vc.passedTasksWindowsPhone = self.tasksWindowsPhone
            vc.passedTasksArtists = self.tasksArtists
            vc.passedUser = self.passedUser
        }
    }
    
    //Remove uma entidade de tarefa de artista
    func removeArtistTask(indexPath: IndexPath){
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        context.delete(tasksArtists[indexPath.row] as NSManagedObject)
        tasksArtists.remove(at: indexPath.row)
    }
    
    //Remove uma entidade de tarefa de iOS
    func removeiOSTask(indexPath: IndexPath){
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        context.delete(tasks[indexPath.row] as NSManagedObject)
        tasks.remove(at: indexPath.row)
    }
    
    //Remove uma entidade de tarefa de WP
    func removeWPTask(indexPath: IndexPath){
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        context.delete(tasksWindowsPhone[indexPath.row] as NSManagedObject)
        tasksWindowsPhone.remove(at: indexPath.row)
        
    }
}
