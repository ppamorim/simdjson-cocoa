//
//  SwiftViewController.swift
//  simdjson-cocoa_Example
//
//  Created by Pedro Paulo de Amorim on 10/07/2019.
//  Copyright © 2019 ppamorim. All rights reserved.
//

import Foundation
import UIKit

class SwiftViewController: UIViewController {
  
  override func loadView() {
    super.loadView()
    let path: URL = Bundle.main.bundleURL.appendingPathComponent("user.json")
    let json: SimdParser = SimdParser.parse(with: path)
    let _: SimdParser = SimdParser.parse(with: try! Data(contentsOf: path))
//    let _: SimdParser = SimdParser.parse(with: try! InputStream(url: path)!, size: Int(fileSize(url: path))) //BROKEN
//    if (json.isObject()) {
//      json.down() //Similar to void compute_dump(ParsedJson::iterator &pjh)
//    }
  }
  
  private func fileSize(url: URL) -> UInt64 {
    var fileSize : UInt64 = 0
    do {
      //return [FileAttributeKey : Any]
      let attr = try FileManager.default.attributesOfItem(atPath: url.path)
      fileSize = attr[FileAttributeKey.size] as! UInt64
      
      //if you convert to NSDictionary, you can get file size old way as well.
      let dict = attr as NSDictionary
      fileSize = dict.fileSize()
    } catch {
      print("Error: \(error)")
    }
    return fileSize
  }
  
}
