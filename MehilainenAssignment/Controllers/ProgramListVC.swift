//
//  ProgramListVC.swift
//  MehilainenAssignment
//
//  Created by Joni Tefke on 1.4.2020.
//  Copyright © 2020 jonitefke. All rights reserved.
//

import UIKit

class ProgramListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    var indicator = UIActivityIndicatorView()
    var errorView = ErrorView()

    var programs = [Program]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configErrorView()
        configTableView()
        configActivityIndicator()
        
        getPrograms()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell") as! ProgramCell
        let program = programs[indexPath.row]
        cell.program = program
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let program = programs[indexPath.row]
        segueToDetail(program: program)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configView() {
        title = "YLE TV1 Julkaisut"
        view.backgroundColor = .white
        view.addSubview(errorView)
        view.addSubview(tableView)
        view.addSubview(indicator)
    }
    
    func configActivityIndicator() {
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.startAnimating()
        indicator.center(to: view)
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(ProgramCell.self, forCellReuseIdentifier: "ProgramCell")
        tableView.pin(to: view)
    }
    
    func configErrorView() {
        
        errorView.translatesAutoresizingMaskIntoConstraints                               = false

        errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive   = true
        errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive          = true
        errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive        = true
        
    }

    func segueToDetail(program: Program) {
        let detail = DetailVC()
        detail.program = program
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func getPrograms() {
        let session = URLSession.shared
        guard let url = URL(string: "https://external.api.yle.fi/v1/programs/items.json?type=tvprogram&publisher=yle-tv1&service=yle-areena&limit=10&availability=ondemand&order=publication.starttime:desc&app_id=ebacb87b&app_key=b4a8176e6c6d9b7d2d8a91cb6546029a") else {
            return
        }
        
        let task = session.dataTask(with: url) {data, response, error in
            if let error = error {
                print("Client error: \(error.localizedDescription)!")
                self.handleUI(error: true)
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error!")
                self.handleUI(error: true)
                return
            }
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                
                let data = json?["data"] as? [AnyObject]
                
                if let data = data {
                    for program in data {
                        var publisherId: String = ""
                        var service: [String:Any] = ["id":""]
                        var startTime: String = ""
                        var endTime: String = ""
                        if let publicationEvent = program["publicationEvent"] as? [[String:Any]] {
                            for publishers in publicationEvent {
                                service = publishers["service"] as? [String:Any] ?? ["id":""]
                                startTime = publishers["startTime"] as? String ?? ""
                                endTime = publishers["endTime"] as? String ?? ""
                                if let publisher = publishers["publisher"] as? [[String:Any]] {
                                    for publ in publisher {
                                        publisherId = publ["id"] as? String ?? ""
                                    }
                                }
                            }
                        }
                        
                        let program = Program(
                            title: program["title"] as? [String:Any] ?? ["fi":""],
                            description: program["description"] as? [String:Any] ?? ["fi":""],
                            image: program["image"] as? [String:Any] ?? ["id":""],
                            publisher: Publisher(id: publisherId, service: service, startTime: startTime, endTime: endTime)
                        )
                        self.programs.append(program)
                    }
                }
                self.handleUI(error: false)
            }
        }
        task.resume()
    }
    
    func handleUI(error: Bool) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
            if error {
                self.tableView.isHidden = true
                self.errorView.isHidden = false
            }
            else {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.errorView.isHidden = true
            }
        }
    }
}
