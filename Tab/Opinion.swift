//
//  ChildViewController2.swift
//  Tab
//
//  Created by kjs-mac03 on 2017/11/20.
//  Copyright © 2017 Radio Treetal Bangla. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Opinion: UIViewController, IndicatorInfoProvider
{
    @IBOutlet weak var txtOpinion: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblHeading: UILabel!
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo
    {
        return IndicatorInfo(title : "YOUR OPINION")
    }

    override func viewDidLoad()
    {
        setOpinionIcon()
        setNameIcon()
        setAddressIcon()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setNameIcon()
    {
        //txtName.textConte = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        txtName.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon_name")
        imageView.image = image
        txtName.leftView = imageView
        
    }
    
    func setOpinionIcon()
    {
        //txtName.textConte = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        txtOpinion.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon_message")
        imageView.image = image
        txtOpinion.leftView = imageView
        
    }
    
    func setAddressIcon()
    {
        //txtName.textConte = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        txtAddress.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon_address")
        imageView.image = image
        txtAddress.leftView = imageView
        
    }
}
