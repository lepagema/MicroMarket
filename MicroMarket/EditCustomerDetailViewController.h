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

@end
