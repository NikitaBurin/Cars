//
//  View.swift
//  Cars
//
//  Created by Никита Бурин on 13.01.2023.
//

import UIKit

class View: UIView {
    
    var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: carsArray)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.backgroundColor = .clear
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(nil, action: #selector(ViewController.segmentedPressed), for: .valueChanged)
        return segmented
    }()
    
    var markLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mark"
        label.font = UIFont(name: "Arial-BoldMT", size: 22)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var modelLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Model"
        label.font = UIFont(name: "Arial-BoldMT", size: 28)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var lastTimeStartedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Last time started:"
        return label
    }()
    
    var numberOfTripsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number of trips:"
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating:"
        return label
    }()
    
    var myChoiceImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "myChoice"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var startEngineButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start engine", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.addTarget(nil, action: #selector(ViewController.startEnginePressed), for: .touchUpInside)
        return button
    }()
    
    var rateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Rate", for: .normal)
        button.tintColor = .red
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.addTarget(nil, action: #selector(ViewController.rateItPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(segmentedControl)
        addSubview(markLabel)
        addSubview(modelLabel)
        addSubview(carImageView)
        addSubview(lastTimeStartedLabel)
        addSubview(numberOfTripsLabel)
        addSubview(ratingLabel)
        addSubview(myChoiceImageView)
        addSubview(startEngineButton)
        addSubview(rateButton)
        
        NSLayoutConstraint.activate([
            markLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            markLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            modelLabel.topAnchor.constraint(equalTo: markLabel.bottomAnchor, constant: 10),
            modelLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            carImageView.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 30),
            carImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            carImageView.heightAnchor.constraint(equalToConstant: 200),
            carImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            carImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            
            lastTimeStartedLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 30),
            lastTimeStartedLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            
            ratingLabel.centerYAnchor.constraint(equalTo: lastTimeStartedLabel.centerYAnchor),
            ratingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            
            numberOfTripsLabel.topAnchor.constraint(equalTo: lastTimeStartedLabel.bottomAnchor, constant: 5),
            numberOfTripsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            
            segmentedControl.topAnchor.constraint(equalTo: numberOfTripsLabel.bottomAnchor, constant: 30),
            segmentedControl.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            segmentedControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            myChoiceImageView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            myChoiceImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            myChoiceImageView.widthAnchor.constraint(equalToConstant: 100),
            myChoiceImageView.heightAnchor.constraint(equalToConstant: 100),
            
            startEngineButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startEngineButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            startEngineButton.widthAnchor.constraint(equalToConstant: 130),
            startEngineButton.heightAnchor.constraint(equalToConstant: 30),
            
            rateButton.centerYAnchor.constraint(equalTo: startEngineButton.centerYAnchor),
            rateButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            rateButton.widthAnchor.constraint(equalToConstant: 130),
            rateButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
