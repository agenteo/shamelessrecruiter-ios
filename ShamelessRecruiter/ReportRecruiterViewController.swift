//
//  ReportRecruiterViewController.swift
//  ShamelessRecruiter
//
//  Created by agenteo on 1/06/2016.
//  Copyright © 2016 agenteo. All rights reserved.
//

import UIKit

class ReportRecruiterViewController: UIViewController{
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var reportRecruiterButton: UIButton!
    
    var report: RecruiterReport!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

   
    @IBAction func reportRecruiter(sender: AnyObject){
        print("DEBUG: report submit clicked")
        
        var result = report.submitReport(nameField.text!,
                            email: emailField.text!,
                            message: messageField.text!);
    }
}