//
//  NoteViewController.swift
//  NotesLesson
//
//  Created by Katerina on 06/01/2024.
//
import SnapKit
import UIKit

final class NoteViewController: UIViewController {
    
    // MARK: - GUI Variables
    var attachmentImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.image = UIImage(named: "mockImage")
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
       // view.text = "Mock Text"
        
        return view
    }()
    
    var selectStyleView: SelectStyleViewController?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createSelectStylePanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Methods
    func set(note: Note) {
        textView.text = note.title + " " + note.description
        guard let data = note.image else { return }
        attachmentImageView.image = UIImage(data: data)
    }
    
    func updateUI(selectedValue: String) {
        if selectStyleView?.currentContentType == .color {
            self.view.backgroundColor = UIColor(named: selectedValue)
        } else {
            self.attachmentImageView.image = UIImage(named:  selectedValue)
        }
    }
    
    // MARK: - Private methods
    @objc
    private func saveAction() {
    }
    
    @objc
    private func deleteAction() {
    }
    
    @objc
    private func selectedColor() {
        if selectStyleView?.currentContentType == .image && selectStyleView?.view.isHidden == false {
            selectStyleView?.setContentType(panelType: .color)
            
        } else {
        selectStyleView?.setContentType(panelType: .color)
        
        selectStyleView?.view.isHidden = !(selectStyleView?.view.isHidden ?? false)
        }
    }
    
    @objc
    private func selectedImage() {
        if selectStyleView?.currentContentType == .color &&  selectStyleView?.view.isHidden == false {
            selectStyleView?.setContentType(panelType: .image)

        } else {
            selectStyleView?.setContentType(panelType: .image)
            selectStyleView?.view.isHidden = !(selectStyleView?.view.isHidden ?? false)
        }
    }

    private func setupUI() {
        view.addSubview(attachmentImageView)
        view.addSubview(textView)
        view.backgroundColor = .white
        textView.layer.borderWidth = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0
     
        setupConstraints()
        setImageHeight()
        setupBars()
        registerForKeyboardNotification()
        hideKeyboardWhenTappedAround()
    }
    
    private func createSelectStylePanel() {
        selectStyleView = SelectStyleViewController()
        selectStyleView?.noteVC = self

        selectStyleView?.view.isHidden = true
        
        guard let _selectStyleView = selectStyleView else { return }
        view.addSubview(_selectStyleView.view)
        
        _selectStyleView.view.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(95)
        }
    }
    
    private func setupConstraints() {
        attachmentImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(95)
        }
    }
    
    private func setImageHeight() {
        let height = attachmentImageView.image != nil ? 200 : 0
        
        attachmentImageView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    private func setupBars() {
        let trash = UIBarButtonItem(barButtonSystemItem: .trash,
                                    target: self,
                                    action: #selector(deleteAction))
        
        let spacing = UIBarButtonItem(systemItem: .flexibleSpace)
        
        let selectColor = UIBarButtonItem(image: UIImage(named: "iconColor"),style: .plain, target: self, action: #selector(selectedColor))
        
        let selectImage = UIBarButtonItem(image: UIImage(named: "imageChoice2"),style: .plain, target: self, action: #selector(selectedImage))
      
        setToolbarItems([trash, spacing, selectColor, spacing, selectImage], animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAction))
    }
}

extension NoteViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        self.textView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().inset(keyboardFrame.height + 10)
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        self.textView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().inset(95)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyBoard))
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
    }
    
    @objc
    private func hideKeyBoard() {
        textView.resignFirstResponder()
    }
}

