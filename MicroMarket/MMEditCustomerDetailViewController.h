//
//  MMEditCustomerDetailViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 18.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCustomer;

@interface MMEditCustomerDetailViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) MMCustomer *customer;
@property (nonatomic, copy) NSMutableArray *products;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end
