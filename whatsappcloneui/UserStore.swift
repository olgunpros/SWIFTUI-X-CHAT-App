
import SwiftUI
import Firebase
import FirebaseFirestore
import Combine

class UserStore : ObservableObject {

    
    let db = Firestore.firestore()
    var userArray : [UserModel] = []
    var didChange = PassthroughSubject<Array<Any>,Never>()
    
    init() {
        
        db.collection("Users").addSnapshotListener { snapshot, error in
            if error != nil {
                
            }
            else {
                self.userArray.removeAll(keepingCapacity: false)
                for document in snapshot!.documents {
                    if let userUidFromFirebase = document.get("id") as? String {
                        if let userName = document.get("username") as? String {
                            let currentindex = self.userArray.last?.id
                            let createdUser = UserModel(id: (currentindex ?? -1)+1 ?? 0, name: userName, uidFromFirebase: userUidFromFirebase)
                            self.userArray.append(createdUser)
                        }
                    }
                }
                self.didChange.send(self.userArray)
            }
        }
        
        
        
        
        
    }
    
}
