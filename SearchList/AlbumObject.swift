//
//  AlbumObject.swift
//  SearchList
//
//  Created by Worth Baker on 12/10/14.
//  Copyright (c) 2014 Worth Baker. All rights reserved.
//

import UIKit

class AlbumObject: NSObject {
  
  var albumName: String?
  var albumArtURL: NSURL?
  
  init(albumName: String, albumArtURL: String) {
    self.albumName = albumName
    self.albumArtURL = NSURL(string: albumArtURL)
  }
   
}
