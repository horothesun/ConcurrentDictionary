import XCTest
import ConcurrentDictionary

final class ConcurrentDictionaryLockTests: XCTestCase {

    func test_subscriptGet_onSequentialEnvironment_fromEmptyDictionary_mustReturnNil() {
        typealias Key = Int
        typealias Value = String
        let key: Key = 3
        let dictionary = [Key: Value]()
        let sut = makeSUT(
            keyType: Key.self,
            valueType: Value.self,
            from: dictionary,
            onSetValueForKey: { _, _ in }
        )
        let sequentialQueue = DispatchQueue(label: UUID().uuidString)
        let expectation = XCTestExpectation(description: "sut[key] == nil")
        sequentialQueue.async {
            if sut[key] == nil {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func test_subscriptGet_onSequentialEnvironment_fromDictionaryContainingValueForKey_mustReturnValue() {
        typealias Key = Int
        typealias Value = String
        let key: Key = 3
        let value: Value = "🍄"
        let dictionary = [key: value]
        let sut = makeSUT(
            keyType: Key.self,
            valueType: Value.self,
            from: dictionary,
            onSetValueForKey: { _, _ in }
        )
        let sequentialQueue = DispatchQueue(label: UUID().uuidString)
        let expectation = XCTestExpectation(description: "sut[key] == value")
        sequentialQueue.async {
            if sut[key] == value {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func test_subscriptSet_onSequentialEnvironment_fromEmptyDictionary_mustInsertKeyValue() {
        typealias Key = Int
        typealias Value = String
        let key: Key = 3
        let value: Value = "🥝"
        let dictionary = [key: value]
        let sut = makeSUT(
            keyType: Key.self,
            valueType: Value.self,
            from: dictionary,
            onSetValueForKey: { _, _ in }
        )
        let sequentialQueue = DispatchQueue(label: UUID().uuidString)
        let group = DispatchGroup()
        group.enter()
        sequentialQueue.async {
            sut[key] = value
            group.leave()
        }
        _ = group.wait(timeout: .now() + .seconds(1))
        XCTAssert(sut.getDictionary()[key] == value)
    }

    func test_subscriptSetMultipleTimes_onConcurrentEnvironment_mustInsertAllKeyValuePairs() {
        typealias Key = Int
        typealias Value = String
        let keyCount = 800
        var dictionary = [Key: Value]()
        (0..<keyCount).forEach { dictionary[$0] = "\($0)" }
        let sut = makeSUT(
            keyType: Key.self,
            valueType: Value.self,
            from: dictionary,
            onSetValueForKey: { _, _ in }
        )
        let expectations = (0..<keyCount)
            .map { "\($0) -> \"\($0)\" set" }
            .map { [unowned self] description in self.expectation(description: description) }
        let concurrentQueue = DispatchQueue(label: UUID().uuidString, attributes: .concurrent)
        dictionary.forEach { (key, value) in
            concurrentQueue.async {
                sut[key] = value
                expectations[key].fulfill()
            }
        }
        wait(for: expectations, timeout: 3)
    }
}

extension ConcurrentDictionaryLockTests {
    private func makeSUT<Key: Hashable, Value>(
        keyType: Key.Type,
        valueType: Value.Type,
        from dictionary: [Key: Value],
        onSetValueForKey: ((Key, Value?) -> Void)?
    ) -> ConcurrentDictionaryLock<Key, Value> {
        .init(from: dictionary, onSetValueForKey: onSetValueForKey)
    }
}
