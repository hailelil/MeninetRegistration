//
//  MySessionView.swift
//  Meninet
//
//  Created by HLD on 19/05/2024.
//
import SwiftUI

struct MySessionView: View {
    let username: String

    var body: some View {
        Form {
            Section(header: Text("Session Information")) {
                Text("Logged in as: \(username)")
                Text("Session start time: \(sessionStartTime())")
                Text("IP Address: \(getIPAddress())")
            }
        }
        .navigationBarTitle("My Session", displayMode: .inline)
    }

    func sessionStartTime() -> String {
        return "2024-05-18 08:00 AM"
    }

    func getIPAddress() -> String {
        return "192.168.1.1"
    }
}

struct MySessionView_Previews: PreviewProvider {
    static var previews: some View {
        MySessionView(username: "example_user")
    }
}
