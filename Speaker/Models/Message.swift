//
//  Message.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import Foundation

protocol Message: Decodable, Hashable {
    var content: String { get }
}
