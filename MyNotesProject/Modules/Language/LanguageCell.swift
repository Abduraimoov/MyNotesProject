//
//  LanguageCell.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/20/24.
//

import UIKit
import SnapKit

struct Language {
    var image: String
    var title: String
}

class LanguageCell: UITableViewCell {
    
    static var reuseID = "Language_cell"
    
    private lazy var IconImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(language: Language) {
        IconImage.image = UIImage(named: language.image)
        titleLabel.text = language.title
    }
    
    private func setupContrains() {
        addSubview(IconImage)
        IconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
