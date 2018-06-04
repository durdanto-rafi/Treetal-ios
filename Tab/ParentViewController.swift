//
//  ParentViewController.swift
//  Tab
//
//  Created by kjs-mac03 on 2017/11/20.
//  Copyright © 2017 Radio Treetal Bangla. All rights reserved.
//

//import the library
import XLPagerTabStrip
import SwiftSpinner


//Delete UIViewController, and Extend //ButtonBarPagerTabStripViewController instead
class ParentViewController: ButtonBarPagerTabStripViewController
{
    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var svBody: UIScrollView!
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    
    override func viewDidLoad()
    {
        setBackgroundImage()
        prepareTabs()
        SwiftSpinner.setTitleFont(UIFont(name: "JuraBook", size: 18.0))
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        return [child_1, child_2]
    }
    
    func prepareTabs()
    {
        if let font = UIFont(name: "JuraBook", size: CGFloat(14.0))
        {
            settings.style.buttonBarItemFont = font
        }
        
        settings.style.buttonBarItemBackgroundColor = UIColor.black.withAlphaComponent(0.2)
        settings.style.selectedBarBackgroundColor = .white
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive =
        {
            [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .white
        }
    }
    
    func setBackgroundImage()
    {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "bg_player")?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor.init(patternImage: image!)
    }
}
