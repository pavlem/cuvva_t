import Foundation

class Policy: Identifiable, ObservableObject {
    
    let id: String
    let term: PolicyTerm
    let vehicle: Vehicle
    
    init(id: String, term: PolicyTerm, vehicle: Vehicle) {
        self.id = id
        self.term = term
        self.vehicle = vehicle
    }
}

struct PolicyTerm {
    var startDate: Date
    var duration: TimeInterval
}
