//
//  ListToDosCell.swift
//  CleanToDo
//
//  Created by 재영 on 2022/02/18.
//

import UIKit

class ListToDosCell: UITableViewCell {
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  lazy var contentLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  lazy var startDateLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  lazy var dueDateLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  static let identifier = "ListToDosCellID"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented.")
  }
}


// MARK: - Update

extension ListToDosCell {
  public func update(todo: ToDo) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    
    startDateLabel.text = dateFormatter.string(from: todo.startDate)
    dueDateLabel.text = dateFormatter.string(from: todo.dueDate)
    contentLabel.text = todo.content
    titleLabel.text = todo.title
  }
}
