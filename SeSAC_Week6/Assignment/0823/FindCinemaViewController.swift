//
//  FindCinemaViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/23.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit


class FindCinemaViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let map = MKMapView()
    let locationButton = {
        let view = UIButton()
        view.setTitle("위치 가져오기", for: .normal)
        view.setTitleColor(UIColor.systemBrown, for: .normal)
//        view.backgroundColor = .systemBrown
        return view
    }()
    let cinemaButton = {
        let view = UIButton()
        view.setTitle("영화관 선택", for: .normal)
        view.setTitleColor(UIColor.systemGreen, for: .normal)
        return view
    }()
    let list = TheaterList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(locationButton)
        view.addSubview(cinemaButton)
        view.addSubview(map)
        locationButton.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        cinemaButton.addTarget(self, action: #selector(selectCinemaAlert), for: .touchUpInside)
        
        setConstraints()
    
        locationManager.delegate = self
        
        setAllAnnotaion()
    }
    
    @objc func getLocation() {
        if locationManager.authorizationStatus == .denied {
            alertToFail()
        } else {
            checkDeviceLocationAuthorization()
        }
    }
    @objc func selectCinemaAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megabox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.setSeletedAnnotation(type: "메가박스")
        }
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.setSeletedAnnotation(type: "롯데시네마")
        }
        let CGV = UIAlertAction(title: "CGV", style: .default) { _ in
            self.setSeletedAnnotation(type: "CGV")
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.setAllAnnotaion()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(megabox)
        alert.addAction(lotteCinema)
        alert.addAction(CGV)
        alert.addAction(all)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func setConstraints() {
        map.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.height.equalTo(40)
        }

        cinemaButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.top.equalTo(locationButton.snp.top)
            make.height.equalTo(40)
        }
    }
    
    //디바이스 위치 권한 확인 - 활성화 되어있으면 열거형(코드) 확인해서 상태별 할일 정해주고, 비활성화면 얼럿 띄우기
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization = self.locationManager.authorizationStatus
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                print("설정으로 이동")
            }
        }
    }
    //코드 확인해서 상태에 따라 할일 주기
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            let sesac = CLLocationCoordinate2D(latitude: 37.517789, longitude: 126.886245)
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            print("default")
        }
    }
    
    //====================================================================================================
    
    func setRegion(center: CLLocationCoordinate2D) {
        //중심지와 축척(m) 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 300, longitudinalMeters: 300)
        map.setRegion(region, animated: true)
    }
    
    func setAllAnnotaion() {
        map.removeAnnotations(map.annotations)
        for item in list.mapAnnotations {
            let annotation = MKPointAnnotation()
            annotation.title = item.location
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            map.addAnnotation(annotation)
        }
    }
    
    func setSeletedAnnotation(type: String) {
        map.removeAnnotations(map.annotations)
        for item in list.mapAnnotations {
            let annotation = MKPointAnnotation()
            
            if item.type == type {
                annotation.title = item.location
                annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                map.addAnnotation(annotation)
            }
        }
    }
    
    
    
    func alertToFail() {
        let alert = UIAlertController(title: "위치 정보", message: "위치 정보를 가져오는 데 실패했습니다. 설정에서 위치 정보를 활성화해주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
}

extension FindCinemaViewController: CLLocationManagerDelegate {
    
    //권한 정보가 변경된 경우 - iOS14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
    
    //위치 업데이트 성공한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        setRegion(center: coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    //위치 못가져온 경우
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //얼럿 띄우기
//        alertToFail()
//    }
    
}

