//
//  TaskModel.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 29.11.2024.
//

import Foundation

struct TaskModel: Identifiable, Codable, Hashable {
    private(set) var id = UUID().uuidString
    private(set) var dateFinished: Date?
    
    var name, description: String
    var deadline: Date
    var priority, executionTime, status: Int
    
    init(name: String, description: String, deadline: Date, priority: Int, executionTime: Int, status: Int) {
        self.name = name
        self.description = description
        self.deadline = deadline
        self.priority = priority
        self.executionTime = executionTime
        self.status = status
    }
    
    var executedHours: Int {
        guard let dateFinished else { return 0 }
        let differenceInHours = Date.differenceBetweenDates(from: .init(),
                                                            to: dateFinished,
                                                            component: .hour) ?? .zero
        
        return executionTime - differenceInHours
    }
    
    var executedMinutes: Int {
        guard let dateFinished else { return 0 }
        let differenceInMinutes = Date.differenceBetweenDates(from: .init(),
                                                            to: dateFinished,
                                                            component: .minute) ?? 0
        
        return (executionTime * 60) - differenceInMinutes
    }
    
    mutating func startExecution() {
        dateFinished = Date().addOrSubtract(component: .hour, value: executionTime)
        status = TaskStatus.inProgress.rawValue
    }
    
    mutating func stopExecution(with status: TaskStatus) {
        dateFinished = nil
        self.status = status.rawValue
    }
}

enum TaskPriority: Int, CaseIterable {
    case low = 0
    case regular = 1
    case high = 2
    
    var description: String {
        switch self {
        case .low:
            return "Niski"
        case .regular:
            return "Średni"
        case .high:
            return "Wysoki"
        }
    }
}

enum TaskStatus: Int {
    case prepared = 0
    case inProgress = 1
    case finished = 2
    
    var description: String {
        switch self {
        case .prepared:
            return "Nie rozpoczęto"
        case .inProgress:
            return "W toku"
        case .finished:
            return "Zakończono"
        }
    }
}
