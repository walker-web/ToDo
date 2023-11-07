//
//  AddTodo View.swift
//  ToDo App
//
//  Created by Ashish on 29/11/21.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("ToDo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    Picker("Priorities", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    } // PICKER
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if self.name != "" {
                            let todo = Item(context: self.viewContext)
                            todo.priority = self.priority
                            todo.name = self.name
                            
                            do {
                                try self.viewContext.save()
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Empty Textfield"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                           , label: {
                        Text("Save")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                            
                    })
                    
                } // VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
            } // VSTACK
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })
                                    .alert(isPresented: $errorShowing, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
            )
        } //: NAVIGATION
    }
}

struct AddTodo_View_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
