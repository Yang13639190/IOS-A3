//
//  classTeamCell.swift
//  IOS Assignment3
//
//  Created by 贺欢 on 21/5/2022.
//

import UIKit

class classTeamCell: UITableViewCell {

    /// 箭头
    var arrowImgView: UIImageView!
    var titleLabel: UILabel!
    var numLabel: UILabel!
    var joinbtn: UIButton!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubviews() {
        self.selectionStyle = .none
        self.arrowImgView = UIImageView.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width - 25, y: 50 / 2 - 25 / 2, width: 25, height: 25))
        self.contentView.addSubview(self.arrowImgView)
        self.arrowImgView.image = UIImage.init(named: "right_arrow")
        
        self.titleLabel = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: UIScreen.main.bounds.size.width - 25 - 10, height: 50))
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.textColor = .gray
        
        self.numLabel = UILabel.init(frame: CGRect.init(x: 110, y: 0, width:  100, height: 50))
        self.contentView.addSubview(self.numLabel)
        self.numLabel.font = UIFont.systemFont(ofSize: 16)
        self.numLabel.textColor = .black
        
        self.joinbtn = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width - 120, y: 10, width:  100, height: 30))
        self.contentView.addSubview(self.joinbtn)
    }
    
    func fillCellWith (indexPath: NSIndexPath){
        
        self.titleLabel.text = "Class Team"+String(indexPath.row+1)
        self.titleLabel.frame = CGRect.init(x: 10, y: 0, width: 100, height: 50)
        self.numLabel.text = "One less"
        self.numLabel = UILabel.init(frame: CGRect.init(x: 110, y: 0, width:  100, height: 50))
        self.arrowImgView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
    
        self.joinbtn.frame = CGRect.init(x: UIScreen.main.bounds.size.width - 120, y: 10, width: 100, height: 30)
        //设置背景颜色

        self.joinbtn.backgroundColor = UIColor.blue

       //设置btn 字体大小

        self.joinbtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)

       //设置btn 的文字

        self.joinbtn.setTitle("join", for: UIControl.State.normal)


      
    }
    
    func rotateArrowImgView(_ rotate: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.arrowImgView.transform = CGAffineTransform.init(rotationAngle: rotate)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
