//
//  ViewController.swift
//  CoordsManager
//
//  Created by Igor-Macbook Pro on 03/01/2019.
//  Copyright © 2019 Igor-Macbook Pro. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate, CAAnimationDelegate {

    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print("Latitude \(String(describing: manager.location?.coordinate.latitude))")
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewOneRec))
        upSwipe.direction = .up
        self.view1.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewOneRec))
        downSwipe.direction = .down
        self.view1.addGestureRecognizer(downSwipe)
        
        view1.layer.cornerRadius = 25
        
    }

    let queue = DispatchQueue.main
    
    @objc func viewOneRec(gesture : UISwipeGestureRecognizer) {
        if let swipeGest = gesture as? UISwipeGestureRecognizer {
            
            if swipeGest.direction == UISwipeGestureRecognizer.Direction.down {
                queue.asyncAfter(deadline: .now() + 0.1) {
                    UIView.animate(withDuration: 0.5) {
                        self.view1.frame.origin.y = 500
                    }
                }
                longtitudeLabel.text = "Longitude \(manager.location!.coordinate.longitude)"
                latitudeLabel.text = "Latitude \(manager.location!.coordinate.latitude)"
            }
            else if swipeGest.direction == UISwipeGestureRecognizer.Direction.up {
                
                longtitudeLabel.text = "Longtitude"
                latitudeLabel.text = "Latitude"
                
                queue.asyncAfter(deadline: .now() + 0.1) {
                    UIView.animate(withDuration: 0.5) {
                        self.view1.frame.origin.y = 200
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        var attendance : Bool = false
        
        if location.horizontalAccuracy > 0 {
            manager.stopUpdatingLocation()
            
            if location.coordinate.latitude == manager.location!.coordinate.latitude && location.coordinate.longitude == manager.location!.coordinate.longitude {
                attendance = true
            }
            
            saveAttendance(date: Date.init(), name: "Igor Naumenko", attend: attendance)
            
            print("LATITUDE \(locations[locations.count - 1].coordinate.latitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Problems with gps")
    }
    
    
    private func saveAttendance(date : Date, name : String, attend : Bool) {
        let note = AttendanceNote(context: context)
        note.name = name
        note.date = date
        note.attendance = attend
        
        do {
            try context.save()
        }
        catch {
            print("Problem with saving occured")
        }
    }

}

