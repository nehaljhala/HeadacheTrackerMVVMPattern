//
//  Login:SignupViewModel.swift
//  Headache Tracker
//
//  Created by Nehal Jhala on 3/20/22.
//

import Foundation
import CoreData

class SaveLoggedInUserData{
    var loginSuccessful = Bool()
    func loginCall(_ userName: String, _ password: String) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
        var context:NSManagedObjectContext!
        context = appDelegate.persistentContainer.viewContext
        var _: NSError? = nil
        let predicate = NSPredicate(format: "userName = %@ and password = %@", userName, password)
        let fReq: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fReq.returnsObjectsAsFaults = false
        fReq.predicate = predicate
        do {
            let result : [Any] = try context.fetch(fReq)
            if result.count >= 1{
                loginSuccessful = true
                let object = UIApplication.shared.delegate as! AppDelegate
                object.currentUser = userName
            } else {
                loginSuccessful = false
            }
        } catch _ as NSError {
        }
        return loginSuccessful
    }
    
    func saveUserDetails(_ userName: String, _ password:String, _ age:String, _ height:String, _ weight:Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
        var context:NSManagedObjectContext!
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(userName, forKey: "userName")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(age, forKey: "age")
        newUser.setValue(height, forKey: "height")
        newUser.setValue(weight, forKey: "weight")
        do {
            try context.save()
        } catch {
        }
    }
}
