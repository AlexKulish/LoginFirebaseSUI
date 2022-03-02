//
//  ContentView.swift
//  LoginFirebaseSUI
//
//  Created by Alex Kulish on 21.02.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var loginStatusMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker Here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }.cornerRadius(10)
                    
                    Text(self.loginStatusMessage)
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(
                LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            if let error = error {
                print("Failed login user: ", error)
                self.loginStatusMessage = "Failed login user: \(error)"
                return
            }
            
            if let user = result {
                if user.user.isEmailVerified {
                    print("Email verified: \(user.user.isEmailVerified)")
                }
            }
            
            
            print("Successfully loged as a user: \(result?.user.uid ?? "")")
            
            self.email = ""
            self.password = ""
            self.loginStatusMessage = "Successfully loged as a user: \(result?.user.uid ?? "")"
        }
    }
    
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email,
                           password: password) { result, error in
            if let error = error {
                print("Failed to create user: ", error)
                self.loginStatusMessage = "Failed to create user: \(error)"
                return
            }
            print("Successfully created new user: \(result?.user.uid ?? "")")
            
            if let user = result {
                user.user.sendEmailVerification()
                print("Email verified: \(user.user.isEmailVerified)")
            }
            
            self.email = ""
            self.password = ""
            self.loginStatusMessage = "Successfully created new user: \(result?.user.uid ?? "")"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
