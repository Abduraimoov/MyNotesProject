//
//  OnBoardCell.swift
//  MyNotesProject
//
//  Created by Nurtilek on 3/8/24.
//

import UIKit

class OnBoardCell: UICollectionViewCell {
    
    static var reuseID = "One_Board_cell"
    
    let myImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let myLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .light)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(secondLabel)
        addSubview(myLabel)
        addSubview(myImage)
        NSLayoutConstraint.activate([
            secondLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -370),
            secondLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            secondLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            
            myLabel.bottomAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: -60),
            myLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            myImage.bottomAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: -52),
            myImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 89.2),
            myImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -89.2),
            myImage.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: StructBoardings) {
        myImage.image = UIImage(named: data.image)
        myLabel.text = data.label
        secondLabel.text = data.secondLabel
    }
    
}

