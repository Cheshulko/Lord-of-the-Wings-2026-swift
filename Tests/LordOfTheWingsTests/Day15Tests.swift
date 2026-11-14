@testable import LordOfTheWings
import XCTest

final class Day15Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day15-sample-1.txt")
        XCTAssertEqual(try Day15(input: input).part1().description, "184")
    }

    func testPart1() throws {
        let input = try testInput("day15-part-1.txt")
        XCTAssertEqual(try Day15(input: input).part1().description, "233")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day15-sample-1.txt")
        XCTAssertEqual(try Day15(input: input).part2().description, "5448")
    }

    func testPart2() throws {
        let input = try testInput("day15-part-2.txt")
        XCTAssertEqual(try Day15(input: input).part2().description, "16273") 
    }

    func testPart3Sample1() throws {
        let input = try testInput("day15-sample-1.txt")
        XCTAssertEqual(try Day15(input: input).part3().description, "540320698784")
    }

    func testPart3() throws {
        let input = try testInput("day15-part-3.txt")
        XCTAssertEqual(try Day15(input: input).part3().description, "265502412369")
    }
}
