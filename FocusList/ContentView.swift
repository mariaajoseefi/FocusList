//
//  ContentView.swift
//  FocusList
//
//  Created by majo on 06/02/25.
//

import SwiftUI

// TaskModel
struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
    var createdDate: Date = Date()
    var priority: Priority = .medium
    
    enum Priority: String, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        
        var color: Color {
            switch self {
            case .low: return .green
            case .medium: return .yellow
            case .high: return .red
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showAddTask = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.tasks.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.tasks) { task in
                            TaskRow(
                                task: task,
                                toggleCompletion: viewModel.toggleTaskCompletion
                            )
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("FocusList")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showAddTask = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddTask) {
                AddTaskView(viewModel: viewModel, isPresented: $showAddTask)
            }
        }
    }
}

// improve TaskRow with priority indicator
struct TaskRow: View {
    let task: Task
    var toggleCompletion: (Task) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Checkbox button
            Button(action: { toggleCompletion(task) }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundColor(task.isCompleted ? .green : .blue)
            }
            
            // task title
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .strikethrough(task.isCompleted, color: .gray)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
                
                // priority badge
                Text(task.priority.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(task.priority.color.opacity(0.2))
                    .foregroundColor(task.priority.color)
                    .cornerRadius(4)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
