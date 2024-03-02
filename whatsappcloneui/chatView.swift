import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct chatView: View {
    let db = Firestore.firestore()
    @State var messageToSend = ""
    @ObservedObject var chatStoree = chatStore()
    var userToChat: UserModel
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatStoree.chatArray) { chats in
                    chatRow(chatMessage: chats, userToChatFromChatView: self.userToChat)
                }
            }
            
            HStack {
                TextField("Type here...", text: $messageToSend).frame(minWidth: 30).padding()
                Button(action: {
                    sendMessageToFirebase()
                }, label: {
                    Text("Send")
                }).frame(minHeight: 50).padding()
            }
        }
    }
    
    func sendMessageToFirebase() {
        let myChatDictionary: [String: Any] = ["chatUserFrom": Auth.auth().currentUser!.uid,
                                                "chatUserTo": userToChat.uidFromFirebase,
                                                "date": generateDate(),
                                                "message": self.messageToSend]
        var ref: DocumentReference? = nil
        ref = self.db.collection("Chats").addDocument(data: myChatDictionary, completion: { error in
            if error != nil {
                // Handle error
            } else {
                self.messageToSend = ""
            }
        })
    }
    
    func generateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return formatter.string(from: Date())
    }
}

struct chatView_Previews: PreviewProvider {
    static var previews: some View {
        chatView(userToChat: UserModel(id: 0, name: "mila", uidFromFirebase: "234324"))
    }
}
