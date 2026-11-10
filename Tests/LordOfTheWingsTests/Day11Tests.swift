@testable import LordOfTheWings
import XCTest

final class Day11Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day11-sample-1.txt")
        XCTAssertEqual(try Day11(input: input).part1().description, "60")
    }

    func testPart1() throws {
        let input = try testInput("day11-part-1.txt")
        XCTAssertEqual(try Day11(input: input).part1().description, "1868")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day11-sample-1.txt")
        XCTAssertEqual(try Day11(input: input).part2().description, "6")
    }

    func testPart2() throws {
        let input = try testInput("day11-part-2.txt")
        XCTAssertEqual(try Day11(input: input).part2().description, "2470") 
    }

    func testPart3Sample2() throws {
        let input = try testInput("day11-sample-2.txt")
        XCTAssertEqual(try Day11(input: input).part3().description, "854")
    }

    func testPart3Sample3() throws {
        let input = try testInput("day11-sample-3.txt")
        XCTAssertEqual(try Day11(input: input).part3().description, "9634")
    }

    func testPart3() throws {
        let input = try testInput("day11-part-3.txt")
        XCTAssertEqual(try Day11(input: input).part3().description, "27826")
    }
}
