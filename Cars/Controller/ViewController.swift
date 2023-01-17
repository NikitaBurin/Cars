//
//  ViewController.swift
//  Cars
//
//  Created by Никита Бурин on 13.01.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    var mainView = View()
    var car: Cars!
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()
    
    lazy var doubleTapGesture: UITapGestureRecognizer = {
        let dt = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapForPickMyChoice))
        dt.numberOfTapsRequired = 2
        return dt
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        getDataFromFile()
        updateSegmentedControl()
        
        view.addGestureRecognizer(doubleTapGesture)
    }
    
    
    private func getDataFromFile() {
        
        let fetchRequest: NSFetchRequest<Cars> = Cars.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mark != nil")
        
        var records = 0
        
        do {
            records = try context.count(for: fetchRequest)
            print("Is data there already?")
        } catch {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
              let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for dictionary in dataArray {
            guard let entity = NSEntityDescription.entity(forEntityName: "Cars", in: context) else { return }
            let car = NSManagedObject(entity: entity, insertInto: context) as! Cars
            
            let carDictionary = dictionary as! [String: AnyObject]
            car.mark = carDictionary["mark"] as? String
            car.model = carDictionary["model"] as? String
            car.rating = carDictionary["rating"] as! Double
            car.lastStarted = carDictionary["lastStarted"] as? Date
            car.timesDriven = carDictionary["timesDriven"] as! Int16
            car.myChoice = carDictionary["myChoice"] as! Bool
            
            guard let imageName = carDictionary["imageName"] as? String else { return }
            guard let image = UIImage(named: imageName) else { return }
            let imageData = image.pngData()
            car.imageData = imageData
            
            if let colorDictionary = carDictionary["tintColor"] as? [String : Float] {
                car.tintColor = getColor(colorDictionary: colorDictionary)
            }
        }
    }
    
    func getColor(colorDictionary: [String : Float]) -> UIColor {
        guard let red = colorDictionary["red"],
              let green = colorDictionary["green"],
              let blue = colorDictionary["blue"] else { return UIColor() }
        
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1)
    }
    
    func insertDataFrom(selectedCar car: Cars){
        mainView.carImageView.image = UIImage(data: car.imageData!)
        mainView.markLabel.text = car.mark
        mainView.modelLabel.text = car.model
        mainView.myChoiceImageView.isHidden = !(car.myChoice)
        mainView.ratingLabel.text = "Rating: \(car.rating) / 10.0"
        mainView.numberOfTripsLabel.text = "Numbers of trips: \(car.timesDriven)"
        
        mainView.lastTimeStartedLabel.text = "Last time started: \(dateFormatter.string(from: car.lastStarted!))"
        mainView.segmentedControl.backgroundColor = car.tintColor as? UIColor
    }
    
    func update(rating: Double){
        car.rating = rating
        
        do {
            try context.save()
            insertDataFrom(selectedCar: car)
        } catch {
            let alertController = UIAlertController(title: "Wrong value", message: "Wrong input. Must be 0 - 10", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            
            alertController.addAction(alertAction)
            present(alertController, animated: true)
            print(error.localizedDescription)
        }
    }
    
    func updateSegmentedControl() {
        let fetchRequest: NSFetchRequest<Cars> = Cars.fetchRequest()
        guard let mark = mainView.segmentedControl.titleForSegment(at: mainView.segmentedControl.selectedSegmentIndex) else { return }
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark)
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let selectedCar = result.first else { return }
            car = selectedCar
            insertDataFrom(selectedCar: car)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func startEnginePressed() {
        car.timesDriven += 1
        car.lastStarted = Date()
        
        do {
            try context.save()
            insertDataFrom(selectedCar: car)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func rateItPressed() {
        let alertController = UIAlertController(title: "Rate it", message: "Rate this car please", preferredStyle: .alert)
        let rateAction = UIAlertAction(title: "Rate", style: .default) { action in
            if let text = alertController.textFields?.first?.text {
                self.update(rating: (text as NSString).doubleValue)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(rateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc func segmentedPressed() {
        updateSegmentedControl()
    }
    
    @objc func didDoubleTapForPickMyChoice() {
        
        if car.myChoice {
            car.myChoice = false
        } else {
            car.myChoice = true
        }
        
        do {
            try context.save()
            insertDataFrom(selectedCar: car)
        } catch {
            print(error.localizedDescription)
        }
    }
}

