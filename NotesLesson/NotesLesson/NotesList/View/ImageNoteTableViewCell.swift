//
//  ImageNoteTableViewCell.swift
//  NotesLesson
//
//  Created by Katerina on 04/01/2024.
//

import UIKit

final class ImageNoteTableViewCell: UITableViewCell {
    // MARK: - GUI Variables
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGreen
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let attachmentView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.image = UIImage(named: "mockImage")
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title label text"
        label.font = .boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    // MARK: - Initialisations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(note: Note) {
        titleLabel.text = note.title
        guard let imageData = note.image,
              let image = UIImage(data: imageData) else { return }
        attachmentView.image = image
    }
    
    // MARK: - Private methods
    func setupUI() {
        addSubview(containerView)
        containerView.addSubview(attachmentView)
        containerView.addSubview(titleLabel)
        
         setupConstraints()
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        attachmentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
}
