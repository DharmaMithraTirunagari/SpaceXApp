//
//  MissionViewModel.swift
//  SpaceXApp
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import Foundation

class MissionViewModel {
    private(set) var missions: [Mission] = []
    var reloadTableView: (() -> Void)?
    
//    let networkManager: APIManagerProtocol?
//    
//    init(networkManager: APIManagerProtocol?) {
//        self.networkManager = networkManager
//    }

    func fetchMissions() {
        APIManager.shared.fetchMissions { [weak self] result in
            switch result {
            case .success(let missions):
                self?.missions = missions
                DispatchQueue.main.async {
                    self?.reloadTableView?()
                }
            case .failure(let error):
                print("Error fetching missions: \(error.localizedDescription)")
            }
        }
    }

    func mission(for index: Int) -> Mission {
        return missions[index]
    }

    func numberOfMissions() -> Int {
        return missions.count
    }
}
