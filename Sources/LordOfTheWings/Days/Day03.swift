struct Day03: Solution {
    static let day = 3

    typealias Vote = (base: Int, value: Int)

    let votes: [Vote]

    init(input: String) {
        votes = input.lines.map({ line in 
            let parts = line.split(whereSeparator: \.isWhitespace)
            let base = parts[0].split(separator: "-")[1]

            return (base: Int(base)!, value: Int(parts[1])!)
        })
    }

    func bin_pow(_ base: Int, _ exp: Int) -> Int {
        if exp == 0 {
            return 1
        }
        if base == 0 {
            return 0
        }

        let r = bin_pow(base, exp / 2)

        return exp % 2 == 0 ? r * r : r * r * base
    }

    func calc(_ vote: Vote) -> Int {
        var (base, value) = vote
        var sum = 0
        var ind = 0;

        while value > 0 {
            if base == 0 {
                base = vote.base
            }
            let p = base % 10
            let v = value % 10
            base /= 10
            value /= 10

            sum += bin_pow(p, ind) * v
            ind += 1
        }

        return sum
    }

    func part1() throws -> any CustomStringConvertible {
        votes.lazy.map(calc).reduce(0, +)
    }

    func part2() throws -> any CustomStringConvertible {
        try part1()
    }

    func part3() throws -> any CustomStringConvertible {
        votes.lazy
            .compactMap({ vote in 
                let result = calc(vote)
                let (base, value) = vote 
                
                if (0..<value).contains(where: { cand in calc((base, cand)) == result}) {
                    return nil
                } else {
                    return result
                }
            })
            .reduce(0, +)
    }
}
