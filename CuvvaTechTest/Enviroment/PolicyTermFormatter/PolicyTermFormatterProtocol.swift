import Foundation

protocol PolicyTermFormatter {
    
    func durationString(for: TimeInterval) -> String
    
    func durationRemainingString(for: PolicyTerm, relativeTo: Date) -> String
    
    func durationRemainingPercent(for: PolicyTerm, relativeTo: Date) -> Double
    
    func policyDateString(for: Date) -> String
    
}
