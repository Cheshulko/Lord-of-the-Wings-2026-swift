struct Hand {
    let hand: Int
    let direction: Int
    
    var current: Int
    var moves: Int
}

struct Day13: Solution {
    static let day = 13

    let clocks: [[Hand]]

    init(input: String) {
        clocks = input.split(separator: "\n\n").map({ Day13.parseClock(String($0).lines) })
    }

    static func parseClock(_ lines: [String]) -> [Hand] {
        let hands_str = lines[0].split(whereSeparator: \.isWhitespace)[1]
        let hands_ = hands_str.split(separator: ":").map({ Int($0)! })

        let direction_str = lines[1].split(whereSeparator: \.isWhitespace)[1]
        let direction_ = direction_str.split(separator: ":").map({ $0 == "CW" ? 1 : -1 })

        let current_str = lines[2].split(whereSeparator: \.isWhitespace)[1]
        let current_ = current_str.split(separator: ":").map({ Int($0)! })

        let move_str = lines[3].split(whereSeparator: \.isWhitespace)[1]
        let move_ = move_str.split(separator: ":").map({ Int($0)! })

        return zip(zip(hands_, direction_), zip(current_, move_)).map({ hd, cm in
            return Hand(hand: hd.0, direction: hd.1, current: cm.0, moves: cm.1)
        })
    }

    func signals(_ hands: [Hand]) -> Int {
        var ans = 0

        let n = hands.count
        for hand_id_1 in 0..<n {
            for hand_id_2 in (hand_id_1 + 1)..<n {
                ans += meetings(hands[hand_id_1], hands[hand_id_2])
            }
        }

        return ans
    }

    func meetings(_ h1: Hand, _ h2: Hand) -> Int {
        func gcd(_ a: Int, _ b: Int) -> Int { b == 0 ? a : gcd(b, a % b) }
        func floorDiv(_ a: Int, _ b: Int) -> Int { a >= 0 ? a / b : -((-a + b - 1) / b) }

        let l = h1.hand / gcd(h1.hand, h2.hand) * h2.hand
        let step1 = l / h1.hand
        let step2 = l / h2.hand

        func angle(_ h: Hand, _ step: Int, _ t: Int) -> Int {
            h.current * step + h.direction * step * min(t, h.moves)
        }

        let stops = Set([0, h1.moves, h2.moves]).sorted()

        var count = 0
        for (t0, t1) in zip(stops, stops.dropFirst()) {
            let d0 = angle(h1, step1, t0) - angle(h2, step2, t0)
            let d1 = angle(h1, step1, t1) - angle(h2, step2, t1)

            if d1 > d0 {
                count += floorDiv(d1, l) - floorDiv(d0, l)
            } else if d1 < d0 {
                count += floorDiv(d0 - 1, l) - floorDiv(d1 - 1, l)
            }
        }

        return count
    }

    func part1() throws -> any CustomStringConvertible {
        return signals(clocks[0])
    }

    func part2() throws -> any CustomStringConvertible {
        return clocks.map(signals).reduce(0, +)
    }

    func part3() throws -> any CustomStringConvertible {
        return try part2()
    }
}