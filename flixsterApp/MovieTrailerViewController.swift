//
//  MovieTrailerViewController.swift
//  flixsterApp
//
//  Created by Michelle Vasquez-Aleman on 1/28/20.
//  Copyright © 2020 Michelle Vasquez-Aleman. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var movieTrailerView: WKWebView!
    var movieId : String = ""
    var key : String = ""
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        movieTrailerView = WKWebView(frame: .zero, configuration: webConfiguration)
        movieTrailerView.uiDelegate = self
        self.view = movieTrailerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let endpoint = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        print(endpoint)
             let url = URL(string: endpoint)!
             let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

             let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
             let task = session.dataTask(with: request) { (data, response, error) in
                 // This will run when the network request returns
                 if let error = error {
                     print(error.localizedDescription)
                 } else if let data = data {
                     // data is contained in this dictionary
                     let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let movies = dataDictionary["results"] as? [[String:Any]]
                    let movie = movies?.first!
                    
                    self.key = movie?["key"] as! String
                    print(self.key)
                    if let trailerURL = URL(string: "https://www.youtube.com/watch?v=\(self.key)"){
                        let trailerRequest = URLRequest(url: trailerURL)
                        self.movieTrailerView.load(trailerRequest)
                    }
                   
                    
                 }
             }
             task.resume()
    
        
       
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
