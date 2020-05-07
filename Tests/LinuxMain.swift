import XCTest

import ConcurrentDictionaryTests

var tests = [XCTestCaseEntry]()
tests += ConcurrentDictionaryTests.__allTests()

XCTMain(tests)
