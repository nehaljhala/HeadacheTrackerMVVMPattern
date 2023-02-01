//
//  Analysis.swift
//  Headache Tracker
//
//  Created by Nehal Jhala on 3/16/22.
//
import UIKit
import Foundation
import CoreLocation
import CoreData

class Analytics {
    var lat = Double()
    var lon = Double()
    var endTime = Date()
    let dataArray : [NSManagedObject] = []
    var humidityAvg = Float()
    var tempAvg = Float()
    var windSpeedAvg = Float()
    var uviAvg = Float()
    var timeAvg = String()
    var avgDuration = Int()
    var persCont = HTPerCont()
    
    //Analytics:
    func doAnalysis(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
        var context: NSManagedObjectContext!
        context = appDelegate.persistentContainer.viewContext
        var _: NSError? = nil
        let predicate = NSPredicate(format: "userName = %@" , appDelegate.currentUser)
        let fReq: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HeadacheData")
        fReq.returnsObjectsAsFaults = false
        fReq.predicate = predicate
        do {
            let headacheDataTable : [NSManagedObject] = try context.fetch(fReq) as! [NSManagedObject]
            
            var humiVar: Float = 0.0
            var tempVar : Float = 0.0
            var windSpVar : Float = 0.0
            var uviVar : Float = 0.0
            var timeResult = [0,0,0]
            var durationVar = 0
            if headacheDataTable.count == 0 {
                humidityAvg = 0
                tempAvg = 0
                uviAvg = 0
                windSpeedAvg = 0
                timeAvg = "None Yet"
                avgDuration = 0
            }
            else {
                for i in 0..<headacheDataTable.count{
                    //Avg weather condition:
                    let humidityFloat = headacheDataTable[i].value(forKey: "humidity")as! Float
                    humiVar += humidityFloat
                    let tempFloat = headacheDataTable[i].value(forKey: "temp")as! Float
                    let tempFahr = convertKelvinToFarenheit(tempFloat)
                    tempVar += tempFahr
                    let windSpeedFloat = headacheDataTable[i].value(forKey: "windSpeed")as! Float
                    windSpVar += windSpeedFloat
                    let uviFloat = headacheDataTable[i].value(forKey: "uvi")as! Float
                    uviVar += uviFloat
                    
                    //Average time:
                    let startTimeDate = headacheDataTable[i].value(forKey: "startTime")
                    if startTimeDate != nil  {
                        let sdt = startTimeDate as! Date
                        var calendar = Calendar.current
                        calendar.timeZone = TimeZone.current
                        let hour = calendar.component(.hour, from: sdt)
                        _ = calendar.component(.minute, from:sdt)
                        print(hour, "HOur")
                        if hour == 00 {
                            timeResult[0] += 1
                        }
                        if hour <= 11  {
                            timeResult[0] += 1
                        }
                        if hour > 11 && hour < 18{
                            timeResult[1] += 1
                        }
                        if hour >= 18 {
                            timeResult[2] += 1
                        }
                    }
                    //calculate duration of headache:
                    var duration = Int()
                    let headacheEndDate = headacheDataTable[i].value(forKey: "endTime")
                    if (headacheEndDate != nil ) {
                        let df = DateFormatter()
                        df.dateFormat = "MM/dd/YY  HH:MM"
                        let newDateMinutes = (headacheEndDate! as AnyObject).timeIntervalSinceReferenceDate/60
                        let oldDateMinutes = (startTimeDate! as AnyObject).timeIntervalSinceReferenceDate/60
                        let timeDifference = ( Double(newDateMinutes - oldDateMinutes)) //in minutes
                        print(timeDifference, "td")
                        duration = Int(timeDifference.rounded())
                        durationVar += duration
                        print(duration)
                    }
                }
                //Weather avg:
                humidityAvg = humiVar / Float(headacheDataTable.count)
                humidityAvg = humidityAvg.rounded()
                tempAvg = tempVar / Float(headacheDataTable.count)
                tempAvg = tempAvg.rounded()
                windSpeedAvg = windSpVar / Float(headacheDataTable.count)
                windSpeedAvg = windSpeedAvg.rounded()
                uviAvg = uviVar / Float(headacheDataTable.count)
                uviAvg = uviAvg.rounded()
                
                //Time avg:
                let maxTime = timeResult.max()
                if timeResult[0] == maxTime{
                    timeAvg = "Morning"
                }
                if timeResult[1] == maxTime{
                    timeAvg = "Afternoon"
                }
                if timeResult[2] == maxTime{
                    timeAvg = "Evening"
                }
                
                avgDuration = (durationVar / headacheDataTable.count)
                print(avgDuration)
                //updateDashboard()
            }
        } catch {
        }
    }
    
    func calculateAvgOfData(_ weatherData: [Float]) -> Float{
        var average: Float {
               if weatherData.isEmpty {
                   return 0.0
               } else {
                   let sum = weatherData.reduce(0, +)
                   return Float(sum) / Float(weatherData.count)
               }
        }
        return 0.0
    }
    
