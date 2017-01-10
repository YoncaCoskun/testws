//
//  ViewController.swift
//  testws
//
//  Created by Yonca Coskun on 7.01.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase


class ViewController: UIViewController {
    
    var id: String = ""
    var imdbId: String = ""
    var ref : FIRDatabaseReference!
    var items: [Movie] = []
   // var pageNum: Int = 5
   // var page: String = ""
    var request1: String = ""
    var request2:String = ""
    var pageId: String = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref =  FIRDatabase.database().reference()
        
        
        //1130 pages
       //for k in 0..<pageNum {
       //     page = String(j)
       //     print(page)
    
           // let k = k + 1
           // let page = String(k)
            request1 = "https://api.themoviedb.org/3/discover/movie?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&vote_average.gte=6&append_to_response=external_ids"
        print(request1)
            Alamofire.request(self.request1,method: .get).responseJSON { response in
                
                if let json = response.result.value{
                    //print("JSON: \(json)")
                    
                    let jsonParse = JSON(json)
                    // print(jsonParse)
                    // print("------------------------- ----------------")
                    let arrayIds =  jsonParse["results"].arrayValue.map({$0["id"].stringValue})
                    let pageId = jsonParse["page"].stringValue
                    
                    //  print(arrayIds)
                    //  print(self.id)
                    
                    for i in 0..<arrayIds.count {
                        
                        self.id = arrayIds[i]
                     //   print(self.id)
                        
                        self.request2 = "https://api.themoviedb.org/3/movie/"+self.id+"?api_key=60ec9d5fa8ff0c39143aa6049c37291e&language=en-US"
                        Alamofire.request(self.request2).responseJSON { response in
                            
                            if let jsonMovie = response.result.value{
                                // print("JSON: \(jsonMovie)")
                                
                                let jsonParseMovie = JSON(jsonMovie)
                                
                                let imdbId = jsonParseMovie["imdb_id"].stringValue
                                
                               
                                print(imdbId)
                                
                                Alamofire.request("https://www.omdbapi.com/?i="+imdbId+"&plot=short&r=json&tomatoes=true").responseJSON { response in
                                    
                                    if let jsonImdb = response.result.value{
                                        // print("JSON: \(jsonMovie)")
                                        
                                        let jsonParseImdb = JSON(jsonImdb)
                                        print(jsonParseImdb)
                                        
                                        
                                        //l-----------firebase e atma islemi--------------
                                        
                                        let title = jsonParseImdb["Title"].stringValue
                                        let year = jsonParseImdb["Year"].stringValue
                                        let released = jsonParseImdb["Released"].stringValue
                                        let runtime = jsonParseImdb["Runtime"].stringValue
                                        let genre = jsonParseImdb["Genre"].stringValue
                                        let language = jsonParseImdb["Language"].stringValue
                                        let country = jsonParseImdb["Country"].stringValue
                                        let poster = jsonParseImdb["Poster"].stringValue
                                        let metascore = jsonParseImdb["Metascore"].stringValue
                                        let imdbRating = jsonParseImdb["imdbRating"].stringValue
                                        let imdbVotes = jsonParseImdb["imdbVotes"].stringValue
                                        let type = jsonParseImdb["Type"].stringValue
                                        let tomatoMeter = jsonParseImdb["tomatoMeter"].stringValue
                                        let tomatoRating = jsonParseImdb["tomatoRating"].stringValue
                                        let tomatoReviews = jsonParseImdb["tomatoReviews"].stringValue
                                        let tomatoFresh = jsonParseImdb["tomatoFresh"].stringValue
                                        let tomatoRotten = jsonParseImdb["tomatoRotten"].stringValue
                                        let tomatoConsensus = jsonParseImdb["tomatoConsensus"].stringValue
                                        let tomatoUserMeter = jsonParseImdb["tomatoUserMeter"].stringValue
                                        let tomatoUserRating = jsonParseImdb["tomatoUserRating"].stringValue
                                        
                                        
                                        
                                        
                                        print(title)
                                        print(year)
                                        // 2
                                        let filmItem = Movie(title: title ,year: year, released: released, runtime: runtime,genre: genre,
                                                             language: language, country: country, poster: poster, metascore: metascore,
                                                             imdbRating: imdbRating, imdbVotes: imdbVotes, type: type, tomatoMeter: tomatoMeter,
                                                             tomatoRating: tomatoRating, tomatoReviews: tomatoReviews, tomatoFresh: tomatoFresh,
                                                             tomatoRotten: tomatoRotten, tomatoConsensus: tomatoConsensus, tomatoUserMeter: tomatoUserMeter,
                                                             tomatoUserRating: tomatoUserRating)
                                        // 3
                                        let filmItemRef = self.ref.child("results")
                                        
                                        let pageIdRef = filmItemRef.child("page"+pageId+"")
                                        
                                        let imdbRef = pageIdRef.child(imdbId)
                                        
                                        // 4
                                        imdbRef.setValue(filmItem.toAnyObject())
                                        
                                        self.items.append(filmItem)
                                        // self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        //}
       
        
    }
}

