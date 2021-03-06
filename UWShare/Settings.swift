//
//  Settings.swift
//  UW Share
//
//  Created by Jason Chen on 2020-01-21.
//  Copyright © 2020 Jason Chen. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct Settings: View {
    let storage = Storage.storage()
    @EnvironmentObject private var navigator: Navigator
    @State private var message = "";
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Settings")
                    .font(.largeTitle)
                    .bold()
                
                Text("Logged in as " + (Auth.auth().currentUser?.email ?? ""))
                    .font(.title)
                    .foregroundColor(.gray)
            }
            Image("default profile icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(message)
                .foregroundColor(.green);
            Button(action: {
                let storageRef = self.storage.reference()
                let profilePicture = storageRef.child("users/picture.png")
                let localFile = URL(fileURLWithPath: Bundle.main.path(forResource: "Geese", ofType: "png")!)
                let uploadTask =  profilePicture.putFile(from: localFile, metadata: nil) { metadata, error in guard let metadata = metadata else {
                    print("Error with image upload")
                    return}
                    let size = metadata.size
                }
            }) {Text("Change profile picture")}
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: Auth.auth().currentUser?.email ?? "")
                self.message = "Password reset email sent! Check your inbox"
            }) {Text("Change password")}
            .frame(width: 200, height: 50)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
            Button(action: {
            }) {Text("Change email address")}
            .frame(width: 200, height: 50)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    print("User successfully logged out!")
                    self.navigator.currentView = "Login"
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
            }) {Text("Signout")}
            .frame(width: 200, height: 50)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            .padding()
            Button(action: {
            }) {Text("More Options")}
            .frame(width: 200, height: 30)
            .padding()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(Navigator())
    }
}
