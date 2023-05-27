//
//  Array+Extension.swift
//  Extentions
//
//  Created by Akshay Kumar on 27/05/23.
//

import Foundation

extension Array {
    /// The second element of the collection.
    ///
    /// If the collection is empty, the value of this property is `nil`.
    ///
    ///     let numbers = [10, 20, 30, 40, 50]
    ///     if let secondNumber = numbers.second{
    ///         print(secondNumber)
    ///     }
    ///     // Prints "20"
    @inlinable public var second: Element? {
        return (self.count > 1) ? self[1] : nil
    }
}

extension Array where Element: Equatable {
    
    mutating func removeItem(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}

extension Array where Element: Hashable {
    
    func differenceArray(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
