//
//  BaseViewController.swift
//  flicks
//
//  Created by Alex Liu on 10/17/16.
//  Copyright © 2016 alex_liu. All rights reserved.
//

import Foundation
import UIKit

public class BaseViewController: UIViewController {

  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
