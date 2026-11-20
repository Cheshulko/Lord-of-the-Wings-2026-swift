@testable import LordOfTheWings
import XCTest

final class Day19Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day19-sample-1.txt")
        XCTAssertEqual(try Day19(input: input).part1().description, "144")
    }

    func testPart1() throws {
        let input = try testInput("day19-part-1.txt")
        XCTAssertEqual(try Day19(input: input).part1().description, "2874928")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day19-sample-2.txt")
        XCTAssertEqual(try Day19(input: input).part2().description, "180")
    }

    func testPart2() throws {
        let input = try testInput("day19-part-2.txt")
        XCTAssertEqual(try Day19(input: input).part2().description, "277553553216") 
    }

    func testPart3Sample3() throws {
        let input = try testInput("day19-sample-3.txt")
        XCTAssertEqual(try Day19(input: input).part3().description, "18")
    }

    func testPart3Sample4() throws {
        let input = try testInput("day19-sample-4.txt")
        XCTAssertEqual(try Day19(input: input).part3().description, "343")
    }

    func testPart3Sampl5() throws {
        let input = try testInput("day19-sample-5.txt")
        XCTAssertEqual(try Day19(input: input).part3().description, "8000")
    }

    func testPart3() throws {
        let input = try testInput("day19-part-3.txt")
        XCTAssertEqual(try Day19(input: input).part3().description, "2045803439350")
    }
}
