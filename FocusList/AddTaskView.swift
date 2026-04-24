//
//  AddTaskView.swift
//  FocusList
//
//  Created by majo on 23/04/26.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var isPresented: Bool
    @State private var selectedPriority: Task.Priority = .medium
    
    var isFormValid: Bool {
        !viewModel.newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Task Title") {
                    TextField("What needs to be done?", text: $viewModel.newTaskTitle)
                }
                
                Section("Priority") {
                    Picker("Priority", selection: $selectedPriority) {
                        ForEach(Task.Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue).tag(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        viewModel.newTaskTitle = ""
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        viewModel.addTask()
                        isPresented = false
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel(), isPresented: .constant(false))
}
