//
//  Dashboard.swift
//  Headache Tracker
//
//  Created by Nehal Jhala on 12/5/22.
//

import Foundation
import UIKit
    var genderData = ["Male", "Female", "Non Binary", "Prefer Not to Say"]
    var ageData = ["15 - 25 years", "26 - 40 years", "41 - 60 years", "above 60"]
    var heightData = ["4.9","5.0","5.1", "5.2", "5.3", "5.4", "5.5", "5.6","5.7", "5.8", "5.9", "5.10", "5.11", "6.0", "6.1", "6.2","6.3","6.4","6.5","6.6, 6.7"]
//Analytics:
//func doAnalysis(){
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
//    var context:NSManagedObjectContext!
//    context = appDelegate.persistentContainer.viewContext
//    var _: NSError? = nil
//    let predicate = NSPredicate(format: "userName = %@" , appDelegate.currentUser)
//    let fReq: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HeadacheData")
//    fReq.returnsObjectsAsFaults = false
//    fReq.predicate = predicate
//    do {
//        let headacheDataTable : [NSManagedObject] = try context.fetch(fReq) as! [NSManagedObject]
//
//        var humiVar: Float = 0.0
//        var tempVar : Float = 0.0
//        var windSpVar : Float = 0.0
//        var uviVar : Float = 0.0
//        var timeResult = [0,0,0]
//        var durationVar = 0
//        if headacheDataTable.count == 0 {
//            humidityAvg = 0
//            tempAvg = 0
//            uviAvg = 0
//            windSpeedAvg = 0
//            timeAvg = "None Yet"
//            avgDuration = 0
//        }
//        else {
//            for i in 0..<headacheDataTable.count{
//                //Avg weather condition:
//                let humidityFloat = headacheDataTable[i].value(forKey: "humidity")as! Float
//                humiVar += humidityFloat
//                let tempFloat = headacheDataTable[i].value(forKey: "temp")as! Float
//                let tempFahr = convertKelvinToFarenheit(tempFloat)
//                tempVar += tempFahr
//                let windSpeedFloat = headacheDataTable[i].value(forKey: "windSpeed")as! Float
//                windSpVar += windSpeedFloat
//                let uviFloat = headacheDataTable[i].value(forKey: "uvi")as! Float
//                uviVar += uviFloat
//
//                //Average time:
//                let startTimeDate = headacheDataTable[i].value(forKey: "startTime")
//                if startTimeDate != nil  {
//                    let sdt = startTimeDate as! Date
//                    var calendar = Calendar.current
//                    calendar.timeZone = TimeZone.current
//                    let hour = calendar.component(.hour, from: sdt)
//                    _ = calendar.component(.minute, from:sdt)
//                    print(hour, "HOur")
//                    if hour == 00 {
//                        timeResult[0] += 1
//                    }
//                    if hour <= 11  {
//                        timeResult[0] += 1
//                    }
//                    if hour > 11 && hour < 18{
//                        timeResult[1] += 1
//                    }
//                    if hour >= 18 {
//                        timeResult[2] += 1
//                    }
//                }
//                //calculate duration of headache:
//                var duration = Int()
//                let headacheEndDate = headacheDataTable[i].value(forKey: "endTime")
//                if (headacheEndDate != nil ) {
//                    let df = DateFormatter()
//                    df.dateFormat = "MM/dd/YY  HH:MM"
//                    let newDateMinutes = (headacheEndDate! as AnyObject).timeIntervalSinceReferenceDate/60
//                    let oldDateMinutes = (startTimeDate! as AnyObject).timeIntervalSinceReferenceDate/60
//                    let timeDifference = ( Double(newDateMinutes - oldDateMinutes)) //in minutes
//                    print(timeDifference, "td")
//                    duration = Int(timeDifference.rounded())
//                    durationVar += duration
//                    print(duration)
//                }
//            }
//            //Weather avg:
//            humidityAvg = humiVar / Float(headacheDataTable.count)
//            humidityAvg = humidityAvg.rounded()
//            tempAvg = tempVar / Float(headacheDataTable.count)
//            tempAvg = tempAvg.rounded()
//            windSpeedAvg = windSpVar / Float(headacheDataTable.count)
//            windSpeedAvg = windSpeedAvg.rounded()
//            uviAvg = uviVar / Float(headacheDataTable.count)
//            uviAvg = uviAvg.rounded()
//
//            //Time avg:
//            let maxTime = timeResult.max()
//            if timeResult[0] == maxTime{
//                timeAvg = "Morning"
//            }
//            if timeResult[1] == maxTime{
//                timeAvg = "Afternoon"
//            }
//            if timeResult[2] == maxTime{
//                timeAvg = "Evening"
//            }
//            avgDuration = (durationVar / headacheDataTable.count)
//            print(avgDuration)
//            updateDashboard()
//            labelDisplay()
//        }
//    } catch {
//    }
//}
//
//func updateDashboard() {
//    tempAvgLabel.text = "\(tempAvg) \nTemp(F)"
//    humidityAvgLabel.text = "\(humidityAvg) \nHumidity"
//    uviAvgLabel.text = "\(uviAvg) \nUVI"
//    windSpeedAvgLabel.text = "\(windSpeedAvg) \nWind(MPH)"
//    avgDurationLabel.text = "\(avgDuration) \nDuration\n(Mins)"
//    avgTimeLabel.text = "Your Headache mostly occurs at \n\(timeAvg)"
//}
//
//    func setupLayout(){
//        let tempString:NSString = "\(tempAvgLabel.text!)" as NSString
//        var tempMutableString = NSMutableAttributedString()
//        let humidityString:NSString = "\(humidityAvgLabel.text!)" as NSString
//        var humidityMutableString = NSMutableAttributedString()
//        let windSpeedString:NSString = "\(windSpeedAvgLabel.text!)" as NSString
//        var windSpeedMutableString = NSMutableAttributedString()
//        let uviString:NSString = "\(uviAvgLabel.text!)" as NSString
//        var uviMutableString = NSMutableAttributedString()
//        let durationString:NSString = "\(avgDurationLabel.text!)" as NSString
//        var durationMutableString = NSMutableAttributedString()
//        let timeString:NSString = "\(avgTimeLabel.text!)" as NSString
//        var timeMutableString = NSMutableAttributedString()
//
//        tempMutableString = NSMutableAttributedString(string: tempString as String)
//        tempMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30),NSAttributedString.Key.foregroundColor: UIColor.systemRed],range: NSMakeRange(0, 4))
//        humidityMutableString = NSMutableAttributedString(string: humidityString as String)
//        humidityMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30),NSAttributedString.Key.foregroundColor: UIColor.systemRed],range: NSMakeRange(0, 4))
//        windSpeedMutableString = NSMutableAttributedString(string: windSpeedString as String)
//        windSpeedMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30),NSAttributedString.Key.foregroundColor: UIColor.systemRed],range: NSMakeRange(0, 4))
//        uviMutableString = NSMutableAttributedString(string:uviString as String)
//        uviMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30),NSAttributedString.Key.foregroundColor: UIColor.systemRed],range: NSMakeRange(0, 4))
//        durationMutableString = NSMutableAttributedString(string: durationString as String)
//        durationMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30),NSAttributedString.Key.foregroundColor: UIColor.systemRed],range: NSMakeRange(0, 3))
//        timeMutableString = NSMutableAttributedString(string: timeString as String)
//        timeMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.systemGray5],range: NSMakeRange(0, 30))
//        tempAvgLabel.attributedText = tempMutableString
//        humidityAvgLabel.attributedText = humidityMutableString
//        windSpeedAvgLabel.attributedText = windSpeedMutableString
//        uviAvgLabel.attributedText = uviMutableString
//        avgDurationLabel.attributedText = durationMutableString
//        avgTimeLabel.attributedText = timeMutableString
//    }
//
