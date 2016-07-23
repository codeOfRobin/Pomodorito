//
//  ViewController.swift
//  Pomodorito
//
//  Created by Robin on 21/07/16.
//  Copyright © 2016 comicsanshq. All rights reserved.
//

import UIKit
import SwiftCharts
class ViewController: UIViewController {
	
	var chart: Chart?
	
	@IBOutlet weak var workTimerLabel: UILabel!
	@IBOutlet weak var playTimerLabel: UILabel!

	@IBOutlet weak var workTimePicker: UIDatePicker!
	@IBOutlet weak var playTimePicker: UIDatePicker!
	
	var timerLabelStartSecond = 10
	var timerLabelStartMinute = 0
	var startDate = NSDate()
	var timeToFinish = NSDate()
	
	
	func setupLocalNotification() {
		let notification = UILocalNotification()
		notification.alertAction = "Done"
		notification.alertBody = "Your work period is over!"
		notification.applicationIconBadgeNumber = 1
		notification.fireDate = timeToFinish
		notification.timeZone = NSTimeZone.defaultTimeZone()
		notification.soundName = UILocalNotificationDefaultSoundName
		notification.soundName = "asdf.aif"
		
		notification.category = "ANSWERS_CATEGORY"
		
		UIApplication.sharedApplication().scheduleLocalNotification(notification)
	}
	
	@IBAction func setTimer(sender: AnyObject)
	{
		startDate = NSDate()
		let updateTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.updateFunction(_:)), userInfo: nil, repeats: true)
		
		NSRunLoop.currentRunLoop().addTimer(updateTimer, forMode: NSRunLoopCommonModes)
		let components = NSDateComponents()
//		components.second = Int(timePicker.countDownDuration)
		components.second = 10
		if let finishTime = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startDate, options: []) {
			timeToFinish = finishTime
		}
		setupLocalNotification()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		workTimePicker.datePickerMode = .CountDownTimer
		workTimePicker.timeZone =  NSTimeZone(abbreviation: "UTC")
		playTimePicker.datePickerMode = .CountDownTimer
		playTimePicker.timeZone =  NSTimeZone(abbreviation: "UTC")
		PomodoroTracker.sharedPomodoroTracker.reinitPomodoro()
		//		PomodoroTracker.sharedPomodoroTracker.saveToDB()
	}
	
	func updateFunction(sender: NSTimer) {
		let calendar = NSCalendar.currentCalendar()
		let seconds = calendar.components(.Second, fromDate: NSDate(), toDate: self.timeToFinish, options: []).second%60
		let minutes = calendar.components(.Minute, fromDate: NSDate(), toDate: self.timeToFinish, options: []).minute
		workTimerLabel.text = "\(minutes):\(seconds)"
	}
	
//	func printTimeElapsed() {
//		let calendar = NSCalendar.currentCalendar()
//		print(calendar.components(.Second, fromDate: self.startDate, toDate: NSDate(), options: []))
//		delay(2) {
//			self.printTimeElapsed()
//		}
//	}
//	func delay(delay:Double, closure:()->()) {
//		dispatch_after(
//			dispatch_time(
//				DISPATCH_TIME_NOW,
//				Int64(delay * Double(NSEC_PER_SEC))
//			),
//			dispatch_get_main_queue(), closure)
//	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

