//
//  ViewController.swift
//  MapRouter
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 29.08.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private let addAdress: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let routerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ROUTE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("RESET", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        addAdress.addTarget(self, action: #selector(addAdressTapped), for: .touchUpInside)
        routerButton.addTarget(self, action: #selector(routerButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)

    }
    
    @objc func addAdressTapped() {
        alertAddAdress(title: "Add", placeholder: "") { textfieldText in
            //
        }
    }
    
    @objc func routerButtonTapped() {
        
    }
    
    @objc func resetButtonTapped() {
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addAdress.layer.cornerRadius = addAdress.frame.height / 2
    }

}


extension ViewController {
    
    func setConstraints() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        mapView.addSubview(addAdress)
        
        NSLayoutConstraint.activate([
            addAdress.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAdress.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAdress.heightAnchor.constraint(equalToConstant: 50),
            addAdress.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        mapView.addSubview(routerButton)
        
        NSLayoutConstraint.activate([
            routerButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 30),
            routerButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -50),
            routerButton.widthAnchor.constraint(equalToConstant: 130),
            routerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        mapView.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -30),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -50),
            resetButton.widthAnchor.constraint(equalToConstant: 130),
            resetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

import SwiftUI

struct ViewController_Provider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            ViewController()
            
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
