struct Plant {
    let id: Int
    let growth: Int
    let limit: Int
}

struct Segment {
    let id: Int
    let parent_segment_id: Int?
    var size: Int

    init(id: Int, size: Int, parent_segment_id: Int? = nil) {
        self.id = id
        self.parent_segment_id = parent_segment_id
        self.size = size
    }

    mutating func tick() -> Int {
        self.size += 1
        
        return self.size
    }

    mutating func branch(left_segment_id: Int, right_segment_id: Int) {
        assert(self.size % 2 == 1)
        self.size = 1
    }
}

struct Tree {
    let plant: Plant

    var size: Int
    var segments: [Segment]

    init(plant: Plant) {
        self.plant = plant
        size = 0
        segments = []
    }

    mutating func tick() {
        if segments.isEmpty {
            size = 1
            assert(segments.count == 0)
            let id = segments.count
            segments.append(Segment(id: id, size: 1))

            return
        }

        var to_append: [Segment] = []
        for i in segments.indices {
            if segments[i].tick() == plant.growth {
                assert(segments[i].size % 2 == 1)
                let new_size = segments[i].size / 2;

                let new_left = Segment(id: to_append.count + segments.count, size: new_size, parent_segment_id: segments[i].id)
                let new_right = Segment(id: to_append.count + segments.count + 1, size: new_size, parent_segment_id: segments[i].id)

                segments[i].branch(left_segment_id: new_left.id, right_segment_id: new_right.id)

                self.size += 2
                to_append.append(new_left)
                to_append.append(new_right)
            } else {
                self.size += 1
            }
        }

        segments.append(contentsOf: to_append)
    }
}

struct Day09: Solution {
    static let day = 9

    let plants: [Plant]

    init(input: String) {
        plants = input.lines.map({ line in
            let split = line.split(whereSeparator: \.isWhitespace)
            let id = Int(split[0].dropLast().split(separator: "=")[1])!
            let growth = Int(split[1].dropLast().split(separator: "=")[1])!
            let limit = Int(split[2].split(separator: "=")[1])!

            return Plant(id: id, growth: growth, limit: limit)
        })
    }

    func part1() throws -> any CustomStringConvertible {
        plants.map({ plant in 
            var tree = Tree(plant: plant)

            var secs = 0
            while tree.size < tree.plant.limit {
                tree.tick()
                secs += 1
            }

            return secs
        }).reduce(0, +)
    }    

    func part2() throws -> any CustomStringConvertible {
        plants.map({ plant in 
            var tree = Tree(plant: plant)

            var secs = 0
            while (tree.segments.count + 1) / 2 < tree.plant.limit {
                tree.tick()
                secs += 1
            }

            return secs
        }).reduce(0, +)
    }

    func math(plant: Plant) -> Int {
        let MAX = 65
        
        let need = plant.limit - 1
        if need <= 0 {
            return 1
        }

        let h = plant.growth / 2
        var counts = Array(repeating: Array(repeating: 0, count: MAX), count: MAX)
        var events: [(time: Int, count: Int)] = []
        for n in 0..<MAX {
            for k in 0..<MAX {
                var count = 0;
                if n == 0 && k == 0 {
                    count = 1
                } else {
                    count = (k > 0 ? counts[n][k - 1] : 0) + (n > 0 ? 2 * counts[n - 1][k] : 0)
                }
                counts[n][k] = min(count, need)
                events.append((time: 1 + 2 * h * (1 + k) + n * (h + 1), count: counts[n][k]))
            }
        }

        var branched = 0
        for event in events.sorted(by: { $0.time < $1.time }) {
            branched += event.count
            if branched >= need {
                return event.time
            }
        }

        preconditionFailure()
    }

    func part3() throws -> any CustomStringConvertible {
        plants.map({ math(plant: $0) }).reduce(0, +)
    }
}