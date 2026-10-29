enum Registry {
    static let all: [any Solution.Type] = [
        Day01.self,
        Day02.self,
        Day03.self,
    ]

    static func solution(for day: Int) -> (any Solution.Type)? {
        all.first { $0.day == day }
    }
}
