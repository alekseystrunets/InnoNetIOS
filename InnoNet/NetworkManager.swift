import Foundation
import CoreTelephony
import Network
import Combine

class NetworkManager: NSObject, ObservableObject {
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    private var isCellularActive = false
    
    override init() {
        super.init()
        monitor.pathUpdateHandler = { path in
            self.isCellularActive = path.usesInterfaceType(.cellular)
        }
        monitor.start(queue: DispatchQueue.global())
    }
    
    func getSimStatus() -> String {
        #if targetEnvironment(simulator)
        return "No SIM (Simulator)"
        #else
        let info = CTTelephonyNetworkInfo()
        if let providers = info.serviceSubscriberCellularProviders, !providers.isEmpty {
            return "SIM Ready"
        }
        return "No SIM"
        #endif
    }
    
    func isMobileDataEnabled() -> Bool {
        return isCellularActive
    }
}
