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
    
    @IBOutlet weak var submissionResultLabel: UILabel!
    
    var report: RecruiterReport!
    
    override func viewWillAppear(animated: Bool) {
        submissionResultLabel.hidden = true
        super.viewWillAppear(animated)
    }

    
   
    @IBAction func reportRecruiter(sender: AnyObject){
        print("DEBUG: report submit clicked")
        print(nameField.text!);
        report.submitReport(nameField.text!,
                            email: emailField.text!,
                            message: messageField.text!){
        responseData, error in
                                guard responseData != nil else{
                                    print("Problem with the submission")
                                    print(responseData)
                                    print(error)
                                    self.submissionResultLabel.text = "Failed... ensure fields are filled in."
                                    self.submissionResultLabel.hidden = false
                                    return
                                }
                                print("submission done")
                                print(responseData)
                                self.submissionResultLabel.text = "Success!"
                                self.submissionResultLabel.hidden = false
        };
    }
}