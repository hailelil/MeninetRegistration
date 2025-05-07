import SwiftUI
import CoreData

struct StatisticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: RegisteredUser.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \RegisteredUser.firstName, ascending: true)]
    ) private var users: FetchedResults<RegisteredUser>
    
    @FetchRequest(
        entity: Service.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Service.name, ascending: true)]
    ) private var services: FetchedResults<Service>

    // Hardcoded list of users that can login for demonstration
    let predefinedUsers = [
        User(username: "user1", password: "password1", userType: .admin),
        User(username: "user2", password: "password2", userType: .issuer),
        User(username: "user3", password: "password3", userType: .verifier),
        User(username: "user4", password: "password4", userType: .admin),
        User(username: "user5", password: "password5", userType: .issuer),
        User(username: "user6", password: "password6", userType: .verifier),
        User(username: "user7", password: "password7", userType: .admin),
        User(username: "user8", password: "password8", userType: .issuer),
        User(username: "user9", password: "password9", userType: .verifier),
        User(username: "user10", password: "password10", userType: .admin)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("")
                        .font(.largeTitle)
                        .padding(.top, 8) // Adjust top padding

                    HStack {
                        StatisticCard(title: "Total Registered Identities", value: "\(users.count)", color: .blue)
                    }

                    HStack {
                        StatisticCard(title: "Users with Login Access", value: "\(predefinedUsers.count)", color: .green)
                    }

                    HStack {
                        let runningServices = services.filter { $0.isRunning }
                        StatisticCard(title: "Running Services", value: "\(runningServices.count) / \(services.count)", color: .orange)
                    }
                    
                    PieChartSection()
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Statistics", displayMode: .inline)
        }
    }
    
    private func PieChartSection() -> some View {
        let maleCount = users.filter { $0.sex == "Male" }.count
        let femaleCount = users.filter { $0.sex == "Female" }.count
        let otherCount = users.filter { $0.sex == "Other" }.count
        
        let data = [Double(maleCount), Double(femaleCount), Double(otherCount)]
        let colors: [Color] = [.blue, .pink, .gray]
        
        return VStack {
            Text("Sex Distribution")
                .font(.headline)
            PieChart(data: data, colors: colors)
                .frame(height: 150) // Adjusted height to reduce size
                .padding()
            HStack {
                Text("Male: \(maleCount)").foregroundColor(.blue)
                Text("Female: \(femaleCount)").foregroundColor(.pink)
                Text("Other: \(otherCount)").foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

struct StatisticCard: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack {
            Text(value)
                .font(.largeTitle)
                .bold()
                .foregroundColor(color)
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
