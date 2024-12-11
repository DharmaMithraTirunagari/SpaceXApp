//
//  MissiondetailViewController.swift
//  SpaceXApp
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit

class MissionDetailViewController: UIViewController {
    
    // MARK: - Properties
    var mission: Mission?
    
    // MARK: - UI Components
    private let missionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let missionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let launchDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureMissionDetails()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(missionImageView)
        view.addSubview(missionNameLabel)
        view.addSubview(rocketNameLabel)
        view.addSubview(launchDateLabel)
        view.addSubview(detailsTextView)
        
        NSLayoutConstraint.activate([
            missionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            missionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            missionImageView.heightAnchor.constraint(equalToConstant: 150),
            missionImageView.widthAnchor.constraint(equalToConstant: 150),
            
            missionNameLabel.topAnchor.constraint(equalTo: missionImageView.bottomAnchor, constant: 20),
            missionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            missionNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            rocketNameLabel.topAnchor.constraint(equalTo: missionNameLabel.bottomAnchor, constant: 10),
            rocketNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rocketNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            launchDateLabel.topAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor, constant: 10),
            launchDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            launchDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            detailsTextView.topAnchor.constraint(equalTo: launchDateLabel.bottomAnchor, constant: 20),
            detailsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailsTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure Mission Details
    private func configureMissionDetails() {
        guard let mission = mission else { return }
        
        missionNameLabel.text = mission.missionName
        rocketNameLabel.text = "Rocket: \(mission.rocket.rocketName)"
        launchDateLabel.text = "Launched on: \(mission.launchDateUTC)"
        detailsTextView.text = mission.details ?? "No details available"
        
        if let imageUrl = URL(string: mission.links.missionPatch!) {
            downloadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.missionImageView.image = image
                }
            }
        } else {
            missionImageView.image = UIImage(named: "placeholder")
        }
    }
    
    // MARK: - Image Downloading
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}
