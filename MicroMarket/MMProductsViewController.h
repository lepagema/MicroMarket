//
//  MMProductsViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketDataController;

@interface MMProductsViewController : UITableViewController
{
//    NSMutableArray *products;
//    NSManagedObjectContext *managedObjectContext;
}

@property (weak, nonatomic) MarketDataController *dataController;

//@property (nonatomic, copy) NSMutableArray *products;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)buttonTouchUpInside:(id)sender;

@end