        func calculateTimeAvg(_ startTimeDate: Date, _ endTimeDate: Date){
            guard startTimeDate != nil else {return}
                var calendar = Calendar.current
                calendar.timeZone = TimeZone.current
            _ = calendar.component(.hour, from: startTimeDate)
            _ = calendar.component(.minute, from:startTimeDate)
                //get the timeofday here:
          //  TimeOfDay.init(with: (startTimeDate))
            
            //calculate duration of headache:
            var durationVar = 0
            var duration = Int()
            let headacheEndDate = [Date]()
            if (headacheEndDate != nil ) {
                let df = DateFormatter()
                df.dateFormat = "MM/dd/YY  HH:MM"
                let timeStamp = UInt64(Date().timeIntervalSince1970)


                let newDateMinutes = (headacheEndDate as AnyObject).timeIntervalSinceReferenceDate/60
                let oldDateMinutes = (startTimeDate as AnyObject).timeIntervalSinceReferenceDate/60
                let timeDifference = ( Double(newDateMinutes - oldDateMinutes)) //in minutes
                duration = Int(timeDifference.rounded())
                durationVar += duration
            }
            //(durationVar / weatherData.count)
            let timeResult = [0,0,0]
            var timeAvg = String()
            let maxTime = timeResult.max()
            if timeResult[0] == maxTime{
                timeAvg = "Morning"
            }
            if timeResult[1] == maxTime{
                timeAvg = "Afternoon"
            }
            if timeResult[2] == maxTime{
                timeAvg = "Evening"
            }
   
        }
    }
 



           





    
//    var locationManager = CLLocationManager()
//    var lat = Double()
//    var lon = Double()
//    var endTime = Date()
//    let headAcheDataArray = [Float]()    //[NSManagedObject] = []
//    var humidityAvg = Float()
//    var tempAvg = Float()
//    var windSpeedAvg = Float()
//    var uviAvg = Float()
//    var timeAvg = String()
//    var avgDuration = Int()
//    var appPC = HeadacheTrackerPersistentContaniner()
//
//    //Analytics:
//    func doAnalysis(){
//      //  let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
//      //  var context: appDelegate.NSManagedObjectContext!
//      //  var context = appDelegate.persistentContainer.viewContext
//      //  var _: NSError? = nil
//      //  let predicate = NSPredicate(format: "userName = %@" , appDelegate.currentUser)
//      //  let fReq: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HeadacheData")
//      //  fReq.returnsObjectsAsFaults = false
//       // fReq.predicate = predicate
//       // do {
//       //     let headacheDataTable : [NSManagedObject] = try context.fetch(fReq) as! [NSManagedObject]
//            var humiVar : Float = 0.0
//            var tempVar : Float = 0.0
//            var windSpVar : Float = 0.0
//            var uviVar : Float = 0.0
//            var timeResult = [0,0,0]
//            var durationVar = 0
//            if headAcheDataArray.count == 0 {
//                humidityAvg = 0
//                tempAvg = 0
//                uviAvg = 0
//                windSpeedAvg = 0
//                timeAvg = "None Yet"
//                avgDuration = 0
//            }
//            else {
//                for i in 0..<headAcheDataArray.count{
//                    //Avg weather condition:
//                    let humidityFloat = headAcheDataArray.humidity
//                    humiVar += humidityFloat
//                    let tempFloat = headAcheDataArray[i].value(forKey: "temp")as! Float
//                    let tempFahr = convertKelvinToFarenheit(tempFloat)
//                    tempVar += tempFahr
//                    let windSpeedFloat = headAcheDataArray[i].value(forKey: "windSpeed")as! Float
//                    windSpVar += windSpeedFloat
//                    let uviFloat = headAcheDataArray[i].value(forKey: "uvi")as! Float
//                    uviVar += uviFloat
//
//                    //Average time:
//                    let startTimeDate = headAcheDataArray[i].value(forKey: "startTime")
//                    if startTimeDate != nil  {
//                        let sdt = startTimeDate as! Date
//                        var calendar = Calendar.current
//                        calendar.timeZone = TimeZone.current
//                        let hour = calendar.component(.hour, from: sdt)
//                        _ = calendar.component(.minute, from:sdt)
//                        if hour == 00 {
//                            timeResult[0] += 1
//                        }
//                        if hour <= 11  {
//                            timeResult[0] += 1
//                        }
//                        if hour > 11 && hour < 18{
//                            timeResult[1] += 1
//                        }
//                        if hour >= 18 {
//                            timeResult[2] += 1
//                        }
//                    }
//                    //calculate duration of headache:
//                    var duration = Int()
//                    let headacheEndDate = headAcheDataArray[i].value(forKey: "endTime")
//                    if (headacheEndDate != nil ) {
//                        let df = DateFormatter()
//                        df.dateFormat = "MM/dd/YY  HH:MM"
//                        let newDateMinutes = (headacheEndDate! as AnyObject).timeIntervalSinceReferenceDate/60
//                        let oldDateMinutes = (startTimeDate! as AnyObject).timeIntervalSinceReferenceDate/60
//                        let timeDifference = ( Double(newDateMinutes - oldDateMinutes)) //in minutes
//                        duration = Int(timeDifference.rounded())
//                        durationVar += duration
//                        print(duration)
//                    }
//                }
//                //Weather avg:
//                humidityAvg = humiVar / Float(headAcheDataArray.count)
//                humidityAvg = humidityAvg.rounded()
//                tempAvg = tempVar / Float(headAcheDataArray.count)
//                tempAvg = tempAvg.rounded()
//                windSpeedAvg = windSpVar / Float(headAcheDataArray.count)
//                windSpeedAvg = windSpeedAvg.rounded()
//                uviAvg = uviVar / Float(headAcheDataArray.count)
//                uviAvg = uviAvg.rounded()
//
//                //Time avg:
//                let maxTime = timeResult.max()
//                if timeResult[0] == maxTime{
//                    timeAvg = "Morning"
//                }
//                if timeResult[1] == maxTime{
//                    timeAvg = "Afternoon"
//                }
//                if timeResult[2] == maxTime{
//                    timeAvg = "Evening"
//                }
//                avgDuration = (durationVar / headAcheDataArray.count)
//                print(avgDuration)
//            }
//    }
//
//}
//}

