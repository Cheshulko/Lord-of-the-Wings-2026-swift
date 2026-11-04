@testable import LordOfTheWings
import XCTest

final class Day07Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day07-sample-1.txt")
        XCTAssertEqual(try Day07(input: input).part1().description, "102")
    }

    func testPart1() throws {
        let input = try testInput("day07-part-1.txt")
        XCTAssertEqual(try Day07(input: input).part1().description, "295")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day07-sample-1.txt")
        XCTAssertEqual(try Day07(input: input).part2().description, "1316")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day07-sample-2.txt")
        XCTAssertEqual(try Day07(input: input).part2().description, "1214633")
    }

    func testPart2() throws {
        let input = try testInput("day07-part-2.txt")
        XCTAssertEqual(try Day07(input: input).part2().description, "155619496") 
    }

    func testPart3Sample1() throws {
        let input = try testInput("day07-sample-1.txt")
        XCTAssertEqual(try Day07(input: input).part3_sample().description, "187")
    }

    func testPart3() throws {
        let input = try testInput("day07-part-3.txt")
        XCTAssertEqual(try Day07(input: input).part3().description, "25792431")
    }
}
