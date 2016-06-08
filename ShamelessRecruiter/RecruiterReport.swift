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
    
    func submitReport(name: String, email: String, message: String,
                      completionHandler: (NSDictionary?, NSError?) -> ()
        ) -> NSURLSessionTask {
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
            print("ERROR: in json conversion")
            print(error)
        }
        
        // TODO: check how NSURLSession.sharedSession() is different
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) in dispatch_async(dispatch_get_main_queue()){
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch(httpResponse.statusCode) {
                    case 200: //success
                        do {
                            var json: NSDictionary!
                            
                            do {
                                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
//                                let nsData = NSKeyedArchiver.archivedDataWithRootObject(json)
                                completionHandler(json, nil)
                            } catch {
                                print(error)
                            }
                        }
                        catch(let jsonConversionFailedMessage){
                            print("DEBUG: json response conversion fail \(jsonConversionFailedMessage) coins.")
                            completionHandler(nil, error)
                        }
                    default:
                        print("POST Request unsuccessful. HTTP Status Code: \(httpResponse.statusCode)")
                        completionHandler(nil, error)
                    }
                } else {
                    print("Not a valid http response. NetworkOperation:downloadJSONFromURL()")
                    completionHandler(nil, error)
                }
            }
        }
        
        task.resume()
        
        return task
    }
}
