typealias Id = Int

struct Node {
    let id: Id
    let energy: Int
    let outIds: [Id]
}

struct Day07: Solution {
    static let day = 7

    let nodes: [Node]
    let idToIndex: [Id: Int]

    init(input: String) {
        nodes = input.lines.map({ line in
            let split = line.split(whereSeparator: \.isWhitespace)
            let id = Id(split[0].dropLast().split(separator: "=")[1])!
            let energy = Id(split[1].dropLast().split(separator: "=")[1])!
            let outIds = split[2].split(separator: "=")[1].split(separator: ",").map({ Int($0)! })

            return Node(id: id, energy: energy, outIds: outIds)
        })

        idToIndex = Dictionary(uniqueKeysWithValues: nodes.enumerated().map({ ($0.element.id, $0.offset) }))
    }

    func bfs(node: Node, start_impulse: Int, explosion_on: Int? = nil) -> [Id: Int] {
        var clouds: [Id: [Int: Int]] = [:]
        var seen: [Id: Int] = Dictionary(uniqueKeysWithValues: nodes.map({ ($0.id, $0.energy) }))

        clouds[node.id] = [start_impulse: 1]

        var exploded_list: Set<Id> = []
        while !clouds.isEmpty {
            let ids = clouds

            clouds = [:]

            for (id, var impulses) in ids where !exploded_list.contains(id) {
                for (impulse, count) in impulses {
                    seen[id, default: 0] += impulse * count   
                }

                if let explosion_on = explosion_on, seen[id, default: 0] >= explosion_on {
                    seen[id, default: 0] = 0
                    exploded_list.insert(id)
                    impulses[11, default: 0] += 1
                }           

                let index = idToIndex[id]!
                for to in nodes[index].outIds where !exploded_list.contains(to) {
                    for (impulse, count) in impulses where impulse > 1 {
                        clouds[to, default: [:]][impulse - 1, default: 0] += count
                    }
                }
            }
        }
        
        return seen
    }

    func part1() throws -> any CustomStringConvertible {
        let start = nodes.max(by: { $0.outIds.count < $1.outIds.count })!

        return bfs(node: start, start_impulse: 5).values.reduce(0, +)
    }

    func part2() throws -> any CustomStringConvertible {
        let start = nodes.max(by: { $0.outIds.count < $1.outIds.count })!

        return bfs(node: start, start_impulse: 10).values.reduce(0, +)
    }

    func part3_sample() throws -> CustomStringConvertible {
        nodes.map({ node in 
            bfs(node: node, start_impulse: 10, explosion_on: 100).values.reduce(0, +)
        }).max() ?? 0
    }

    func part3() throws -> any CustomStringConvertible {
        nodes.map({ node in 
            bfs(node: node, start_impulse: 10, explosion_on: 1000000).values.reduce(0, +)
        }).max() ?? 0
    }
}