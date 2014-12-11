//
//  ViewController.swift
//  SearchList
//
//  Created by Worth Baker on 12/10/14.
//  Copyright (c) 2014 Worth Baker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  
  var wordList = [String]()
  var albumList = [AlbumObject]()
  
  // MARK: - Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    searchBar.becomeFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - URL/JSON Methods
  
  func urlWithSearchText(searchText: String) -> NSURL {
    let escapedSearchText = searchText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    
    let urlString = String(format: "http://itunes.apple.com/search?term=%@%@", escapedSearchText, "&entity=album")
    
    let url = NSURL(string: urlString)
    
    return url!
  }
  
  func performStoreRequestWithURL(url: NSURL) -> String? {
    var error: NSError?
    if let resultsString = String(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: &error) {
      return resultsString
    } else if let error = error {
      println("Donwload error: \(error)")
    } else {
      println("Unknown Download Error")
    }
    return nil
  }
  
  func parseJSON(jsonString: String) -> [String: AnyObject]? {
    if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
      var error: NSError?
      if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error) as? [String: AnyObject] {
        return json
      } else if let error = error {
        println("JSON Error: \(error)")
      } else {
        println("Unknown JSON Error")
      }
    }
    return nil
  }
  
  func parseDictionary(dictionary: [String: AnyObject]) {
    if let array: AnyObject = dictionary["results"] {
      for resultDict in array as [AnyObject] {
        if let resultDict = resultDict as? [String: AnyObject] {
          if let collectionName = resultDict["collectionName"] as? NSString {
            var album = AlbumObject(albumName: String(collectionName), albumArtURL: "about:blank")
            // wordList.append(String(collectionName))
            if let artworkUrl60 = resultDict["artworkUrl60"] as? NSString {
              album.albumArtURL = NSURL(string: String(artworkUrl60))
              albumList.append(album)
            }
          }
        } else {
          println("expected a dictionary")
        }
      }
    } else {
      println("expected results array")
    }
  }
  
  // MARK: - UISearchBarDelegateMethods
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    let url = urlWithSearchText(searchBar.text)
    if let jsonString = performStoreRequestWithURL(url) {
      if let dictionary = parseJSON(jsonString) {
        albumList.removeAll(keepCapacity: false)
        parseDictionary(dictionary)
        tableView.reloadData()
        searchBar.resignFirstResponder()
        return
      }
    }
    println("ERROR")
  }
  
}

  // MARK: - Table View Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albumList.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as UITableViewCell
    
    let label = cell.viewWithTag(1000) as UILabel
    label.text = albumList[indexPath.row].albumName
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowArt" {
      let indexPath = self.tableView.indexPathForSelectedRow()
      
      let navigationController = segue.destinationViewController as UINavigationController
      
      let controller = navigationController.topViewController as ArtViewController
      
      controller.artURL = albumList[indexPath!.row].albumArtURL
    }
  }
  
}