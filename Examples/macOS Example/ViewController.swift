//
//  ViewController.swift
//  macOS Example
//
//  Created by Leo Dion on 9/21/16.
//  Copyright © 2016 BrightDigit, LLC. All rights reserved.
//

import Cocoa
import SwiftVer

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
  
  @IBOutlet weak var tableView: NSTableView!
  public let values = Version.example.values
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.tableView.tableColumns[0].headerCell.title = "Label"
    self.tableView.tableColumns[1].headerCell.title = "Value"
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  func numberOfRows(in tableView: NSTableView) -> Int {
    return values.count
  }
  
  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    let text:String?
    let cellIdentifier: String
    
    let pair = values[row]
    
    // 2
    if tableColumn == tableView.tableColumns[0] {
      
      cellIdentifier = "LabelCellID"
      text = pair.label
    } else {
      text = pair.value
      cellIdentifier = "ValueCellID"
    }
    // 3
    
  
    if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
      cell.textField?.stringValue = (text ?? "Not Set")
      //cell.imageView?.image = image ?? nil
      return cell
    }
    return nil
  }
}

