//
//  PurchaseTableViewCell.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 30.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PurchaseItem;

@interface PurchaseTableViewCell : UITableViewCell

@property (strong, nonatomic) PurchaseItem * purchaseItem;

@end
