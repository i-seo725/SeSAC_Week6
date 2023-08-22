//
//  LocationViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/22.
//

import UIKit
import CoreLocation //1. 프레임워크 import

class LocationViewController: UIViewController {

    //2. 위치 매니저 생성: 위치에 대한 대부분 담당, class 인스턴스 생성
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //3. 위치 프로토콜 연결
        locationManager.delegate = self
        view.backgroundColor = .white
        
        //info.plist 설정한 항목 가져오기, 거기 설정한 값으로 alert 문구 띄워짐
//        locationManager.requestWhenInUseAuthorization()
        checkDeviceLocationAuthorization()
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
                self.checkCurrentLocationAuthrization(status: authorization)
                
            } else {
                print("위치 서비스가 꺼져 있어서 권한 요청 못함")
            }
        }
    }
    
    
    func checkCurrentLocationAuthrization(status: CLAuthorizationStatus) {
        print("check", status)
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest   //위치 정확도 설정
            locationManager.requestWhenInUseAuthorization()             //alert 띄우기
            
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //didUpdateLocation 메서드 실행
            locationManager.startUpdatingLocation() //권한이 허용 됐을 때만 요청 가능
        case .authorized:
            print("authorized")
        }
    }
    
    
    
    
}



//4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {

    //5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
    }

    //6. 사용자의 위치를 가져오지 못한 경우(권한 거부된 경우 포함)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }


    //사용자의 권한 상태가 바뀔 때를 알려줌
    //거부했다가 설정에서 변경 했거나, notDetermined 상태에서 허용 했거나, 허용해서 위치를 가져오는 도중 설정에서 거부로 바꾸고 앱으로 돌아올 때 등
    //iOS14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()  //이 메서드는 권한이 바뀐 것만 알고 어떤 걸로 바뀌었는지 몰라서 체크하는 메서드 실행 필요
    }

    //사용자의 권한 상태가 바뀔 때를 알려줌
    //iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
