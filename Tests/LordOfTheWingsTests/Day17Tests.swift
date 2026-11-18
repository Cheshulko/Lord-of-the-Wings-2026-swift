@testable import LordOfTheWings
import XCTest

final class Day17Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day17-sample-1.txt")
        XCTAssertEqual(try Day17(input: input).part1().description, "21")
    }

    func testPart1() throws {
        let input = try testInput("day17-part-1.txt")
        XCTAssertEqual(try Day17(input: input).part1().description, "166")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day17-sample-1.txt")
        XCTAssertEqual(try Day17(input: input).part2().description, "94")
    }

    func testPart2() throws {
        let input = try testInput("day17-part-2.txt")
        XCTAssertEqual(try Day17(input: input).part2().description, "6212") 
    }

    func testPart3Sample1() throws {
        let input = try testInput("day17-sample-1.txt")
        XCTAssertEqual(try Day17(input: input).part3().description, "31")
    }

    func testPart3() throws {
        let input = try testInput("day17-part-3.txt")
        XCTAssertEqual(try Day17(input: input).part3().description, "2704")
    }
}
