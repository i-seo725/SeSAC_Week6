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
        view.tintColor = .systemBlue
        view.backgroundColor = .systemBrown
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(locationButton)
        view.addSubview(map)
        locationButton.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        
        setConstraints()
        
        locationManager.delegate = self
    }
    
    @objc func getLocation() {
        if locationManager.authorizationStatus == .denied {
            alertToFail()
        } else {
            checkDeviceLocationAuthorization()
        }
    }
    
    func setConstraints() {
        map.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(40)
        }
//        locationButton.backgroundColor = .red
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
            setRegionAndAnnotation(center: sesac)
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
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        //중심지와 축척(m) 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 300, longitudinalMeters: 300)
        map.setRegion(region, animated: true)
        
        //중심지에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = "현재 위치"
        annotation.coordinate = center
        map.addAnnotation(annotation)
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
        setRegionAndAnnotation(center: coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    //위치 못가져온 경우
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //얼럿 띄우기
//        alertToFail()
//    }
    
}

