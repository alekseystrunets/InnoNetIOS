import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                Text("Network Testing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Text("ВАЖНО: Обязательно проверьте в настройках, что вы подключены к нужной Wi-Fi сети!")
                    .font(.headline)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer().frame(height: 10)
                
                VStack(alignment: .leading) {
                    Text("Ваше Имя")
                        .font(.caption).foregroundColor(.gray)
                    TextField("Имя Фамилия", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Название сети / Точка подключения")
                        .font(.caption).foregroundColor(.gray)
                    TextField("Например: Inno-Warsaw", text: $viewModel.manualConnectionPoint)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Комментарий")
                        .font(.caption).foregroundColor(.gray)
                    TextField("Важная информация", text: $viewModel.comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Spacer().frame(height: 30)
                
                Button(action: {
                    hideKeyboard()
                    viewModel.sendEvent()
                }) {
                    Text("Отправить")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(24)
        }
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("OK")))
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
