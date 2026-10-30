struct Attempt {
    let quest: Int
    let part: Int
    let time: Int
}

struct Day04: Solution {
    static let day = 4

    let attemps: [Int: [Attempt]]

    init(input: String) {
        attemps = input.lines.map({ line in 
            let parts = line.split(whereSeparator: \.isWhitespace)
            let id = Int(parts[0].split(separator: "=")[1])!
            let quest = Int(parts[1].split(separator: "=")[1])!
            let part = Int(parts[2].split(separator: "=")[1])!
            let time = Int(parts[3].split(separator: "=")[1])!

            return (id, Attempt(quest:quest, part:part, time:time))
        }).reduce(into: [Int: [Attempt]](), { attempts, item in 
            let (id, attempt) = item
            attempts[id, default: []].append(attempt)
        })
    }

    func part1() throws -> any CustomStringConvertible {
        return attemps
            .map({ item -> Int in
                item.value.map({ $0.time }).reduce(0, +)
            })
            .sorted()
            .enumerated()
            .map({ $0.element * (1 + $0.offset) })
            .reduce(0, +)
    }

    func part2() throws -> any CustomStringConvertible {
        return attemps
            .map({ item -> (Int, Int) in
                let completed_parts = item.value.count
                return (-completed_parts, item.value.map({ $0.time }).reduce(0, +))
            })
            .sorted(by: <)
            .enumerated()
            .map({ $0.element.1 * (1 + $0.offset) })
            .reduce(0, +)
    }

    func part3() throws -> any CustomStringConvertible {
        typealias Result = (time: Int, score: Int, solved: Int);
        typealias Table = [Int: Result];

        func base(_ part: Int) -> Int {
            switch part {
                case 1: 50
                case 2: 100
                case 3: 150
                default: -1
            }
        }

        func finalise(part: Int, table: inout Table) {
            let base_value = base(part)
            var add = base_value
            var cur_best = -1
            var place = 0
            for (key, row) in table.sorted(by: { $0.value.time < $1.value.time }) where row.solved == part {
                if cur_best != -1 && cur_best != row.time {
                    add = max(base_value - place, 0)
                }
                cur_best = row.time
                table[key]!.score += add
                place += 1
            }
        }

        var (_, part, table) = attemps
            .flatMap({ key, value -> [(Int, Attempt)] in
                value.map({ attempt in (key, attempt) })
            })
            .sorted(by: { ($0.1.quest, $0.1.part) < ($1.1.quest, $1.1.part) })
            .reduce((1, 1, attemps.mapValues({ _ in Result(time: 0, score: 0, solved: 0) })), { (state, item) in
                var (cur_quest, cur_part, table) = state
                let (id, attemp) = item

                if cur_quest != attemp.quest || cur_part != attemp.part {
                    finalise(part: cur_part, table: &table) 
                }

                if cur_quest != attemp.quest {
                    table = table.mapValues({ Result(time: 0, score: $0.score, solved: 0) })
                }

                table[id]!.time += attemp.time
                table[id]!.solved += 1

                return (attemp.quest, attemp.part, table) 
            })

        finalise(part: part, table: &table)

        let scores = table.sorted(by: { $0.value.score > $1.value.score }).map({ $0.value.score })
        var best = -1
        var sum = 0
        var ind = 1
        for (i, score) in scores.enumerated() {
            if best == -1 || score != best {
                best = score
                ind = i + 1
            }
            sum += ind * score
        }

        return sum
    }
}
