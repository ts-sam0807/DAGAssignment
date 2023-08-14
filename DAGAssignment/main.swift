//
//  main.swift
//  DAGAssignment
//
//  Created by Ts SaM on 14/8/2023.
//

import Foundation

// https://leetcode.com/problems/course-schedule/
func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var graph = [[Int]](repeating: [Int](), count: numCourses)
    var visited = [Bool](repeating: false, count: numCourses)
    var visiting = [Bool](repeating: false, count: numCourses)
    
    for edge in prerequisites {
        let course = edge[0]
        let prerequisite = edge[1]
//        print(prerequisite)
        graph[course].append(prerequisite)
    }
    
    func dfs(_ course: Int) -> Bool {
//        print("course: \(course)")
        if visiting[course] {
            return false
        }
        if visited[course] {
            return true
        }
        
        visiting[course] = true
        
        for prerequisite in graph[course] {
            if !dfs(prerequisite) {
                return false
            }
        }
        
        visiting[course] = false
        visited[course] = true
        
        return true
    }
    
    for course in 0..<numCourses {
        if !dfs(course) {
            return false
        }
    }
    
    return true
}



// https://leetcode.com/problems/course-schedule-ii/
func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
    var graph = [[Int]](repeating: [Int](), count: numCourses)
    var inDegree = [Int](repeating: 0, count: numCourses)
    var order = [Int]()
    
    for edge in prerequisites {
//        print("edge : \(edge)")
        let course = edge[0]
        let prerequisite = edge[1]
        graph[prerequisite].append(course)
        inDegree[course] += 1
    }
    
    var queue = [Int]()
    
    for course in 0..<numCourses {
        if inDegree[course] == 0 {
            queue.append(course)
        }
    }
    
    while !queue.isEmpty {
        let course = queue.removeFirst()
        
        order.append(course)
        
        for nextCourse in graph[course] {
//            print("nextCourse : \(nextCourse)")
            inDegree[nextCourse] -= 1
            
            if inDegree[nextCourse] == 0 {
                queue.append(nextCourse)
            }
        }
    }
    
    return order.count == numCourses ? order : []
}
