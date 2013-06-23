//
//  AddCustomerDetailViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 18.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketDataController;

@interface AddCustomerDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) MarketDataController *dataController;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end
