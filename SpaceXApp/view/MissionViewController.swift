//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit

class MissionViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = MissionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchMissions()
    }

    private func setupUI() {
        title = "Missions"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MissionTableViewCell.self, forCellReuseIdentifier: "MissionCell")
    }

    private func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MissionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMissions()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MissionCell", for: indexPath) as? MissionTableViewCell else { return UITableViewCell()}
        let mission = viewModel.mission(for: indexPath.row)
        cell.configure(with: mission)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mission = viewModel.mission(for: indexPath.row)
        let detailVC = MissionDetailViewController()
        detailVC.mission = mission
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

