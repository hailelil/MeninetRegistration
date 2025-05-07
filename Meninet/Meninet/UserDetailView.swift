import SwiftUI
import CoreData

struct UserDetailView: View {
    var user: RegisteredUser
    @State private var showEditView = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Details of")
                        .font(.title2)
                    
                    Text(userFullName)
                        .italic()
                        .font(.title2)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
                .padding(.bottom, 20)

                if let photoData = user.photo, let photo = UIImage(data: photoData) {
                    VStack {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            DetailTableRow(label: "ID Number", value: user.identityNumber ?? "N/A")
                            DetailTableRow(label: "Full Name", value: userFullName)
                            DetailTableRow(label: "Date of Birth", value: user.dob, formatter: dateFormatter)
                            DetailTableRow(label: "Sex", value: user.sex ?? "")
                        }
                        .padding(.leading, 20)
                    }
                    .padding(.bottom, 20)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        DetailTableRow(label: "ID Number", value: user.identityNumber ?? "N/A")
                        DetailTableRow(label: "Full Name", value: userFullName)
                        DetailTableRow(label: "Date of Birth", value: user.dob, formatter: dateFormatter)
                        DetailTableRow(label: "Sex", value: user.sex ?? "")
                    }
                    .padding(.bottom, 20)
                }

                Group {
                    SectionHeaderView(title: "Personal Information")
                    DetailTableRow(label: "Citizenship", value: user.citizenship ?? "")
                    DetailTableRow(label: "Place of Birth", value: user.placeOfBirth ?? "")
                    DetailTableRow(label: "Marital Status", value: user.maritalStatus ?? "")
                    if user.maritalStatus == "Married" {
                        DetailTableRow(label: "Spouse ID Number", value: user.spouseIDNumber ?? "")
                    }
                    DetailTableRow(label: "Education Level", value: user.educationLevel ?? "")
                }

                Group {
                    SectionHeaderView(title: "Mother's Information")
                    DetailTableRow(label: "Mother's First Name", value: user.mothersFirstName ?? "")
                    DetailTableRow(label: "Mother's Father's Name", value: user.mothersFatherName ?? "")
                }

                Group {
                    SectionHeaderView(title: "Address Information")
                    DetailTableRow(label: "Region", value: user.selectedRegion ?? "")
                    DetailTableRow(label: "City", value: user.selectedCity ?? "")
                    DetailTableRow(label: "District", value: user.selectedDistrict ?? "")
                }

                Group {
                    SectionHeaderView(title: "Contact Information")
                    DetailTableRow(label: "Phone Number", value: user.phoneNumber ?? "")
                    DetailTableRow(label: "Email Address", value: user.emailAddress ?? "")
                }

                Spacer()

                // Edit Button
                Button(action: {
                    showEditView.toggle()
                }) {
                    Text("Edit")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .padding()
            .sheet(isPresented: $showEditView) {
                EditUserView(user: user)
            }
        }
    }

    private var userFullName: String {
        "\(user.firstName ?? "") \(user.fatherName ?? "") \(user.grandFatherName ?? "")"
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct SectionHeaderView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.top, 10)
            .padding(.bottom, 5)
    }
}

struct DetailTableRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.headline)
                .frame(width: 150, alignment: .leading)
            Spacer()
            Text(value)
                .font(.subheadline)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 5)
    }
}

extension DetailTableRow {
    init(label: String, value: Date?, formatter: DateFormatter) {
        self.label = label
        self.value = value.map { formatter.string(from: $0) } ?? "N/A"
    }
}
