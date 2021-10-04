import Foundation

class Vehicle: Identifiable, ObservableObject {
    let id: String
    let displayVRM: String
    let makeModel: String
    
    @Published var activePolicy: Policy?
    @Published var historicalPolicies: [Policy]
    
    init(id: String, displayVRM: String, makeModel: String, activePolicy: Policy? = nil, historicalPolicies: [Policy] = .init()) {
        self.id = id
        self.displayVRM = displayVRM
        self.makeModel = makeModel
        self._activePolicy = .init(initialValue: activePolicy)
        self._historicalPolicies = .init(wrappedValue: historicalPolicies)
    }
}

extension Vehicle {
    static func getVehicleId(from vrm: String) -> String {
        return vrm.replacingOccurrences(of: " ", with: "")
    }
    
    static func getModel(from vehcicle: JSONEventVehicle) -> String {
        return vehcicle.make + " " + vehcicle.model
    }
}
