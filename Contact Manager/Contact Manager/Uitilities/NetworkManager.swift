//
//  NetworkManager.swift
//  Contact Manager
//
//  Created by Pyramid on 18/11/21.
//

import Foundation



class NetworkManager:NSObject
{
    class func GETMethodRequest(offset: String,  success: @escaping (AnyObject?)->Void, Failure: @escaping (NSError)->Void)
    {
        
        if ReachabilityManager.shared.isConnectedToNetwork() == false
        {
            ReachabilityManager.shared.noInternetConnectionAlert()
        }
        else if let url = URL(string: "\(AppConfig.baseURL)?offset=\(offset)")
        {
            var request: URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 600.0)
            print("URL..\(url)")
            
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                if(error == nil)
                {
                    do
                    {
                        if let httpResponse = response as? HTTPURLResponse
                        {
                            
                            let statusCode = httpResponse.statusCode
                            print(statusCode)
                            if (statusCode == 426)
                            {
                                
                            }
                            else if (statusCode == 503)
                            {
                                
                            }
                            else if (statusCode == 401)
                            {
                                //unauthorized user
                                
                            }
                            else if (statusCode == 200)
                            {
                                let JSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                                print("Response..", JSON)
                                
                                success(JSON as AnyObject?)
                            }
                            else
                            {
                                
                            }
                        }
                        else
                        {
                            
                        }
                    }
                    catch let JSONError as NSError
                    {
                        Failure(JSONError as NSError)
                        print("JSON Error is \(JSONError)")
                    }
                    
                }
                else
                {
                    Failure(error! as NSError)
                    print("Error is \(error!)")
                    
                }
            })
            task.resume()
        }
    }
    
}
