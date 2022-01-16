//
//  MainView.swift
//  LoveDay
//
//  Created by 이찬호 on 2022/01/08.
//

import UIKit
import Then
import RxSwift
import RxCocoa

class MainView: UIViewController {
   
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRx()
        configureUI()
        picker.delegate = self
    }
    
    func configureUI() {
        cameraBtn.setTitle("", for:.normal)
        if let imgData = UserDefaults.standard.object(forKey: "backgroundImage") as? NSData {
            if let image = UIImage(data: imgData as Data) {
            self.backgroundImg.image = image
            }
        }
    }
    
    func configureRx() {
        self.viewModel.input.getDate.onNext(())
        
        self.viewModel.output.setDate
            .subscribe(onNext: { [weak self] dateCount in
                self?.countLabel.text = "\(dateCount)"
            }).disposed(by: disposeBag)
    }

    @IBAction func openCamera(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
}

extension MainView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let saveImage = image
            self.backgroundImg.image = image
            
            let jpgImage = saveImage.jpegData(compressionQuality: 1.0)
            UserDefaults.standard.set(jpgImage, forKey: "backgroundImage")
            UserDefaults.standard.synchronize()
        }
        self.dismiss(animated: true, completion: nil)
    }
}
