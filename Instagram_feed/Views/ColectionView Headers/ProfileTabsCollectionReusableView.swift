//
//  ProfileTabsCollectionReusableView.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 3/4/23.
//

import UIKit


protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapTaggedButton()
    func didTapGridButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate : ProfileTabsCollectionReusableViewDelegate?
    
    
    struct Constants {
        static let padding: CGFloat = 16
        
    }
    
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemGray2
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        addButtonActions()
        clipsToBounds = true
    }
    
    private func addButtonActions(){
        
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
        
    }
    
    
    @objc private func didTapGridButton(){
        gridButton.tintColor = .label
        taggedButton.tintColor = .systemGray2
        delegate?.didTapTaggedButton()
    }
    @objc private func didTapTaggedButton(){
        gridButton.tintColor = .systemGray2
        taggedButton.tintColor = .label
        
        delegate?.didTapGridButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let setSize = height - (Constants.padding * 2)
        let gridButtonX = ((width/2)-setSize)/2
        
        
        gridButton.frame  = CGRect(
            x:gridButtonX,
            y: Constants.padding,
            width: setSize ,
            height:  setSize
        ).integral
        
        taggedButton.frame  = CGRect(
            x:gridButtonX + (width/2) ,
            y:Constants.padding,
            width:setSize,
            height:setSize
        ).integral
        

    }
}
