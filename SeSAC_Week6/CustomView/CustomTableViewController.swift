//
//  CustomTableViewController.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/24.
//

import UIKit
import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
}


class CustomTableViewController: UIViewController {

    //클로저 구문이 viewDidLoad보다 먼저 실행
    //CustomTableViewController 인스턴스 생성 전에 클로저 구문 우선 실행
    //viewDidLoad가 실행되는 게 인스턴스가 생성되는 거
    //let으로 선언하면 인스턴스보다 먼저 생성돼서 self 키워드를 쓸 수 없어서 지연 저장 프로퍼티로 사용
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        
        view.delegate = self   //자기 자신의 인스턴스
        view.dataSource = self
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        
        return view
    }()
    //이미지뷰는 영역이고 컨텐츠를 채우는 건 하위 뷰인 UIImage에 넣어야 함, 그래서 서브뷰의 프레임/사이즈 설정 필요
    let imageView = {
//        let view = PosterImageView(frame: .zero)    //zero : width, height, x축, y축 모두 0
        let view = PosterImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return view
    }()
    
    //구조체마다 이 프로퍼티 가지기
//    var isExpand = false
    
    var list = [Sample(text: "aáqqqweqwekjalskdjvnc sddlllll  &&& &&&&&&&&&&&&&&& &&&&&&&&  && & 1123123123 1239", isExpand: false), Sample(text: "ㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂ", isExpand: false), Sample(text: "@@@@@@@@@@@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@", isExpand: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            print("제약조건")
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        //XIB 쓸 땐 불가, 코드베이스에서만 사용하는 코드
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell") //UITableViewCell = 애플이 만들어준 셀
    
    }
    

}


extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.label.text = list[indexPath.row].text
        cell.label.numberOfLines = list[indexPath.row].isExpand ? 0 : 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list[indexPath.row].isExpand.toggle()
        
        //IndexPath(row: 1, section: 0) -> 특정 셀 리로드
        tableView.reloadRows(at: [indexPath], with: .left)
    }
    
    
}
