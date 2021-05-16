//
//  String+Truncate.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-08.
//

import Foundation

extension String {
  func truncatedPrefix(_ maxLength: Int, using truncator: String = "...") -> String {
    "\(prefix(maxLength))\(truncator)"
  }
}
