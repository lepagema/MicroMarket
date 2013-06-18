//
//  MMAddCustomerDetailViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 18.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCustomer;

@interface MMAddCustomerDetailViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) MMCustomer *customer;

@property (weak, nonatomic) IBOutlet UITextField *customerTextField;

@end
