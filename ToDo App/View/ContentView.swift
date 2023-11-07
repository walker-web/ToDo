//
//  ContentView.swift
//  ToDo App
//
//  Created by Ashish on 29/11/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var showingSettingsView: Bool = false
    @State private var showingAddToDoView: Bool = false
    @State private var animatingButton: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.items, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                        }
                    } //FOREACH
                    .onDelete(perform: deleteItems)
                } // LIST
                .navigationBarTitle("ToDo", displayMode: .inline)
                .navigationBarItems(
                leading: EditButton(),
                trailing:
                Button(action: {
                    self.showingSettingsView.toggle()
                }, label: {
                    Image(systemName: "paintbrush")
                        .imageScale(.large)
                })
                    .sheet(isPresented: $showingSettingsView) {
                    SettingsView()
                }
            )
                
                if items.count == 0 {
                    EmptyListView()
                }
                
            } // ZSTACK
            .sheet(isPresented: $showingAddToDoView) {
            AddTodoView().environment(\.managedObjectContext, self.viewContext)
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    } // GROUP
//                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true))

                    Button(action: {
                        self.showingAddToDoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                } // ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                   , alignment: .bottomTrailing
            )
        } // NAVIGATION
    }

    //  MARK: - FUNCTIONS
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
