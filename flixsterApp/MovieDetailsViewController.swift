//
//  MovieDetailsViewController.swift
//  flixsterApp
//
//  Created by Michelle Vasquez-Aleman on 1/27/20.
//  Copyright © 2020 Michelle Vasquez-Aleman. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    var movie : [String: Any]! 
    
    @IBOutlet weak var backDropView: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl  = URL(string: baseUrl + posterPath)!
        posterView.af_setImage(withURL: posterUrl) // takes care of downloading and setting
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl  = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backDropView.af_setImage(withURL: backdropUrl) // takes care of downloading and setting
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let id = String(describing: movie["id"]!)
        let movieTrailerViewController = segue.destination as! MovieTrailerViewController
        movieTrailerViewController.movieId = id
    }
    

}
