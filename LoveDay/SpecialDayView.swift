//
//  SpecialDayView.swift
//  LoveDay
//
//  Created by 이찬호 on 2022/02/01.
//

import UIKit

class SpecialDayView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var specialDay = [String]()
    var subscribe = ["만난 날", "100일","200일","300일","1 주년","400일","500일","600일","700일","2 주년","800일","900일", "1000일"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let nibName = UINib(nibName: "SpecialDayCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SpecialDayCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        configureRx()

    }
    
    func configureRx() {
        print("special: ",specialDay)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialDayCell", for:  indexPath) as! SpecialDayCell
        cell.spDay.text = "❤️" + specialDay[indexPath.row]
        cell.subscribe.text = subscribe[indexPath.row]
        
        return cell
    }
    

    
}
