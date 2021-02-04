//
//  ViewController.swift
//  Covid-19 Dependecy_Injection
//
//  Created by Arpit Srivastava on 01/11/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel : CovidParser!
    
    var dataSource:[DailyTaly] = []{
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: self.dataSource.count - 1), at: .bottom, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup(){
        viewModel = CovidParser(networking: NetworkLayer())
        viewModel.fetch(CovidCase.india, type: DailyTaly.self) { [weak self](data) in
            if let d = data{
                self?.dataSource = d
            }else{
                self?.dataSource = []
            }
        }
        title = "India COVID-19 Status"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func returnHeaderview(_ section:Int) -> UIView{
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 35))
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        let dt = formater.date(from: dataSource[section].Date) ?? Date()
        formater.dateFormat = "dd-MM-YYYY, HH:mm a"
        label.text = formater.string(from: dt)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        headerView.addSubview(label)
        headerView.layer.cornerRadius = 5
        return headerView
    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DataTVCell", for: indexPath) as? DataTVCell{
            cell.dataSource = dataSource[indexPath.section]
            return cell
        }else{
            fatalError("DataTVCell cell not found....")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return returnHeaderview(section)
    }
}







class DataTVCell:UITableViewCell{
    
    @IBOutlet weak var totalCasesCount:UILabel!
    @IBOutlet weak var activeCasesCount:UILabel!
    @IBOutlet weak var recoveredCasesCount:UILabel!
    @IBOutlet weak var totalDeathCount:UILabel!
    
    var dataSource:DailyTaly? = nil{
        didSet{
            if let d = dataSource{
                totalCasesCount.text = "\(d.Confirmed)"
                activeCasesCount.text = "\(d.Active)"
                recoveredCasesCount.text = "\(d.Recovered)"
                totalDeathCount.text = "\(d.Deaths)"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
