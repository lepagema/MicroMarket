//
//  MMProductDetailViewController.h
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 15.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMProduct;

enum EProductOperationType {
    AddProduct,
    EditProduct
    };

@interface MMProductDetailViewController : UITableViewController <UITextFieldDelegate>

@property enum EProductOperationType OperationType;
@property (strong, nonatomic) MMProduct * product;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@end
