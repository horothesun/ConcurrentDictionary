import Foundation

public protocol ConcurrentDictionary {
    associatedtype Key: Hashable
    associatedtype Value

    subscript(key: Key) -> Value? { get set }
    func getDictionary() -> [Key: Value]
}
