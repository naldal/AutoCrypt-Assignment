//
//  VaccinationCenterMapViewController.swift
//  AutoCrypt-Assignment
//
//  Created by 송하민 on 2022/06/23.
//

import MapKit
import SnapKit
import Action
import RxCoreLocation
import RxSwift
import UIKit

class VaccinationCenterMapViewController: BaseViewController,
BaseViewControllerType,
                                          ViewModelBindableType {
    
    var viewModel: VaccinationCenterMapViewModel!
    
    // MARK: - Component
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    /// 지도 뷰
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    /// 현재위치로 버튼
    private lazy var moveCurrentPositionButton: UIButton = {
        let button = UIButton()
        button.setTitle("move_to_current_position".localized,
                        for: .normal)
        button.backgroundColor = .pastelBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    /// 접종센터로 버튼
    private lazy var moveVaccinationCenterButton: UIButton = {
        let button = UIButton()
        button.setTitle("move_to_center_position".localized,
                        for: .normal)
        button.backgroundColor = .pastelRed
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNaviView(colorType: .black)
        self.naviView.setNaviTitle(title: "map".localized)
        self.setNavigationBackgroundColor(bgColor: .whiteF3)
        
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "",
                                                                 image: UIImage(systemName: "chevron.backward"),
                                                                 primaryAction: nil,
                                                                 menu: nil)
        
        configureLayout()
        setConstraint()
        
        configureLocationManager()
        configureMKMap()
    }
    
    
    // MARK: - Private
    
    private var locationManager = CLLocationManager()
    private var currentUserLocation = CLLocation()
    private let annotation = MKPointAnnotation()
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 3
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    private func configureMKMap() {
        self.mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    private func move(to location: CLLocation, isCenter: Bool = false, pinTitle title: String = "") {
        if isCenter {
            self.makePin(to: location, title: title)
        }
        let targetLocation = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: Constants.Map.MAP_ZOOM_SCALE,
                                                longitudinalMeters: Constants.Map.MAP_ZOOM_SCALE)
        mapView.setRegion(targetLocation, animated: false)
    }
    
    private func makePin(to location: CLLocation, title: String) {
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        annotation.title = title
        mapView.addAnnotation(self.annotation)
    }
    
    
    
    // MARK: - Layout
    
    func configureLayout() {
        self.view.addSubview(baseView)
        
        [mapView,
         moveCurrentPositionButton,
         moveVaccinationCenterButton]
            .forEach{baseView.addSubview($0)}
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        baseView.snp.makeConstraints { make in
            make.top.equalTo(self.naviView.snp.bottom)
            make.width.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        moveVaccinationCenterButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30+Constants.DeviceScreen.SAFE_AREA_BOTTOM)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        moveCurrentPositionButton.snp.makeConstraints { make in
            make.bottom.equalTo(moveVaccinationCenterButton.snp.top).offset(-5)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
        
        
    }
    
    // MARK: - Bind
    
    func bindViewModel() {
        let input = viewModel.input
        let output = viewModel.output
        
        func moveVaccinationCenter() {
            input.moveToVaccinationCenterAction.execute()
                .subscribe(onNext: { [weak self] centerInformation in
                    guard let self = self,
                          let centerLat = Double(centerInformation.lat),
                          let centerLng = Double(centerInformation.lng) else {
                        return
                    }
                    let centerLocation = CLLocation(latitude: centerLat,
                                                    longitude: centerLng)
                    self.move(to: centerLocation,
                              isCenter: true,
                              pinTitle: centerInformation.centerName)
                })
                .disposed(by: self.disposeBag)
        }
        
        // MARK: Input
        
        self.locationManager.rx.didChangeAuthorization
            .subscribe(onNext: { (_, status) in
                switch status {
                case .authorizedAlways, .authorizedWhenInUse:
                    moveVaccinationCenter()
                default:
                    print("no authorized!")
                    return
                }
            })
            .disposed(by: self.disposeBag)
        
        self.navigationItem.leftBarButtonItem?.rx.tap
            .subscribe(onNext: { _ in
                input.backAction.execute()
            })
            .disposed(by: self.disposeBag)
        
        moveCurrentPositionButton.rx.tap
            .subscribe(onNext: { _ in
                self.move(to: self.currentUserLocation)
            })
            .disposed(by: self.disposeBag)
        
        
        moveVaccinationCenterButton.rx.tap
            .subscribe(onNext: { _ in
                moveVaccinationCenter()
            })
            .disposed(by: self.disposeBag)
        
        
        // MARK: Output
        
        output.centerInformation
            .subscribe(onNext: { [weak self] centerInformation in
                guard let self = self,
                      let centerLat = Double(centerInformation.lat),
                      let centerLng = Double(centerInformation.lng) else {
                    return
                }
                let centerLocation = CLLocation(latitude: centerLat,
                                                longitude: centerLng)
                self.move(to: centerLocation,
                          isCenter: true,
                          pinTitle: centerInformation.centerName)
        })
        .disposed(by: self.disposeBag)
        
        
    }
    
}

extension VaccinationCenterMapViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first {
            let currentLatitude = currentLocation.coordinate.latitude
            let currentLongitude = currentLocation.coordinate.longitude
            self.currentUserLocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error occured : \(error)")
    }
}

extension VaccinationCenterMapViewController: MKMapViewDelegate {}
