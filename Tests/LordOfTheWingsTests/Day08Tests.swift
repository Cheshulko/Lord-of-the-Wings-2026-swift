@testable import LordOfTheWings
import XCTest

final class Day08Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day08-sample-1.txt")
        XCTAssertEqual(try Day08(input: input).part1().description, "32")
    }

    func testPart1() throws {
        let input = try testInput("day08-part-1.txt")
        XCTAssertEqual(try Day08(input: input).part1().description, "167")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day08-sample-1.txt")
        XCTAssertEqual(try Day08(input: input).part2().description, "187")
    }

    func testPart2() throws {
        let input = try testInput("day08-part-2.txt")
        XCTAssertEqual(try Day08(input: input).part2().description, "1012") 
    }

    func testPart3Sample1() throws {
        let input = try testInput("day08-sample-1.txt")
        XCTAssertEqual(try Day08(input: input).part3().description, "899889")
    }

    func testPart3() throws {
        let input = try testInput("day08-part-3.txt")
        XCTAssertEqual(try Day08(input: input).part3().description, "899273")
    }
}
