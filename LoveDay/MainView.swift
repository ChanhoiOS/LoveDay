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
   
    @IBOutlet weak var hiddenBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var profileLeft: UIImageView!
    @IBOutlet weak var profileRight: UIImageView!
    @IBOutlet weak var hiddenImage: UIImageView!
    @IBOutlet weak var specialBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()
    let picker = UIImagePickerController()
    var fromTouch = ""
    var countLove = 0
    var specialDay = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        picker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureRx()
    }
    
    func configureUI() {
        cameraBtn.setTitle("", for:.normal)
        leftBtn.setTitle("", for: .normal)
        rightBtn.setTitle("", for: .normal)
        eventBtn.setTitle("", for: .normal)
        hiddenBtn.setTitle("", for: .normal)
        specialBtn.setTitle("", for: .normal)
        if let imgData = UserDefaults.standard.object(forKey: "backgroundImage") as? NSData {
            if let image = UIImage(data: imgData as Data) {
                self.backgroundImg.image = image
            }
        }
        if let imgData = UserDefaults.standard.object(forKey: "leftProfileImage") as? NSData {
            if let image = UIImage(data: imgData as Data) {
                self.profileLeft.image = image
            }
        }
        if let imgData = UserDefaults.standard.object(forKey: "rightProfileImage") as? NSData {
            if let image = UIImage(data: imgData as Data) {
                self.profileRight.image = image
            }
        }
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
           
        profileLeft.clipsToBounds = true
        profileLeft.layer.cornerRadius = profileLeft.frame.height/2
        profileRight.clipsToBounds = true
        profileRight.layer.cornerRadius = profileRight.frame.height/2
        hiddenImage.clipsToBounds = true
        hiddenImage.layer.cornerRadius = hiddenImage.frame.height/2
    }
    
    func configureRx() {
        self.viewModel.input.getDate.onNext(())
        
        self.viewModel.output.setDate
            .subscribe(onNext: { [weak self] dateCount in
                self?.countLabel.text = "\(dateCount)"
                self?.countLove = dateCount
            }).disposed(by: disposeBag)
        
        self.viewModel.output.specialDay
            .subscribe(onNext: { [weak self] daysString in
                self?.specialDay = daysString
            }).disposed(by: disposeBag)
    }
    
    func comeView() {
        hiddenImage.isHidden = false
    }

    @IBAction func openCamera(_ sender: Any) {
        picker.sourceType = .photoLibrary
        fromTouch = "background"
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func leftOpen(_ sender: Any) {
        picker.sourceType = .photoLibrary
        fromTouch = "leftProfile"
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func rightOpen(_ sender: Any) {
        picker.sourceType = .photoLibrary
        fromTouch = "rightProfile"
        present(picker, animated: true, completion: nil)
    }
    @IBAction func evnetPopup1(_ sender: Any) {
        let alert = UIAlertController(title: "Love", message: "예진아 \(self.countLove)만배 사랑해", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "나둥", style: .default, handler : { _ in
            self.comeView()
            
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func hiddenAction(_ sender: Any) {
        hiddenImage.isHidden = true
    }
    
    @IBAction func specialOpen(_ sender: Any) {
        let sp = UIStoryboard(name: "Main", bundle: nil)
        let vc = sp.instantiateViewController(withIdentifier: "SpecialDayViewController") as! SpecialDayViewController
        vc.specialDay = specialDay
        self.present(vc, animated: true, completion: nil)
    }
}

extension MainView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("image: ",image)
            if fromTouch == "background" {
                let saveImage = image
                self.backgroundImg.image = image
                
                let jpgImage = saveImage.jpegData(compressionQuality: 1.0)
                UserDefaults.standard.set(jpgImage, forKey: "backgroundImage")
                UserDefaults.standard.synchronize()
            } else if fromTouch == "leftProfile" {
                let saveImage = image
                self.profileLeft.image = image
                
                let jpgImage = saveImage.jpegData(compressionQuality: 1.0)
                UserDefaults.standard.set(jpgImage, forKey: "leftProfileImage")
                UserDefaults.standard.synchronize()
            } else if fromTouch == "rightProfile" {
                let saveImage = image
                self.profileRight.image = image
                
                let jpgImage = saveImage.jpegData(compressionQuality: 1.0)
                UserDefaults.standard.set(jpgImage, forKey: "rightProfileImage")
                UserDefaults.standard.synchronize()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
