import Algorithms

struct Day19: Solution {
    static let day = 19

    let layer1: [[Character]]
    let layer2: [[Character]]?

    init(input: String) {
        let split = input.split(separator: "\n\n")

        layer1 = String(split[0]).lines.map(Array.init)
        
        if split.count > 1 {
            layer2 = String(split[1]).lines.map(Array.init)
        } else {
            layer2 = nil
        }
    }

    func part1() throws -> any CustomStringConvertible {
        let n = layer1.count
        let m = layer1[0].count

        var cnt: [String: Int] = [:]
        for i in 0..<n {
            for j in 0..<m {
                if layer1[i][j] == layer2![i][j] {
                    cnt[String(layer1[i][j]), default: 0] += 1
                    continue
                }

                let color = switch (layer1[i][j], layer2![i][j]) {
                    case ("C", "M"): "B"
                    case ("M", "C"): "B"

                    case ("C", "Y"): "G"
                    case ("Y", "C"): "G"

                    case ("M", "Y"): "R"
                    case ("Y", "M"): "R"

                    default: "K"
                }

                cnt[color, default: 0] += 1
            }
        }

        return cnt.values.sorted(by: >).prefix(3).reduce(1, *)
    }

    func part2() throws -> any CustomStringConvertible {
        let n = layer1.count
        let m = layer1[0].count

        var ma = 0
        for order: [Character] in ["M", "C", "Y", "K"].permutations() {
            var cnt: [String: Int] = [:]
            for i in 0..<n {
                for j in 0..<m {
                    let y = order[Int(String(layer2![i][j]))! - 1]

                    if layer1[i][j] == y {
                        cnt[String(layer1[i][j]), default: 0] += 1
                        continue
                    }

                    let color = switch (layer1[i][j], y) {
                        case ("C", "M"): "B"
                        case ("M", "C"): "B"

                        case ("C", "Y"): "G"
                        case ("Y", "C"): "G"

                        case ("M", "Y"): "R"
                        case ("Y", "M"): "R"

                        default: "K"
                    }

                    cnt[color, default: 0] += 1
                }
            }

            ma = max(ma, cnt.values.sorted(by: >).prefix(3).reduce(1, *))
        }

        return ma
    }

    func part3() throws -> any CustomStringConvertible {
        let options: [Character: [Character]] = [
            "C": ["C", "B", "G"],
            "M": ["M", "B", "R"],
            "Y": ["Y", "G", "R"],
            "K": ["K"],
        ]
        let count = Dictionary(layer1.joined().map({ ($0, 1) }), uniquingKeysWith: +)

        func can(_ colours: [Character]) -> Int {
            count.filter({ options[$0.key]!.contains(where: colours.contains) }).values.reduce(0, +)
        }

        var best = 0
        for colours in Array("CMYBGRK").combinations(ofCount: 3) {
            let (a, b, c) = (colours[0], colours[1], colours[2])
            let total = can([a, b, c])
            let (can_a, can_b, can_c) = (can([a]), can([b]), can([c]))
            let (can_ab, can_ac, can_bc) = (can([a, b]), can([a, c]), can([b, c]))

            for to_a in 0...can_a {
                if total - to_a > can_bc {
                    continue
                }

                let min_b = max(
                    0,
                    total - to_a - can_c,  // to_c <= can_c
                    total - can_ac         // to_a + to_c <= can_ac
                )
                let max_b = min(
                    can_b,                 // to_b <= can_b
                    can_ab - to_a          // to_a + to_b <= can_ab
                )
                if min_b > max_b {
                    continue
                }

                for half in [(total - to_a) / 2, (total - to_a + 1) / 2] {
                    let to_b = min(max(half, min_b), max_b)
                    let to_c = total - to_a - to_b
                    best = max(best, to_a * to_b * to_c)
                }
            }
        }

        return best
    }
}