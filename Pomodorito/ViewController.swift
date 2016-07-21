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
	
	@IBOutlet weak var timerLabel: UILabel!
	
	var timerLabelStartSecond = 50
	var timerLabelStartMinute = 1
	let startDate = NSDate()
	var timeToFinish = NSDate()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let components = NSDateComponents()
		components.minute = timerLabelStartMinute
		components.second = timerLabelStartSecond
		if let finishTime = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startDate, options: []) {
			timeToFinish = finishTime
		}
		let updateTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.updateFunction(_:)), userInfo: nil, repeats: true)
		NSRunLoop.currentRunLoop().addTimer(updateTimer, forMode: NSRunLoopCommonModes)
	}

	func updateFunction(sender: NSTimer)
	{
		let calendar = NSCalendar.currentCalendar()
		print(calendar.components(.Second, fromDate: self.startDate, toDate: NSDate(), options: []))
		let seconds = calendar.components(.Second, fromDate: NSDate(), toDate: self.timeToFinish, options: []).second%60
		let minutes = calendar.components(.Minute, fromDate: NSDate(), toDate: self.timeToFinish, options: []).minute
		timerLabel.text = "\(minutes):\(seconds)"
	}
	func printTimeElapsed()
	{
		let calendar = NSCalendar.currentCalendar()
		print(calendar.components(.Second, fromDate: self.startDate, toDate: NSDate(), options: []))
		delay(2) { 
			self.printTimeElapsed()
		}
	}
	func delay(delay:Double, closure:()->()) {
		dispatch_after(
			dispatch_time(
				DISPATCH_TIME_NOW,
				Int64(delay * Double(NSEC_PER_SEC))
			),
			dispatch_get_main_queue(), closure)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

