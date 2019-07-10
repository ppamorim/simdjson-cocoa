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
//    if (json.isObject()) {
//      json.down() //Similar to void compute_dump(ParsedJson::iterator &pjh)
//    }
  }
  
}
