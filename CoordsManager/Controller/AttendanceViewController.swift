//
//  AttendanceViewController.swift
//  CoordsManager
//
//  Created by Igor-Macbook Pro on 03/01/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit

class AttendanceViewController : UIViewController {
    

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = datePicker.calendar.date(byAdding: <#T##DateComponents#>, to: <#T##Date#>)
        
    }
    
    @IBAction func datePicked(_ sender: UIDatePicker) {
        
    }
    
    
}
