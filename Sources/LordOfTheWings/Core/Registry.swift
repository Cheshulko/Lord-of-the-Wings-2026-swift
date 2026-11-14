enum Registry {
    static let all: [any Solution.Type] = [
        Day01.self,
        Day02.self,
        Day03.self,
        Day04.self,
        Day05.self,
        Day06.self,
        Day07.self,
        Day08.self,
        Day09.self,
        Day10.self,
        Day11.self,
        Day12.self,
        Day13.self,
        Day14.self,
        Day15.self,
    ]

    static func solution(for day: Int) -> (any Solution.Type)? {
        all.first { $0.day == day }
    }
}
