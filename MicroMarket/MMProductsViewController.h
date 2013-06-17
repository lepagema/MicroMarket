//
//  MMProductsViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMMarketDataController;

@interface MMProductsViewController : UITableViewController

@property (weak, nonatomic) MMMarketDataController *dataController;
- (IBAction)buttonTouchUpInside:(id)sender;

@end
