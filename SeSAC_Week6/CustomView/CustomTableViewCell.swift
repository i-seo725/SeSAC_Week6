//
//  CustomTableViewCell.swift
//  SeSAC_Week6
//
//  Created by 이은서 on 2023/08/25.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {

    let label = UILabel()
    let button = UIButton()
    
    
    //초기화할 때 어떤 스타일 쓸지, 아이디 머 쓸지
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints() //addSubView이후에 제약조건 설정
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        //view.addSubview 아님, 테이블뷰셀은 그냥 뷰 안 가지고 있음
        contentView.addSubview(label)
        contentView.addSubview(button)
        label.backgroundColor = .systemYellow
        button.backgroundColor = .systemGreen
    }
    
    func setConstraints() {
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.trailingMargin.equalTo(contentView)
        }
        
        label.snp.makeConstraints { make in
            make.top.leadingMargin.bottom.equalTo(contentView)
            make.trailing.equalTo(button.snp.leading).inset(8)
        }
    }
    
    //Interface Builder 상에서 제작했을 때만 동작(XIB -> NIB)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
