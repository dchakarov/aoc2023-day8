//
//  main.swift
//  No rights reserved.
//

import Foundation

struct Node {
    let left: String
    let right: String
}

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    var lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    let ins = lines.removeFirst()
    let instructions = Array(ins)
    let search = /(?<node>\w{3})\s{1}=\s{1}\((?<left>\w{3}),\s{1}(?<right>\w{3})\)/
    
    var nodes = [String: Node]()
    
    lines.forEach { line in
        if let result = try? search.wholeMatch(in: line) {
            nodes[String(result.node)] =
            Node(
                left: String(result.left),
                right: String(result.right)
            )
        }
    }
    
//    part1(instructions: instructions, nodes: nodes)
    part2(instructions: instructions, nodes: nodes)
}

func part1(instructions: [String.Element], nodes: [String: Node]) {
    var currentInstructionIndex = 0
    var currentNode = "AAA"
    var moves = 0
    
    while currentNode != "ZZZ" {
        if instructions[currentInstructionIndex] == "R" {
            currentNode = nodes[currentNode]!.right
        } else {
            currentNode = nodes[currentNode]!.left
        }
        currentInstructionIndex += 1
        if currentInstructionIndex == instructions.count {
            currentInstructionIndex = 0
        }
        moves += 1
    }
    
    print(moves)
}

func part2(instructions: [String.Element], nodes: [String: Node]) {
    var currentInstructionIndex = 0
    var currentNodes = nodes.keys.filter { $0.hasSuffix("A") }.map { String($0) }
    var oneNode = currentNodes[0]
    var moves = 0
    
    while !currentNodes.allSatisfy({ $0.hasSuffix("Z") }) {
        if instructions[currentInstructionIndex] == "R" {
            currentNodes = currentNodes.map { nodes[$0]!.right }
        } else {
            currentNodes = currentNodes.map { nodes[$0]!.left }
        }
        if currentNodes[2].hasSuffix("Z") {
            print("zzz found (\(currentNodes[2]) moves: \(moves))")
        }
        currentInstructionIndex += 1
        if currentInstructionIndex == instructions.count {
            currentInstructionIndex = 0
//            print("restarting (moves: \(moves))")
        }
        moves += 1
    }
    
    print(moves)
}

main()
