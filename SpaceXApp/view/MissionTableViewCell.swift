//
//  MissionTableViewCell.swift
//  SpaceXApp
//
//  Created by Srikanth Kyatham on 12/11/24.
//


import UIKit

class MissionTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    let missionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let missionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let launchDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add UI components
        contentView.addSubview(missionImageView)
        contentView.addSubview(missionTitleLabel)
        contentView.addSubview(rocketNameLabel)
        contentView.addSubview(launchDateLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            missionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            missionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            missionImageView.heightAnchor.constraint(equalToConstant: 60),
            missionImageView.widthAnchor.constraint(equalToConstant: 60),
            
            missionTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            missionTitleLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: 10),
            missionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            rocketNameLabel.topAnchor.constraint(equalTo: missionTitleLabel.bottomAnchor, constant: 5),
            rocketNameLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: 10),
            rocketNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            launchDateLabel.topAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor, constant: 5),
            launchDateLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: 10),
            launchDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            launchDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(with mission: Mission) {
        missionTitleLabel.text = mission.missionName
        rocketNameLabel.text = mission.rocket.rocketName
        launchDateLabel.text = "Launched on: \(mission.launchDateUTC)"
        
        if let imageUrlString = mission.links.missionPatch, let imageUrl = URL(string: imageUrlString) {
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

