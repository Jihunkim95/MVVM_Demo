# MVVM_Demo
MVVVM 패턴 단순 예제
사용자, 나이 입력시 List결과 반환

## 시뮬예시
사용자 이름, 나이를 입력하면 List에 보이는 앱

<img src="https://velog.velcdn.com/images/darak551/post/89ecd894-dd67-4084-a1ac-ea380bcab5e8/image.png" width="200" height="300"/>

![](https://velog.velcdn.com/images/darak551/post/2c74f948-4066-4ba0-b95b-391d8b1f73da/image.png)


## MVVM 패턴 왜 사용해야할까?
1. SwiftUI 개발시 애플 권장
2. View, ViewModel, Model 각각 기능 별로 사용됨

![](https://velog.velcdn.com/images/darak551/post/f9750916-1d1e-43cf-9364-6e9f68f8630e/image.png)

## MVVM 패턴이란 ?
### 모델(Model)

데이터, 네트워크 로직, 비즈니스 로직등을 담으며 데이터를 캡슐화하는 역할을 맡고 있다.

View, ViewModel에 대한 신경은 쓰지 않는다. 데이터를 어떻게 가지고 있을지만 걱정하며, 데이터가 어떻게 보여질 것인지에 대해서는 고려하지 않는다.

→ MVC의 Model과 크게 다르지 않다.

### ViewModel

View로부터 전달받는 요청을 처리할 로직을 담고 있으며 Model에 변화가 생기면 View에 notification을 보낸다. (데이터의 변화를 View가 알아챌 수 있도록 한다고 생각하면 된다)

ViewModel은 View와 Model 사이의 중개자 역할을 하며 Presentation Logic을 처리하는 역할을 한다.

중간 다리의 역할을 한다는 점에서 MVC의 Controller와 유사하다고 볼 수도 있다.
#### Presentation Logic이란?
일반적으로 ViewModel은 Model 클래스의 메서드를 호출하여 Model과 상호 작용한다. 그런 다음 ViewModel은 Model의 데이터를 가져오고, View가 쉽게 사용할 수 있는 형태로 가공하여 제공한다.

ex) View가 데이터를 더 쉽게 처리할 수 있도록(보여줄 수 있도록) 데이터 형식을 다시 지정 (formatting), Xml 파싱, Json파싱

### View
1. 사용자가 보는 화면
2. Model을 직접 알고 있어서는 안된다.

## 예시 프로세스

### 1.Model 설정
```swift
struct UserData {
    var username: String
    var age: Int
}

```
### 2.ViewModel 설정
```swift
class UserListViewModel: ObservableObject{
    @Published var users: [UserData] = []
    
    func addUser(username: String, age: Int){
        let newUser = UserData(username: username, age: age)
        users.append(newUser)
    }
}
```
### 3.View 설정
```swift
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

```

