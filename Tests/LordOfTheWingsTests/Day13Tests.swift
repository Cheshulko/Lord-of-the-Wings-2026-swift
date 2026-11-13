@testable import LordOfTheWings
import XCTest

final class Day13Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day13-sample-1.txt")
        XCTAssertEqual(try Day13(input: input).part1().description, "5")
    }

    func testPart1Sample2() throws {
        let input = try testInput("day13-sample-2.txt")
        XCTAssertEqual(try Day13(input: input).part1().description, "7")
    }

    func testPart1Sample3() throws {
        let input = try testInput("day13-sample-3.txt")
        XCTAssertEqual(try Day13(input: input).part1().description, "9")
    }

    func testPart1() throws {
        let input = try testInput("day13-part-1.txt")
        XCTAssertEqual(try Day13(input: input).part1().description, "27")
    }

    func testPart2Sample4() throws {
        let input = try testInput("day13-sample-4.txt")
        XCTAssertEqual(try Day13(input: input).part2().description, "21")
    }

    func testPart2() throws {
        let input = try testInput("day13-part-2.txt")
        XCTAssertEqual(try Day13(input: input).part2().description, "147691") 
    }

    func testPart3() throws {
        let input = try testInput("day13-part-3.txt")
        XCTAssertEqual(try Day13(input: input).part3().description, "1105495423496")
    }
}
