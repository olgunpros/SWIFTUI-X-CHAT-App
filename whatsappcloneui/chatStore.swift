
import SwiftUI
import Firebase
import Combine
import FirebaseFirestore
import FirebaseAuth

class chatStore : ObservableObject {
    
    let db = Firestore.firestore()
    var chatArray : [chatModel] = []
    
    var didChange = PassthroughSubject<Array<Any>,Never>()
    
    init() {
        
        db.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                
            }
            else {
                self.chatArray.removeAll(keepingCapacity: false)
                for document in snapshot!.documents {
                    let chatUidFromFirebase = document.documentID
                    if let chatMessage = document.get("message") as? String {
                        if let messageFrom = document.get("chatUserFrom") as? String {
                            if let messageTo = document.get("chatUserTo") as? String {
                                if let dateString = document.get("date") as? String {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                    let dateFromDB = dateFormatter.date(from: dateString)
                                    let currentIndex = self.chatArray.last?.id
                                    let createdChat = chatModel(id: (currentIndex ?? -1)+1, message: chatMessage, uidFromFirebase:chatUidFromFirebase , messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromDB!, messageFromMe: true)
                                    self.chatArray.append(createdChat)
                                }
                            }
                        }
                    }
                    
                }
                
                self.db.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { snapshot, error in
                    if error != nil {
                        
                    }
                    else {
                        
                        for document in snapshot!.documents {
                            let chatUidFromFirebase = document.documentID
                            if let chatMessage = document.get("message") as? String {
                                if let messageFrom = document.get("chatUserFrom") as? String {
                                    if let messageTo = document.get("chatUserTo") as? String {
                                        if let dateString = document.get("date") as? String {
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                            let dateFromDB = dateFormatter.date(from: dateString)
                                            let currentIndex = self.chatArray.last?.id
                                            let createdChat = chatModel(id: (currentIndex ?? -1)+1, message: chatMessage, uidFromFirebase:chatUidFromFirebase , messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromDB!  , messageFromMe: true)
                                            self.chatArray.append(createdChat)
                                        }
                                    }
                                }
                            }
                            
                        }
                        self.chatArray = self.chatArray.sorted(by: {
                            $0.messageDate.compare($1.messageDate) == .orderedAscending
                            
                        })
                        
                        self.didChange.send(self.chatArray)
                        
                    }
                }
                
                
            }
        }
        
    }
    
}
