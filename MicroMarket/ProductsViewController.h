//
//  ProductsViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketDataController;

@interface ProductsViewController : UITableViewController
{
}

@property (weak, nonatomic) MarketDataController *dataController;

@end
