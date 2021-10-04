import Foundation

struct LivePolicyTermFormatter: PolicyTermFormatter {
    
    func durationString(for: TimeInterval) -> String {
        fatalError("TODO")
    }
    
    func durationRemainingString(for: PolicyTerm, relativeTo: Date) -> String {
        fatalError("TODO")
    }
    
    func durationRemainingPercent(for: PolicyTerm, relativeTo: Date) -> Double {
        fatalError("TODO")
    }
    
    func policyDateString(for: Date) -> String {
        fatalError("TODO")
    }
}

