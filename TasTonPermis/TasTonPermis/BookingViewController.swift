//
//  DateViewController.swift
//  TasTonPermis
//
//  Created by tp01 on 18/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import UIKit
import CoreData

class BookingViewController: UIViewController {
    
    var globalData:[NSDictionary]?
    
    
    @IBOutlet weak var departure: UITextField!
    @IBOutlet weak var dateTextField: UITextField!

    //gestionnaire de sauvegarde
    var context: NSManagedObjectContext?
    var bookingObject: NSDictionary?
    
    var dateFormatStr = "DD/MM/YYYY"
    var datePickerView : UIDatePicker?
    var bookingDateInput: Date?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDatePickerView()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //gestion date picker
    
    func addDatePickerView(){
        print("ajout de date Picker")
        datePickerView = UIDatePicker()
        datePickerView?.datePickerMode=UIDatePickerMode.date
        datePickerView?.addTarget(self, action: #selector(BookingViewController.selectionDate(_:)), for: .valueChanged)
        dateTextField.inputView=datePickerView
    }
    func selectionDate(_ sender:UIDatePicker){
        //http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/        
        print("ajout de date")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = dateFormatStr
        dateTextField.text = dateFormatter.string(from: sender.date)
        bookingDateInput = sender.date
    }
    
    @IBAction func a(_ sender: Any) {
        if(bookingDateInput != nil){
            print("date est \(bookingDateInput)")
            addBooking(studentId:1, idMonitor:2, departure: "la Source", arrival: "centre", bookingDate: bookingDateInput!)
        }
    }
    
    @IBAction func validateBooking(_ sender: Any) {
        if(bookingDateInput != nil){
            addBooking(studentId:1, idMonitor:2, departure: "la Source", arrival: "centre", bookingDate: bookingDateInput!)
        }
        
    }
    
    
    //MARK: - Core Data
    func addBooking(studentId: Int,idMonitor: Int, departure: String, arrival: String, bookingDate:Date){
        
        let newBooking = NSEntityDescription.insertNewObject(forEntityName: "Booking", into: context!)
        
        newBooking.setValue(studentId, forKey: "studentId")
        newBooking.setValue(idMonitor, forKey: "monitorId")
        newBooking.setValue(departure, forKey: "departure")
        newBooking.setValue(arrival, forKey: "arrival")
        newBooking.setValue(bookingDate, forKey: "date")

        print("ajout de reservation")
        
        do {
            try context?.save()
            print("sauvegarde aboutie pour \(newBooking)")
        } catch {
            print("erreur sauvegarder au Model")
        }
    }
    
    private func date(year: Int, month: Int, day: Int) -> Date {
        var dc = DateComponents(); dc.year = year; dc.month = month; dc.day = day
        let cal = Calendar.current
        return cal.date(from: dc)! as Date
    }
    
}
