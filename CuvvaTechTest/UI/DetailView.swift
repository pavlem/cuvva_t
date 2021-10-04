import SwiftUI

struct DetailView: View {
    
    @ObservedObject var vehicle: Vehicle
    @Binding var selectedVehicleID: String?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                if let activePolicy = vehicle.activePolicy {
                    ActivePolicyView(activePolicy: activePolicy, showVehicle: false)
                        .padding()
                }
                
                HistoricalPoliciesSection()
                    .environmentObject(vehicle)
                
            }
        }
        .padding(.vertical)
        .background(Color.offWhite.edgesIgnoringSafeArea(.all))
        .navigationTitle(vehicle.displayVRM)
        .navigationBarTitleDisplayMode(.large)
        .onDisappear {
            self.selectedVehicleID = nil
        }
    }
}

struct HistoricalPoliciesSection: View {
    
    @EnvironmentObject var model: Vehicle
    
    @State private(set) var historicalPolicies = [Policy]()
    
    var body: some View {
        Section(header: SectionHeader(title: "Previous Policies")) {
            ForEach(historicalPolicies) { policy in
                HistoricalPolicyView(policy: policy)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
                    )
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onReceive(model.$historicalPolicies) {
            self.historicalPolicies = $0
        }
    }
}

struct HistoricalPolicyView: View {
    
    let policy: Policy
    
    @Environment(\.policyTermFormatter) var formatter

    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(systemName: "clock.arrow.circlepath")
                .font(Font.system(.subheadline))
            
            VStack(alignment: .leading, spacing: 8) {
                
                
                VStack {
                    Text("Duration")
                        .font(.callout.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatter.durationString(for: policy.term.duration))
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    
                    Text("Start")
                        .font(.callout.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Text(formatter.policyDateString(for: policy.term.startDate))
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                VStack {
                    
                    Text("End")
                        .font(.callout.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatter.policyDateString(for: policy.term.startDate.addingTimeInterval(policy.term.duration)))
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(vehicle: .init(id: "", displayVRM: "", makeModel: ""), selectedVehicleID: .constant(nil))
    }
}
