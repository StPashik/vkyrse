//
//  MainViewController.swift
//  vkyrse
//
//  Created by StPashik on 29.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var currencyTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var percentsLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
//        Currency.getCurrency("USD", compare: "RUB") { (currency) in
//            
//        }
        
        Currency.getCurrency("USD", compare: "RUB", complete: { (currency) in
            
        }) { (error) in
            
            self.showErrorAlert(error.localizedDescription)
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Private methods
    
    private func showErrorAlert(message: String)
    {
        
    }
    
    //MARK: - IBActions
    
    @IBAction func compareMenuTouch(sender: UIButton)
    {
        
    }

}
