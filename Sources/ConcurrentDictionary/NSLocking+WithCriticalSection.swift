import Foundation

extension NSLocking {
    func withCriticalSection<T>(_ closure: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try closure()
    }
}
