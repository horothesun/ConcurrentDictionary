import Foundation

public final class ConcurrentDictionaryLock<Key: Hashable, Value> {
    public typealias Key = Key
    public typealias Value = Value

    private var dictionary: [Key: Value] = [:]
    private let onSetValueForKey: ((_ key: Key, _ value: Value?) -> Void)?

    private let lock = NSLock()

    public init(
        from dictionary: [Key: Value],
        onSetValueForKey: ((_ key: Key, _ value: Value?) -> Void)? = nil
    ) {
        self.dictionary = dictionary
        self.onSetValueForKey = onSetValueForKey
    }
}

extension ConcurrentDictionaryLock: ConcurrentDictionary {

    public subscript(key: Key) -> Value? {
        get { get(key) }
        set { set(newValue, for: key) }
    }

    public func getDictionary() -> [Key : Value] {
        lock.withCriticalSection { [dictionary] () -> [Key : Value] in dictionary }
    }

    private func get(_ key: Key) -> Value? {
        lock.withCriticalSection { [dictionary] () -> Value? in dictionary[key] }
    }

    private func set(_ newValue: Value?, for key: Key) {
        lock.withCriticalSection { [weak self] () -> () in
            self?.dictionary[key] = newValue
            self?.onSetValueForKey?(key, newValue)
        }
    }
}
