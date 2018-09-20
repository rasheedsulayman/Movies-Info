//
//  Array+OptionalIndex.swift
//  Movies Info
//
//  Created by Rasheed Sulayman on 20/09/2018.
//  Copyright © 2018 r4sh33d. All rights reserved.
//  credit : https://stackoverflow.com/a/30593673/6484427

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
