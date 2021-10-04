import Foundation
import Combine

class Time: ObservableObject {
    
    var cancellable: Cancellable?
    
    @Published var time: Date

    init(with initialTime: Date) {
        self.time = initialTime
    }
    
    func setTime(to newDate: Date) {
        self.time = newDate
        self.objectWillChange.send()
    }
    
}
