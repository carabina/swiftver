//
//  SemVer.swift
//  SwiftVer
//
//  Created by Leo Dion on 9/21/16.
//  Copyright © 2016 BrightDigit, LLC. All rights reserved.
//

import Foundation

public struct SemVer : CustomStringConvertible  {
  public let major:UInt8
  public let minor:UInt8
  public let patch:UInt8?
  
  public init?(versionString: String) {
    let values = versionString.components(separatedBy: ".").flatMap{  UInt8($0) }
    if values.count == 2 || values.count == 3 {
      self.major = values.first!
      self.minor = values[1]
      self.patch = values.count == 3 ? values[2] : nil
    } else {
      return nil
    }
  }
  
  public var description:String {
    if let patch = self.patch {
      return "\(self.major).\(self.minor).\(patch)"
    } else {
      return "\(self.major).\(self.minor)"
    }
  }
}
