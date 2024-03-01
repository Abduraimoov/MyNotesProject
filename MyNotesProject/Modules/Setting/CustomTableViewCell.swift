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

class CustomTableViewCell: UITableViewCell {
    
    weak var delegate: ThemeSwitchDelegate?

    static var SetupID = "note_cell"
    
    private lazy var languageImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .label
        return image
    }()
    
    private lazy var languegeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitle("Русский", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.tintColor = .label
        return button
    }()
    
    var buttonSwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    private lazy var trashButton: UIButton = {
          var configuration = UIButton.Configuration.plain()
          configuration.attributedTitle = "Очистить данные"
          configuration.image = UIImage(systemName: "trash")
          configuration.imagePlacement = .leading
          configuration.imagePadding = 7
          let view = UIButton(configuration: configuration)
          view.tintColor = .label
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
      }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSwitch()
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    func setup(title: String) {
        languegeLabel.text = title
    }
    
    func setup(image: UIImage) {
        languageImage.image = image
    }
    
    private func setupSwitch() {
        buttonSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }

    @objc private func switchValueChanged(_ sender: UISwitch) {
        delegate?.themeSwitchDidToggle(isOn: sender.isOn)
    }
    
    func setup(title: String, image: UIImage, isDarkMode: Bool = false) {
        languegeLabel.text = title
        languageImage.image = image
        let contentColor = isDarkMode ? UIColor.white : UIColor.black
        languegeLabel.textColor = contentColor
        languageButton.tintColor = contentColor
        trashButton.tintColor = contentColor
    }

    
    private func setupView() {
        contentView.addSubview(languageImage)
        languageImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.height.width.equalTo(24)
        }
        
        contentView.addSubview(languegeLabel)
        languegeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(languageImage.snp.trailing).offset(13)
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
        
        contentView.addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(65)
            make.leading.equalTo(contentView).offset(5)
        }
     
    }

}
