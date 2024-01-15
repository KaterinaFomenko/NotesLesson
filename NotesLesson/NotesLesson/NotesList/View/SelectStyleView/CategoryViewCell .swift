//
//  CategoryViewCell .swift
//  NotesLesson
//
//  Created by Katerina on 09/01/2024.
//

import SnapKit
import UIKit

final class CategoryViewCell: UICollectionViewCell {
    
    // MARK: - GUI Variables
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        
        view.clipsToBounds = true
        view.backgroundColor = .black
        
        return view
    }()
      

    // MARK: - Initialisations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.leading.equalToSuperview().inset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
    }
    
    func setColor(color: String) {
        imageView.backgroundColor = UIColor(named: color)
        imageView.image = nil
    }

    func setImage(image: String) {
           imageView.image = UIImage(named: image)
           imageView.backgroundColor = .white
        }
}

