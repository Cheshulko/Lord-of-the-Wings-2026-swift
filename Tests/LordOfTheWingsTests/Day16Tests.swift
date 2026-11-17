@testable import LordOfTheWings
import XCTest

final class Day16Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day16-sample-1.txt")
        XCTAssertEqual(try Day16(input: input).part1().description, "3")
    }

    func testPart1Sample2() throws {
        let input = try testInput("day16-sample-2.txt")
        XCTAssertEqual(try Day16(input: input).part1().description, "26")
    }

    func testPart1() throws {
        let input = try testInput("day16-part-1.txt")
        XCTAssertEqual(try Day16(input: input).part1().description, "56")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day16-sample-3.txt")
        XCTAssertEqual(try Day16(input: input).part2().description, "1053")
    }

    func testPart2() throws {
        let input = try testInput("day16-part-2.txt")
        XCTAssertEqual(try Day16(input: input).part2().description, "24586319") 
    }

    func testPart3Sample1() throws {
        let input = try testInput("day16-sample-4.txt")
        XCTAssertEqual(try Day16(input: input).part3().description, "135154")
    }

    func testPart3() throws {
        let input = try testInput("day16-part-3.txt")
        XCTAssertEqual(try Day16(input: input).part3().description, "24812838924492")
    }
}
