//
//  CustomTableViewCell.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/1/24.
//

import UIKit
import SnapKit

protocol ThemeSwitchDelegate: AnyObject {
    func themeSwitchDidToggle(isOn: Bool)
}

struct Settings {
    var titleLabel: String
    var leftImage: String
}

class CustomTableViewCell: UITableViewCell {
    
    weak var delegate: ThemeSwitchDelegate?
    
    static var SetupID = "note_cell"
    
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel = UILabel()
    
    var languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitle("Languages", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .label
        return button
    }()
    
    var buttonSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "Theme")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSwitch()
        contentView.backgroundColor = .secondarySystemBackground
        languageButton.setTitle("Languages".localized(), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
    
    func setup(image: UIImage) {
        leftImageView.image = image
    }
    
    private func setupSwitch() {
        buttonSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        delegate?.themeSwitchDidToggle(isOn: sender.isOn)
    }
    
    func setup(settings: Settings, isDarkMode: Bool) {
        titleLabel.text = settings.titleLabel
        let iconImage = UIImage(systemName: settings.leftImage)?.withRenderingMode(.alwaysTemplate)
        leftImageView.image = iconImage
        let contentColor = isDarkMode ? UIColor.white : UIColor.black
        leftImageView.tintColor = contentColor
        titleLabel.textColor = contentColor
    }
    
    private func setupView() {
        contentView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.height.width.equalTo(24)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(leftImageView.snp.trailing).offset(13)
        }
        
        contentView.addSubview(languageButton)
        languageButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-25)
        }
        
        contentView.addSubview(buttonSwitch)
        buttonSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-25)
        }
    }
    
}
