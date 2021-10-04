import Foundation

class LivePolicyEventProcessor: PolicyEventProcessor {
    
    func store(json: JSONResponse) {
        self.cachedJsonResponse = json
    }
    
    func retrieve(for: Date) -> PolicyData? {
        // vehicles
        guard let vehicles = getUniqueVehicles(from: cachedJsonResponse) else { return nil }

        // Policy
        let activePolicy = Policy(
            id: UUID().uuidString,
            term: .init(startDate: .distantPast, duration: Date.distantPast.distance(to: .distantFuture)),
            vehicle: vehicles[0]
        )
        
        vehicles[0].activePolicy = activePolicy
        
        vehicles.forEach { vehicle in
            vehicle.historicalPolicies = (0...5).map { _ in
                Policy(
                    id: UUID().uuidString,
                    term: .init(startDate: .distantPast, duration: 1),
                    vehicle: vehicle
                )
            }
        }
        
        return
            .init(
                activePolicies: [activePolicy],
                historicVehicles: Array(vehicles[1...])
        )
    }
    
    // MARK: - Properties
    private var cachedJsonResponse: JSONResponse?
    
    // MARK: - Helper
    private func getUniqueVehicles(from json: JSONResponse?) -> [Vehicle]? {
        guard let json = cachedJsonResponse else { return nil }
        let vehiclesLive = json.map { $0.payload.vehicle }.compactMap { $0 }
        let vehicles: [Vehicle] = vehiclesLive.map {
            let id = Vehicle.getVehicleId(from: $0.prettyVrm)
            let displayVRM = $0.prettyVrm
            let makeModel = Vehicle.getModel(from: $0)
            return Vehicle(id: id, displayVRM: displayVRM, makeModel: makeModel)
        }.unique { $0.id == $1.id }
        return vehicles
    }
}
