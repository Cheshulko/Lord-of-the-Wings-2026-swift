@testable import LordOfTheWings
import XCTest

final class Day12Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day12-sample-1.txt")
        XCTAssertEqual(try Day12(input: input).part1().description, "7")
    }

    func testPart1() throws {
        let input = try testInput("day12-part-1.txt")
        XCTAssertEqual(try Day12(input: input).part1().description, "210")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day12-sample-2.txt")
        XCTAssertEqual(try Day12(input: input).part2().description, "6")
    }

    func testPart2Sample3() throws {
        let input = try testInput("day12-sample-3.txt")
        XCTAssertEqual(try Day12(input: input).part2().description, "23")
    }

    func testPart2() throws {
        let input = try testInput("day12-part-2.txt")
        XCTAssertEqual(try Day12(input: input).part2().description, "1976") 
    }

    func testPart3Sample4() throws {
        let input = try testInput("day12-sample-4.txt")
        XCTAssertEqual(try Day12(input: input).part3().description, "8")
    }

    func testPart3Sample5() throws {
        let input = try testInput("day12-sample-5.txt")
        XCTAssertEqual(try Day12(input: input).part3().description, "29")
    }

    func testPart3Sample6() throws {
        let input = try testInput("day12-sample-6.txt")
        XCTAssertEqual(try Day12(input: input).part3().description, "16")
    }

    func testPart3() throws {
        let input = try testInput("day12-part-3.txt")
        XCTAssertEqual(try Day12(input: input).part3().description, "2885")
    }
}
