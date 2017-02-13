//
//  PageControlViewController.swift
//  greenbankDemo
//
//  Created by Gaurav Chaturvedi on 1/24/17.
//  Copyright © 2017 Gaurav Chaturvedi. All rights reserved.
//

import UIKit

class Account {
    
    var balance = 0
    var type = ""
    var number = 0
    
    func setAccountDetails (type: String, balance: Int, number: Int) {
        self.balance = balance
        self.type = type
        self.number = number
    }
    
}

var a = Account()
var b = Account()
var c = Account()

var accounts = [a, b, c]

class PageControlViewController: UIViewController {
    
    // UI Hooks
    @IBOutlet weak var typeOfAccountLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var transferButton: UIButton!
    
    // create swipe gesture
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    // outlet - page control
    @IBOutlet var myPageControl: UIPageControl!
    
    
    // MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        a.setAccountDetails(type: "Savings", balance: 1000, number: 123123)
        b.setAccountDetails(type: "Current", balance: 100, number: 456456)
        c.setAccountDetails(type: "Third Type", balance: 200, number: 789789)
        
        // Set number of pages/dots of PageControl
        self.myPageControl.numberOfPages = accounts.count
        
        // Setting border on type of acocunt and account number label
        self.payButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor.gray, thickness: 1)
        self.payButton.layer.addBorder(edge: UIRectEdge.right, color: UIColor.gray, thickness: 0.5)
        self.transferButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor.gray, thickness: 1)
        self.transferButton.layer.addBorder(edge: UIRectEdge.left, color: UIColor.gray, thickness: 1)
        self.transferButton.layer.addBorder(edge: UIRectEdge.right, color: UIColor.gray, thickness: 1)
        self.buyButton.layer.addBorder(edge: UIRectEdge.top, color: UIColor.gray, thickness: 1)
        self.buyButton.layer.addBorder(edge: UIRectEdge.left, color: UIColor.gray, thickness: 0.5)
        // self.typeOfAccountLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.gray, thickness: 1)
        // self.accountNumberLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.gray, thickness: 1)
        
        // set gesture direction
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        
        // add gesture target
        self.swipeGestureLeft.addTarget(self, action: #selector(PageControlViewController.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(PageControlViewController.handleSwipeRight(_:)))
        
        // add gesture in to view
        self.view.addGestureRecognizer(self.swipeGestureLeft)
        self.view.addGestureRecognizer(self.swipeGestureRight)
        
        // set current page number label.
        self.setCurrentPageLabel()
        
        // Calling API to fetch data
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = NSURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/posts/1")! as URL)
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                let response = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print(response!)
            }
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Utility function
    
    // increase page number on swift left
    func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        if self.myPageControl.currentPage < 2 {
            self.myPageControl.currentPage += 1
            self.setCurrentPageLabel()
        }
    }
    
    // reduce page number on swift right
    func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        
        if self.myPageControl.currentPage != 0 {
            self.myPageControl.currentPage -= 1
            self.setCurrentPageLabel()
        }
        
        
    }
    
    // set current page number label
    fileprivate func setCurrentPageLabel(){
        self.accountBalanceLabel.text = "\(accounts[self.myPageControl.currentPage].balance)"
        self.typeOfAccountLabel.text = "\(accounts[self.myPageControl.currentPage].type)"
        self.accountNumberLabel.text = "\(accounts[self.myPageControl.currentPage].number)"
    }
    
}
