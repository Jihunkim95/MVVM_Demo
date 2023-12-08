//
//  ContentView.swift
//  MVVM_Demo
//
//  Created by 김지훈 on 2023/12/08.
//

import SwiftUI

// Model
struct UserData {
    var username: String
    var age: Int
}

// ViewModel
class UserListViewModel: ObservableObject{
    @Published var users: [UserData] = []
    
    func addUser(username: String, age: Int){
        let newUser = UserData(username: username, age: age)
        users.append(newUser)
    }
}

// View
struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    @State private var newUserName:String = ""
    @State private var newUserAge:Int = 0
    
    var body: some View{
        VStack{
            Section(header: Text("사용자 목록").font(.title)){
                Divider()
                List(viewModel.users, id: \.username){ user in
                    HStack{
                        Text("UserName: \(user.username)")
                        Text("UserAge: \(user.age)")
                    }
                }.padding()
            }
            
            HStack{
                Text("사용자")
                TextField("사용자명 입력", text: $newUserName)
                    .padding()
                    .background(.white)
            }
            HStack{
                Text("나이")
                TextField("사용자나이 입력", value: $newUserAge, formatter: NumberFormatter())
                    .padding()
                    .background(.white)
            }
            HStack{
                Button("입력"){
                    viewModel.addUser(username: newUserName, age: newUserAge)
                }
                .padding()
                .foregroundColor(.blue)
            }

        }
        .padding()
        .background(Color(.systemBackground))
        
    }
    
}
#Preview {
    UserListView()
}
