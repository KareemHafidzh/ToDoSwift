//
//  AddTodoView.swift
//  TodoSwiftUI
//
//  Created by Kareem Abdul Hafidzh on 15/02/21.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var priority: String = "normal"
    
    @State private var  showingError : Bool = false
    @State private var  errorTitle: String = ""
    @State private var errorMessege:String = ""
    
    let priorities = ["High","Normal","Low"]
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading,spacing:20){
                    TextField("todo",text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size:24,weight: .bold,design: .default))
                    
                    Picker("priority" , selection: $priority){
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Button(action: {
                    if self.name != ""{
                        let todo = Todo(context: self.managedObjectContext)
                        todo.name = self.name
                        todo.priority = self.priority
                        
                        do{
                            try self.managedObjectContext.save()
                            print("new todo :  \(todo.name ?? ""), priority :\(todo.priority ?? "") ")
                        }catch{
                            print(error)
                        }
                    }else{
                        self.showingError = true
                        self.errorTitle = "invalid name"
                        self.errorMessege = "isi bagian yang kosong"
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("save")
                        .font(.system(size:24,weight:.bold,design: .default))
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(9)
                        .foregroundColor(Color.white)
                }
            }
            .padding(.horizontal)
            .padding(.vertical,30)
            Spacer()
        }
        .navigationBarTitle("NewTodo",displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "xmark")
                                }
        ).alert(isPresented: $showingError){
            Alert(title: Text(errorTitle),message: Text(errorMessege),dismissButton: .default(Text("ok")))
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
