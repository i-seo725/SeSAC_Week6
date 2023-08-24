//
//  LocationViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/22.
//

import UIKit
import CoreLocation //1. 프레임워크 import
import MapKit
import SnapKit

class LocationViewController: UIViewController {

    //2. 위치 매니저 생성: 위치에 대한 대부분 담당, class 인스턴스 생성
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    let cafeButton = UIButton()
    let foodButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //3. 위치 프로토콜 연결
        locationManager.delegate = self
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(50)
        }
        
        cafeButton.backgroundColor = .purple
        cafeButton.addTarget(self, action: #selector(cafeButtonClicked), for: .touchUpInside)
        view.addSubview(cafeButton)
        cafeButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.size.equalTo(50)
            make.leading.equalTo(view).offset(100)
        }
        
        foodButton.backgroundColor = .systemPurple
        view.addSubview(foodButton)
        foodButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.size.equalTo(50)
            make.trailing.equalTo(view).offset(-100)
        }
        
        
        let center = CLLocationCoordinate2D(latitude: 37.541605, longitude: 127.057004)
        setRegionAndAnnotaion(center: center)
        
        setAnotation(type: 0)
        
        //두번 실행돼도 실행 안되면 안되니까 viewDidLoad에 넣어주기
//        checkDeviceLocationAuthorization()
    }
    
    @objc func cafeButtonClicked() {
        setAnotation(type: 1)
        print("ddd")
    }
    
    @objc func foodButtonClicked() {
        print("음식 버튼 클릭")
    }
    
    
    
    
    
    func setAnotation(type: Int) {
//            37.555770, 127.078391 //메가박스
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 37.555770, longitude: 127.078391)
        
        //37.549247, 127.080606 //어린이대공원
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.549247, longitude: 127.080606)
        
        if type == 0 {  //viewDidLoad 상태, 어노테이션 두개 다 있음
            mapView.addAnnotations([annotation1, annotation2])
        } else if type == 1 {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(annotation2)
        }
    }
    
    
    
    
    func setRegionAndAnnotaion(center: CLLocationCoordinate2D) {
        //지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 300, longitudinalMeters: 300)
        mapView.setRegion(region, animated: true)
        
        //어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = "목적지"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호 > 위치 서비스'를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func checkDeviceLocationAuthorization() {
        //iOS 위치 서비스 활성화 여부 체크, main thread에서 실행 시키면 안됨
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                //현재 사용자의 위치 권한 상태 가져오기(열거형)
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                print(authorization)
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthrization(status: authorization)
                }
                
            } else {
                print("위치 서비스가 꺼져 있어서 권한 요청 못함")
            }
        }
    }
    func checkCurrentLocationAuthrization(status: CLAuthorizationStatus) {
        print("check", status)
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest   //위치 업데이트 정확도 설정
            locationManager.requestWhenInUseAuthorization()             //alert 띄우기, InfoPlist - WhenInUse 설정 필요
            
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //didUpdateLocation 메서드 실행
            locationManager.startUpdatingLocation() //권한이 허용 됐을 때만 요청 가능
        case .authorized:
            print("authorized")
        @unknown default:   //케이스는 다 썼지만, 위치 권한 종류가 늘어날 수도 있는 상황(애플이 추가) 대비
            print("default")
        }
    }
    
}



//4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {

    //5. 사용자의 위치를 성공적으로 가지고 온 경우
    //한번만 실행되지 않음 - iOS 위치 업데이트가 필요한 시점에 알아서 여러번 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(#function, locations)
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotaion(center: coordinate)
            print(coordinate)
        }
        
        //한번만 위치 받아오고 싶으면 스탑 해주기
        locationManager.stopUpdatingLocation()
    }

    //6. 사용자의 위치를 가져오지 못한 경우(권한 거부된 경우 포함)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }


    //사용자의 권한 상태가 바뀔 때 알려줌
    //거부했다가 설정에서 변경 했거나, notDetermined 상태에서 허용 했거나, 허용해서 위치를 가져오는 도중 설정에서 거부로 바꾸고 앱으로 돌아올 때 등
    //iOS14 이상
    //뷰가 보일 때 바로 실행된다고 명시적으로 나와있지 않지만 혼자 자동으로 나옴
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()  //이 메서드는 권한이 바뀐 것만 알고 어떤 걸로 바뀌었는지 몰라서 체크하는 메서드 실행 필요
    }

    //사용자의 권한 상태가 바뀔 때를 알려줌
    //iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}


extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print(#function)
//
//    }
}
