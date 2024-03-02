//
//  ContentView.swift
//  whatsappcloneui
//
//  Created by Olgun ‏‏‎‏‏‎ on 2.03.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AuthView: View {
    @ObservedObject var userStore = UserStore()
    let db = Firestore.firestore()
    @State var useremail = ""
    @State var password = ""
    @State var username = ""
    @State var showAuthView = true
    
    var body: some View {
        NavigationView {
            
            if showAuthView {
                
                
                
                
                List {
                    Text("X-CHAT").font(.largeTitle).bold()
                    Section{
                        VStack (alignment: .leading){
                            SectionSubTitle(subtitle: "User name")
                            TextField("Enter your username", text: $username)
                            
                        }
                    }
                    Section{
                        VStack (alignment: .leading){
                            SectionSubTitle(subtitle: "User Email")
                            TextField("Enter your email", text: $useremail)
                            
                        }
                    }
                    Section{
                        VStack (alignment: .leading){
                            SectionSubTitle(subtitle: "Password")
                            TextField("Enter your password", text: $password)
                            
                        }
                    }
                    
                    
                    Section {
                        HStack {
                            Button(action: {
                                
                                Auth.auth().signIn(withEmail: self.useremail, password: self.password) { result, error in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    }
                                    else {
                                        self.showAuthView = false
                                    }
                                }
                                
                                
                                
                            }, label: {
                                
                                Text("Sign In")
                                
                            })
                            Spacer()
                            
                            
                        }
                        
                        
                    }
                    Section {
                        HStack {
                            Button(action: {
                                
                                Auth.auth().createUser(withEmail: self.useremail, password: self.password) { result, error in
                                    if error != nil {
                                        print(error?.localizedDescription)
                                    }
                                    else {
                                        var ref : DocumentReference? = nil
                                        let myUserDictionary : [String : Any] = ["username": self.username,"useremail" : self.useremail,"id" : result?.user.uid]
                                        ref = self.db.collection("Users").addDocument(data: myUserDictionary, completion: { error in
                                            if error != nil {
                                                
                                            }
                                            self.showAuthView = false
                                        })
                                    }
                                    
                                }
                                
                                
                                
                            }, label: {
                                
                                Text("Sign Up")
                                
                            })
                            Spacer()
                            
                            
                        }
                        
                        
                    }
                }
            } else {
                
                
                //Userview
                NavigationView {
                    List(userStore.userArray) {user in
                        NavigationLink (destination: chatView(userToChat: user)) {
                            Text(user.name)
                        }
                        
                        
                    }
                }.navigationBarTitle("Chat With Users!")
                    .navigationBarItems(trailing: Button(action: {
                        
                        do {
                            try Auth.auth().signOut()
                            self.showAuthView = true
                        }catch {
                            print(error.localizedDescription)
                        }
                        
                    }, label: {
                        Text("Log Out")
                    }))
            }
        }
    }
}

#Preview {
    Group {
        AuthView(showAuthView:false)
        AuthView(showAuthView:true)


    }
}

struct SectionSubTitle : View {
    var subtitle: String
    var body: some View {
        Text(subtitle).font(.subheadline).foregroundStyle(.gray).bold()
    }
}

