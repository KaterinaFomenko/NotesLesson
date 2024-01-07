//
//  NotesListViewModel.swift
//  NotesLesson
//
//  Created by Katerina on 05/01/2024.
//

import Foundation
protocol NotesListViewModelProtocol {
    var section: [TableViewSection] { get }
}

final class NotesListViewModel: NotesListViewModelProtocol {
    private(set) var section: [TableViewSection] = []
    
    init() {
      getNotes()
      setMocks()
    }
    
    private func getNotes() {
        
    }
    
    private func setMocks() {
        let section = TableViewSection(title: "06 Jan 2024", items: [
            Note(title: "First note",
                 description: "First note description",
                 date: Date(),
                 imageURL: nil,
                 image: nil),
            Note(title: "First note",
                 description: "First note description",
                 date: Date(),
                 imageURL: nil,
                 image: nil)
        ])
        self.section = [section] // обновляет данные таблиц tableView.reloadData()
    }
}





