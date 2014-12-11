//
//  ArtViewController.swift
//  SearchList
//
//  Created by Worth Baker on 12/10/14.
//  Copyright (c) 2014 Worth Baker. All rights reserved.
//

import UIKit

class ArtViewController: UIViewController {
  
  var artURL: NSURL?
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(animated: Bool) {
    if let url = artURL {
      if let data = NSData(contentsOfURL: artURL!) {
        imageView.image = UIImage(data: data)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
