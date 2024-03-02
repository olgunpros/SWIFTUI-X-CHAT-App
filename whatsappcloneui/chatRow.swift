//
//  chatRow.swift
//  whatsappcloneui
//
//  Created by Olgun ‏‏‎‏‏‎ on 2.03.2024.
//

import SwiftUI
import FirebaseAuth

struct chatRow: View {
    
    var chatMessage : chatModel
    var userToChatFromChatView : UserModel
    
    
    var body: some View {
        Group {
            
            if chatMessage.messageFrom == Auth.auth().currentUser!.uid && chatMessage.messageTo == userToChatFromChatView.uidFromFirebase {
                
                HStack {
                    
                    Spacer()
                    Text(chatMessage.message).bold().foregroundStyle(.black)
                        .padding(10)
                   
                }
            }
            else if chatMessage.messageFrom == userToChatFromChatView.uidFromFirebase && chatMessage.messageTo == Auth.auth().currentUser!.uid {
                HStack {
                    
                    
                    
                    Text(chatMessage.message).bold().foregroundStyle(.black)
                        .padding(10)
                    Spacer()
                }
            }
            else {
                //no
            }
                
            
        }.frame(width: UIScreen.main.bounds.width * 0.95)
    }
}


#Preview {
    chatRow(chatMessage: chatModel(id: 0, message:"message", uidFromFirebase: "234324", messageFrom: "fscbsfcb", messageTo: "cbvfzb", messageDate: Date(), messageFromMe: true), userToChatFromChatView: UserModel(id: 1, name: "james", uidFromFirebase: "sad"))
}
