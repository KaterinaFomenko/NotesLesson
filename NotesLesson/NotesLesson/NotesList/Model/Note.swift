//
//  Note.swift
//  NotesLesson
//
//  Created by Katerina on 05/01/2024.
//

import Foundation
struct Note: TableViewItemProtocol {
    let title: String
    let description: String
    let date: Date
    let imageURL: String?
    let image: Data?
}
