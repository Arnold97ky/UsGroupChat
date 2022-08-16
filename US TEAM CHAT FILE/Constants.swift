//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Arnold Sylvestre on 8/3/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

struct K {
static let cellIdentifier = "ReusableCell"
static let cellNibName = "MessageCellTableViewCell"
static let registerSegue = "RegisterToChat"
static let loginSegue = "LoginToChat"

struct BrandColors {
static let purple = "BrandPurple"
static let lightPurple = "BrandLightPurple"
static let blue = "BrandBlue"
static let lighBlue = "BrandLightBlue"
}

struct FStore {
static let collectionName = "messages"
static let senderField = "sender"
static let bodyField = "body"
static let dateField = "date"
}
}
