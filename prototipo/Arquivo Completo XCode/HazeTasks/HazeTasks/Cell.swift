//
//  Cell.swift
//  HazeTasks
//
//  Created by Renato Nobre on 18/11/16.
//  Copyright © 2016 HazeApps. All rights reserved.
//

import Foundation
import UIKit

//Modelo da celula da tabela
class Cell: UITableViewCell{
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var data: UILabel!
    
    override func awakeFromNib() {
        //Coloca as cores dos elementos para branco e o fundo transparente
        self.backgroundColor = UIColor.clear
        name.textColor = UIColor.white
        data.textColor = UIColor.white
    }
    
}
