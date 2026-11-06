@testable import LordOfTheWings
import XCTest

final class Day09Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day09-sample-1.txt")
        XCTAssertEqual(try Day09(input: input).part1().description, "27")
    }

    func testPart1() throws {
        let input = try testInput("day09-part-1.txt")
        XCTAssertEqual(try Day09(input: input).part1().description, "209")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day09-sample-1.txt")
        XCTAssertEqual(try Day09(input: input).part2().description, "42")
    }

    func testPart2() throws {
        let input = try testInput("day09-part-2.txt")
        XCTAssertEqual(try Day09(input: input).part2().description, "15532") 
    }

    func testPart3() throws {
        let input = try testInput("day09-part-3.txt")
        XCTAssertEqual(try Day09(input: input).part3().description, "881421132255010")
    }
}
