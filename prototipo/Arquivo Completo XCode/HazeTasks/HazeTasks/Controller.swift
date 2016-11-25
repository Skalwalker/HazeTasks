//
//  Controller.swift
//  HazeTasks
//
//  Created by Renato Nobre on 20/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Controller{
    
    //Add a task to the iOSTasks database
    func addiOSTasks(name: String, desc: String, user: String){
        
        //Link to database
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Tasks",
                                                 in:managedContext)
        
        let task = NSManagedObject(entity: entity!,
                                   insertInto: managedContext)
        
        
        //Set the proprieties
        task.setValue(name, forKey: "nome")
        task.setValue(desc, forKey: "desc")
        task.setValue(false, forKey: "status")
        task.setValue(NSDate(), forKey: "date")
        task.setValue(user, forKey: "user")
        
        do {
            try managedContext.save()
            print(task)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
     //Add a task to the ArtistTasks database
    func addArtistTasks(name: String, desc: String, user: String){
        
        //Link to database
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "TasksArtist",
                                                 in:managedContext)
        
        let task = NSManagedObject(entity: entity!,
                                   insertInto: managedContext)
        
        
        //Set the proprieties
        task.setValue(name, forKey: "nome")
        task.setValue(desc, forKey: "desc")
        task.setValue(false, forKey: "status")
        task.setValue(NSDate(), forKey: "date")
        task.setValue(user, forKey: "user")
        
        do {
            try managedContext.save()
            print(task)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    //Add a task to the WPTasks database
    func addWPTasks(name: String, desc: String, user: String){
       
        //Link to database
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let entity =  NSEntityDescription.entity(forEntityName: "TasksWP",
                                                 in:managedContext)
        
        let task = NSManagedObject(entity: entity!,
                                   insertInto: managedContext)
        
        
        //Set the proprieties
        task.setValue(name, forKey: "nome")
        task.setValue(desc, forKey: "desc")
        task.setValue(false, forKey: "status")
        task.setValue(NSDate(), forKey: "date")
        task.setValue(user, forKey: "user")
        
        do {
            try managedContext.save()
            print(task)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    //Add a task to the Usertasks database
    func addUser(name: String, password: String, role: String){
        
        //Link to database
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "User",
                                                 in:managedContext)
        
        let user = NSManagedObject(entity: entity!,
                                   insertInto: managedContext)
        
        //Set the proprieties
        user.setValue(name, forKey: "nome")
        user.setValue(password, forKey: "senha")
        user.setValue(role, forKey: "cargo")
        
        do {
            try managedContext.save()
            print(user)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
}
