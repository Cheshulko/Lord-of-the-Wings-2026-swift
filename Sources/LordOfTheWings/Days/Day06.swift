import Collections

struct Day06: Solution {
    typealias Graph = [String: [String]]

    static let day = 6

    let n: Int
    let graph: Graph

    init(input: String) {
        n = input.lines.count
        graph = input.lines.map({ line -> (String, [String]) in  
            let split = line.split(separator: ":")
            let (item, rest) = (String(split[0]), split[1])
            let ingredients = rest.split(separator: ",").map(String.init)

            return (item, ingredients)
        }).reduce(into: Graph(), { graph, it in 
            let (item, ingredients) = it

            graph[item, default: []].append(contentsOf: ingredients)
        })
    }

    func dfs(cur: String, graph: Graph, acc: inout Set<String>) {
        acc.insert(cur)

        for to in graph[cur] ?? [] where !acc.contains(to){
            dfs(cur: to, graph: graph, acc: &acc)
        }
    }

    func reversed() -> Graph {
        var rev = Graph()
        for (item, ingredients) in graph {
            for to in ingredients {
                rev[to, default: []].append(item)
            }
        }

        return rev
    }

    func part1() throws -> any CustomStringConvertible {
        var ans: Set<String> = []

        dfs(cur: "NULL", graph: self.graph, acc: &ans)

        return ans.count - 1
    }

    func part2() throws -> any CustomStringConvertible {
        var ans: Set<String> = []

        dfs(cur: "NULL", graph: reversed(), acc: &ans)

        return ans.count - 1
    }

    func part3() throws -> any CustomStringConvertible {
        let nulls = Set(graph.keys).union(graph.values.joined()).filter({ $0.hasPrefix("NULL") })
        let reversed_graph = reversed()

        var count: [String: Int] = [:]
        for null in nulls {
            var ans: Set<String> = []
            dfs(cur: null, graph: reversed_graph, acc: &ans)

            count.merge(ans.map({ ($0, 1) }), uniquingKeysWith: +)
        }

        return count.filter({ !$0.key.hasPrefix("NULL") }).filter({ $0.value > 1}).count
    }
}