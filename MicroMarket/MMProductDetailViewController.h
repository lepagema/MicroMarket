//
//  MMProductDetailViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 15.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketDataController;
@class Product;

@interface MMProductDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) Product *product;
@property (weak, nonatomic) MarketDataController *dataController;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@end
