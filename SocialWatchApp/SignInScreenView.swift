//
//  SignInScreenView.swift
//  SocialWatchApp
//
//  Created by Aydın Serhat SEZEN on 14.06.2022.
//

import SwiftUI
import WatchConnectivity

struct SignInScreenView: View {
    var model = ViewModelPhone()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    SocalLoginButton(image: Image(uiImage: #imageLiteral(resourceName: "apple")), text: Text("Sign in with Apple"))
                    
                    SocalLoginButton(image: Image(uiImage: #imageLiteral(resourceName: "google")), text: Text("Sign in with Google").foregroundColor(Color("PrimaryColor")))
                        .padding(.vertical)
                    
                    Text("or get a link emailed to you")
                        .foregroundColor(Color.black.opacity(0.4))
                    
                    TextField("Email address", text: $email)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                    
                    SecureField("Password", text: $password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                    
                    PrimaryButton(title: "Login")
                        .onTapGesture {
                            if self.model.session.isReachable {
                                self.model.session.sendMessage(["isLogged" : "true", "Token": "A23231sacsdgew234"], replyHandler: nil) { (error) in
                                    print(error.localizedDescription)
                                }
                            } else {
                                showingAlert = true
                            }
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Failed"),
                                message: Text("Apple Watch is not reachable"),
                                dismissButton: .default(Text("Got it!"))
                            )
                        }
                }
                Spacer()
                Divider()
                Spacer()
                Text("You are completely safe.")
                Text("Read our Terms & Conditions.")
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()
                
            }
            .padding()
        }
        
    }
    
}



struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}


struct SocalLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}
