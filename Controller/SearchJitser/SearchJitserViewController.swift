//
//  SearchJitserViewController.swift
//  InstructorsCheckmat
//
//  Created by Temirlan Merekeyev on 3/15/20.
//  Copyright © 2020 Checkmat.kz. All rights reserved.
//

import UIKit

class SearchJitserViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var searchController: UISearchController!
    private let attendanceClient = AttendanceClient()
    private let attendanceGroupID: Int
    private let attendanceDate: String
    private var attendances = [Attendance]()
    private let jitserClient = JitserClient()
    
    private var clients = [Client]() {
        didSet {
            if clients.count == attendances.count {
                clients.forEach {
                    jitserClient.getGymUser(id: $0.userID, success: { (gymUsers) in
                        self.gymUsers.append(contentsOf: gymUsers)
                    }) { (error) in
                        print(error)
                    }
                }
            }
        }
    }
    
    private var gymUsers = [GymUser]() {
        didSet {
            if gymUsers.count == clients.count {
                for (i, client) in clients.enumerated() {
                    let jitser = Jitser(client: client, gymUser: gymUsers[i])
                    jitsers.append(jitser)
                }
            }
        }
    }
    
    private var jitsers = [Jitser]() {
        didSet {
            if gymUsers.count == jitsers.count {
                tableView.reloadData()
            }
        }
    }
    
    init(attendanceGroupID: Int, attendanceDate: String) {
        self.attendanceGroupID = attendanceGroupID
        self.attendanceDate = attendanceDate
        super.init(nibName: SearchJitserViewController.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AttendanceTableViewCell", bundle: nil), forCellReuseIdentifier: "AttendanceTableViewCell")
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        attendanceClient.getAttendaces(groupID: self.attendanceGroupID, date: self.attendanceDate, success: { [weak self] attendances in
            guard let self = self else { return }
            self.attendances = attendances
            self.attendances.forEach {
                guard let clientID = $0.clientId else { return }
                self.jitserClient.getClient(id: clientID, success: { [weak self] clientsD in
                    guard let self = self else { return }
                    self.clients.append(contentsOf: clientsD)
                }) { (error) in
                    print(error)
                }
            }
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
}

extension SearchJitserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}

extension SearchJitserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jitsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceTableViewCell", for: indexPath) as! AttendanceTableViewCell
        cell.configure(jitser: jitsers[indexPath.row])
        return cell
    }
}

extension SearchJitserViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print(searchText)
    }
}
