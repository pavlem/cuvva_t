import SwiftUI
import Combine

@main
struct CuvvaTechTestApp: App {
    
    // TODO: Replace mocks with custom implementations
    private static let useLive: Bool = true
    
    private var appModel: AppViewModel = {
        
        guard useLive else {
            return .init(
                apiClient: .mockEmpty,
                policyModel: MockPolicyModel()
            )
        }
        
        return .init(
            apiClient: .live,
            policyModel: LivePolicyEventProcessor()
        )
        
    }()
    
    var body: some Scene {
        WindowGroup {
            HomeView(model: appModel)
        
            
            /**
                TODO: Supply own PolicyTermFormatter implementation
            */
            
//               .environment(\.policyTermFormatter, LivePolicyTermFormatter())
            
            
            /**
                The app uses a static time by default
                TODO: Uncomment the line below to use the device time
            */
            
//               .environment(\.now, LiveTime())
            
            
            
        }
    }
}

// MARK: App View Model

class AppViewModel: ObservableObject {
    
    @Published private(set) var activePolicies = [Policy]()
    @Published private(set) var historicalVehicles = [Vehicle]()
    
    @Published var hasError = false
    @Published var isLoading = false
    
    private(set) var lastError: Error? {
        didSet {
            self.hasError = lastError != nil
        }
    }
    
    var cancellationToken: AnyCancellable?
    
    // MARK: Dependencies
    private let apiClient: APIClient
    private let policyModel: PolicyEventProcessor
    
    // MARK: Public functions
    
    init(apiClient: APIClient, policyModel: PolicyEventProcessor) {
        self.apiClient = apiClient
        self.policyModel = policyModel
    }
    
    func reload(date: @escaping () -> Date) {
        
        isLoading = true
        
        cancellationToken = apiClient.events()
            .print("=======APIClient Reload=======")
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.lastError = error
                        fallthrough
                    case .finished:
                        self.isLoading = false
                    }
                },
            receiveValue: { response in
                self.policyModel.store(json: response)
                self.refreshData(for: date())
            }
        )
    }
    
    func refreshData(for date: Date) {
        guard let data = self.policyModel.retrieve(for: date) else { return }
        self.activePolicies = data.activePolicies
        self.historicalVehicles = data.historicVehicles
        self.objectWillChange.send()
    }
}
