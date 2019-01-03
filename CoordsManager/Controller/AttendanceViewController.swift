//
//  AttendanceViewController.swift
//  CoordsManager
//
//  Created by Igor-Macbook Pro on 03/01/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import CoreData

class AttendanceViewController : UIViewController {
    
    @IBOutlet weak var datePicker: UIView!
    @IBOutlet weak var pickedDate: UIDatePicker!
    
    var note : AttendanceNote = AttendanceNote()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func findButtonPressed(_ sender: UIButton) {
        let date = pickedDate.date
        
        findDay(date: date)
    }
    
    
    private func findDay(date : Date) {
        let request : NSFetchRequest<AttendanceNote> = AttendanceNote.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", "\(date)")
        
        do {
            note = try context.fetch(request)[0]
        }
        catch {
            print("Error with retrieving occured \(error)")
        }
    }
    
}
