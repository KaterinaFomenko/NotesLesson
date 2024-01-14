//
//  SelectStyleView.swift
//  NotesLesson
//
//  Created by Katerina on 09/01/2024.
//

import Foundation
import UIKit

enum PanelContentType {
        case image
        case color
        case none
    }

final class SelectStyleViewController: UIViewController {
    weak var noteVC: NoteViewController?
    
    var colorList = ["lightRed", "lightYellow", "blueSky", "lightGreen", "purple", "gray"]
    var imageList = ["food", "pencil", "united", "flowers", "house", "puzzle"]

    var currentContentType: PanelContentType = .none
  
    var selectedUserColor: String? //хранение последнего выбранного цвета пользователем
    var selectedUserImage: String?

    private lazy var collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: 64, height: 64)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height),
                                              collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = true
        
        return collectionView
    }()
    
    override func viewDidLoad() {
       configure()
    }
    
    func configure() {
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        configureCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func setContentType(panelType: PanelContentType) {
        currentContentType = panelType

        collectionView.reloadData()
    }
    
    func configureCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.height.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(0)
        }
        
        collectionView.backgroundColor = .clear
        
        registerCell()
    }
    
    func registerCell() {
        collectionView.register(CategoryViewCell.self,
                                forCellWithReuseIdentifier: "CategoryViewCell")
    }
    
    func getColor(at indexPath: IndexPath) -> String {
        return colorList[indexPath.row]
    }
    
    func getImage(at indexPath: IndexPath) -> String {
        return imageList[indexPath.row]
    }
}

extension SelectStyleViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCell",
                                                            for: indexPath) as? CategoryViewCell else
        { return UICollectionViewCell() }
       
        if currentContentType == .color {
            let color = getColor(at: indexPath)
            cell.setColor(color: color)
            print(color)
            
        } else if currentContentType == .image {
            let image = getImage(at: indexPath)
            cell.setImage(image: image)
            print(image)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        if currentContentType == .color {
            selectedUserColor = colorList[indexPath.row]
            self.view.isHidden = true
    
            noteVC?.updateUI(selectedValue: selectedUserColor ?? "")
        } else {
            selectedUserImage = imageList[indexPath.row]
            self.view.isHidden = true
         
            noteVC?.updateUI(selectedValue: selectedUserImage ?? "")
        }
    }
}
