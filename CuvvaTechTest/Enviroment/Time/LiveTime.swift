import Combine
import Foundation

final class LiveTime: Time {
    
    var offset: TimeInterval = 0
    
    init() {
        
        super.init(with: .init())
        
        defer {
            self.cancellable = Timer.publish(every: 1, on: .main, in: .default)
                    .autoconnect()
                    .map { $0.addingTimeInterval(self.offset) }
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.time, on: self)
        }
    }
    
    override func setTime(to newDate: Date) {
        self.offset = self.time.distance(to: newDate)
    }
    
}
