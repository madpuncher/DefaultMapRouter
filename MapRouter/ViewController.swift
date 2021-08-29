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
    
    private var annotationsArray = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        addAdress.addTarget(self, action: #selector(addAdressTapped), for: .touchUpInside)
        routerButton.addTarget(self, action: #selector(routerButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        mapView.delegate = self

    }
    
    @objc func addAdressTapped() {
        alertAddAdress(title: "Add", placeholder: "") { [self] textfieldText in
            setupPlacemark(addressPlace: textfieldText)
        }
    }
    
    @objc func routerButtonTapped() {
        
        for index in 0...annotationsArray.count - 2 {
            
            createDirectionRequest(startCoordinate: annotationsArray[index].coordinate, destination: annotationsArray[index + 1].coordinate)
        }
        
    }
    
    @objc func resetButtonTapped() {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray = [MKPointAnnotation]()
        routerButton.isHidden = true
        resetButton.isHidden = true 
    }
    
    private func setupPlacemark(addressPlace: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressPlace) { [self] placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                alertError(title: "ERROR", message: "WE CANT FIND YOUR PLACE")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = addressPlace
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 2 {
                routerButton.isHidden = false
                resetButton.isHidden = false
            }
                        
            mapView.showAnnotations(annotationsArray, animated: true)
        }
    }
    
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destionationLocation = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destionationLocation)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response else { return }
            
            var minRoute = response.routes[0]
            
            for route in response.routes {
                minRoute = route.distance < minRoute.distance ? route : minRoute
            }
            
            self.mapView.addOverlay(minRoute.polyline)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addAdress.layer.cornerRadius = addAdress.frame.height / 2
    }

}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .red
        return renderer
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
