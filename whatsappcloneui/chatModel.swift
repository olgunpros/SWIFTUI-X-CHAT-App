//
//  chatModel.swift
//  whatsappcloneui
//
//  Created by Olgun ‏‏‎‏‏‎ on 2.03.2024.
//

import SwiftUI

struct chatModel : Identifiable {
    var id : Int
    var message : String
    var uidFromFirebase : String
    var messageFrom : String
    var messageTo: String
    var messageDate : Date
    var messageFromMe: Bool
}
