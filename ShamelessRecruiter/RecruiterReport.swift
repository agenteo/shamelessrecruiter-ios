//
//  RecruiterReport.swift
//  ShamelessRecruiter
//
//  Created by agenteo on 1/06/2016.
//  Copyright © 2016 agenteo. All rights reserved.
//
import Foundation

class RecruiterReport{
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func submitReport(name: String, email: String, message: String){
        print("DEBUG: submit report called")
        
        let url = NSURL(string: "http://localhost:8080/api/reportRecruiter")!
        let request = NSMutableURLRequest(URL: url)
        
        // prepare json data
        let json = [ "name": name, "email": email, "message": message ]
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPMethod = "POST"
            request.HTTPBody = jsonData
        }
        catch{
            print(error)
        }
    
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if let jsonData = data {
                if let jsonString = NSString(data: jsonData,
                                             encoding: NSUTF8StringEncoding){
                    print(jsonString)
                }
            }
            else if let requestError = error {
                print("DEBUG: Error submitting report: \(requestError)")
            }
            else{
                print("DEBUG: Unexpected error with the request")
            }
        }
        task.resume()
    }
}
