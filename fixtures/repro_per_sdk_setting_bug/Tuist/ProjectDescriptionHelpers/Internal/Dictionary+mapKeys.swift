// Dictionary+mapKeys.swift
// App

import Foundation

extension Dictionary {
    func mapKeys<T>(transform: (Key) -> T) -> [T: Value] where T: Hashable {
        var newDict = [T: Value]()
        newDict.reserveCapacity(capacity)
        return reduce(into: newDict) { acc, pair in
            acc[transform(pair.key)] = pair.value
        }
    }
}
