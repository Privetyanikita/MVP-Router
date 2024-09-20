//
//  TableViewBuilder.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 20.09.24.
//

import UIKit

class TableViewBuilder:NSObject, UITableViewDelegate, UITableViewDataSource {
        
    private weak var tableView:UITableView?
    var sections: [TableViewSectionModel] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath)
        cellModel.onFill?(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        cellModel.onSelect?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
}
