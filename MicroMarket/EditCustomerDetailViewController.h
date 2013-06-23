//
//  EditCustomerDetailViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 18.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketDataController;
@class Customer;

@interface EditCustomerDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) Customer *customer;
@property (weak, nonatomic) MarketDataController *dataController;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *paymentTextField;

@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *procuctCountLabel;
@property (weak, nonatomic) IBOutlet UIStepper *productStepper;

@end
