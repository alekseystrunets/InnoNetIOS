import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Text("Network Testing")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        Image(systemName: "wifi.exclamationmark")
                            .foregroundColor(.red)
                        Text("ВАЖНО: Подключитесь к той сети Wi-Fi, на которой у вас рабочий проект!")
                            .font(.headline)
                            .foregroundColor(.red)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Divider().background(Color.red.opacity(0.3))
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("• Сделайте от 5 до 10 замеров (событий).")
                        Text("• Тестируйте на рабочих И личных устройствах.")
                        Text("• Перемещайтесь по офису для разброса данных.")
                    }
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.8))
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                )
                
                Spacer().frame(height: 10)
                
                VStack(alignment: .leading) {
                    Text("Ваше Имя")
                        .font(.caption).foregroundColor(.gray)
                    TextField("Имя Фамилия (как в HRM, RU/eng)", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Название сети / Точка подключения")
                        .font(.caption).foregroundColor(.gray)
                    TextField("Введите имя сети (напр. Inno-Warsaw)", text: $viewModel.manualConnectionPoint)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Важная информация")
                        .font(.caption).foregroundColor(.gray)
                    TextField("Устройство (Личный/Раб), этаж, комната", text: $viewModel.comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Spacer().frame(height: 20)
                
                Button(action: {
                    hideKeyboard()
                    viewModel.sendEvent()
                }) {
                    Text("Отправить событие")
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
