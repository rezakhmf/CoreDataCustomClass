//
//  ViewController.swift
//  CoreDataPlayground
//
//  Created by Qantas Dev on 30/4/19.
//  Copyright © 2019 Qantas Airways Flight Technical. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createData(_ sender: Any) {
        createData()
    }
    
    @IBAction func retrieve(_ sender: Any) {
        retrieveData()
    }
    
    @IBAction func update(_ sender: Any) {
        updateData()
    }
    
    @IBAction func deleteData(_ sender: Any) {
        deleteData()
    }
    
    
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "CrewMessage", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        var rangeArrays: [Range] = []
        
        for i in 1...5 {
            let mRange = Range(location: i, length: i+1)
            rangeArrays.append(mRange)
        }
        
        let cmsg = NSManagedObject(entity: userEntity, insertInto: managedContext) as! CrewMessage
        let mRanges = Ranges(ranges: rangeArrays)
        cmsg.setValue(mRanges, forKeyPath: "range")
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        cmsg.highlighted = ["one", "two", "three"]
        cmsg.highlightedRanges = [NSRange(location: 0, length: 2), NSRange(location: 6, length: 8)]
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CrewMessage")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)

            var i = 0
            for data in result as! [NSManagedObject] {
                let mranges = data.value(forKey: "range") as! Ranges
                print(" range batch : \(i)")
                for element in mranges.ranges {
                    print("location:\(element.location), length:\(element.length)")
                }
                i = i + 1
            }
            
            
            let cmsg = result.first as! CrewMessage
            print("highlighted text: \(String(describing: cmsg.highlighted))")
            print("highlighted ranges: \(String(describing: cmsg.highlightedRanges))")
            
        } catch {
            
            print("Failed")
        }
    }
    
    func updateData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CrewMessage")
        fetchRequest.predicate = NSPredicate(format: "range = %@", "Mark:1")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue("newName", forKey: "username")
            objectUpdate.setValue("newmail", forKey: "email")
            objectUpdate.setValue("newpassword", forKey: "password")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CrewMessage")
        fetchRequest.predicate = NSPredicate(format: "range = %@", "Mark:3")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    


}

