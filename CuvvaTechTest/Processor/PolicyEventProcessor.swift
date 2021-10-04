import Foundation

protocol PolicyEventProcessor {
    
    func store(json: JSONResponse)
    
    func retrieve(for: Date) -> PolicyData?
    
}

struct PolicyData {
    let activePolicies: [Policy]
    let historicVehicles: [Vehicle]
}
