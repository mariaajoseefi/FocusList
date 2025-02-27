//
//  ContentView.swift
//  FocusList
//
//  Created by majo on 06/02/25.
//

import SwiftUI

// modelo de datos
struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

// main content view
struct ContentView: View {
    @State private var tasks: [Task] = [] // array para guardar las tareas
    @State private var newTaskTitle: String = "" // input para texto
    
    var body: some View {
        NavigationView {
            VStack {
                // input para agregar nuevas tareas
                HStack {
                    TextField("Agregar una nueva tarea", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing)
                }
                .padding()
                
                // lista para ver las tareas
                List {
                    ForEach(tasks) { task in
                        TaskRow(task: task, toggleCompletion: toggleTaskCompletion)
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Lista de Tareas")
        }
    }
    
    // función para agregar una tarea
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        tasks.append(Task(title: newTaskTitle, isCompleted: false))
        newTaskTitle = "" // texto en blanco después de agregar una tarea
    }
    
    // función para cambiar el estado de una tarea
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id}) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    // función para eliminar una tarea
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

// fila para mostrar las tarea individuales
struct TaskRow: View {
    let task: Task
    var toggleCompletion: (Task) -> Void
    
    var body: some View {
        HStack {
            Text(task.title)
                .strikethrough(task.isCompleted, color: .gray)
                .foregroundColor(task.isCompleted ? .gray : .black)
            Spacer()
            Button(action: { toggleCompletion(task) }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .blue)
            }
        }
        .padding(.vertical, 4)
    }
}

// preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
