import Foundation
import FirebaseAnalytics
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var comment: String = ""
    @Published var manualConnectionPoint: String = ""
    @Published var alertItem: AlertItem?
    
    private let networkManager = NetworkManager.shared
    
    func sendEvent() {
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            self.alertItem = AlertItem(title: "Error", message: "Пожалуйста, введите имя")
            return
        }
        
        if manualConnectionPoint.trimmingCharacters(in: .whitespaces).isEmpty {
            self.alertItem = AlertItem(title: "Error", message: "Пожалуйста, укажите точку подключения (название сети)")
            return
        }
        
        let simStatus = networkManager.getSimStatus()
        let isMobileData = networkManager.isMobileDataEnabled()
        
        Analytics.logEvent("manual_network_test", parameters: [
            "user_name": name,
            "user_comment": comment,
            "connection_point_name": manualConnectionPoint,
            "sim_present": simStatus,
            "mobile_data_enabled": isMobileData ? "true" : "false",
            "platform": "iOS",
            "verification_method": "manual_input"
        ])
        
        self.alertItem = AlertItem(
            title: "Отправлено",
            message: "Данные о подключении к '\(manualConnectionPoint)' отправлены."
        )
    }
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
}
