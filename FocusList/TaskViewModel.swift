//
//  TaskViewModel.swift
//  FocusList
//
//  Created by majo on 23/04/26.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var newTaskTitle: String = ""
    
    // add task with validation
    func addTask() {
        guard !newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let task = Task(title: newTaskTitle, isCompleted: false)
        tasks.append(task)
        newTaskTitle = ""
    }
    
    // toggle task completion
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    // delete task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
