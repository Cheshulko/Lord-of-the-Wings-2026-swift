struct Day16: Solution {
    static let day = 16

    let line: [Character]

    init(input: String) {
        line = input.lines.map(Array.init)[0]
    }

    func part1() throws -> any CustomStringConvertible {
        var line = self.line
        var flips = 0
        var i = 0;

        while i < line.count {
            let c = line[i]
            while i + 1 < line.count && line[i + 1] == c {
                i += 1
            }
            if i == line.count {
                break
            }

            var last = i
            for j in (i + 1)..<line.count {
                if line[j] == c {
                    last = j
                }
            }

            if last != i {
                let range = (i + 1)...last
                line[range].reverse()
                flips += 1
            }

            i += 1
        }

        return flips
    }

    func part2() throws -> any CustomStringConvertible {
        var line = Array(repeating: self.line, count: 10).flatMap { $0 }
        var length = 0
        var i = 0;

        while i < line.count {
            let c = line[i]
            while i + 1 < line.count && line[i + 1] == c {
                i += 1
            }
            if i == line.count {
                break
            }

            var last = i
            for j in (i + 1)..<line.count {
                if line[j] == c {
                    last = j
                }
            }

            if last != i {
                let range = (i + 1)...last
                line[range].reverse()
                length += range.count
            }

            i += 1
        }

        return length
    }

    func part3() throws -> any CustomStringConvertible {
        var line = Array(repeating: self.line, count: 100).flatMap { $0 }
        var total = 0

        while let c = line.first {
            let positions = line.indices.filter({ line[$0] == c })
            var a = 0
            var b = positions.count - 1
            var lo = 0
            var hi = positions[b]
            var forward = true

            var pieces: [(range: Range<Int>, forward: Bool)] = [(positions[b] + 1..<line.count, true)]
            while true {
                if forward {
                    while a <= b && positions[a] == lo {
                        lo += 1
                        a += 1
                    }
                    if a > b {
                        break
                    }
                    total += positions[b] - lo + 1
                    pieces.append((positions[b] + 1..<hi + 1, true))
                    hi = positions[b] - 1
                    b -= 1
                } else {
                    while a <= b && positions[b] == hi {
                        hi -= 1
                        b -= 1
                    }
                    if a > b {
                        break
                    }
                    total += hi - positions[a] + 1
                    pieces.append((lo..<positions[a], false))
                    lo = positions[a] + 1
                    a += 1
                }
                forward.toggle()
            }
            pieces.append((lo..<hi + 1, forward))

            var next: [Character] = []
            for (range, forward) in pieces.reversed() {
                if forward {
                    next += line[range]
                } else {
                    next += line[range].reversed()
                }
            }
            line = next
        }

        return total
    }
}