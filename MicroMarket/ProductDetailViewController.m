//
//  ProductDetailViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 15.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "MarketDataController.h"
#import "Product.h"
#import "AmountFormatter.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.product)
    {
        self.nameTextField.text = self.product.name;
        self.priceTextField.text = [AmountFormatter editTextFromAmount:self.product.price];
    }
        
//    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, 60, 25) ];
//
//    [lbl setText:@"Desc: "];
//    [lbl setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
//    [lbl setFont:[UIFont boldSystemFontOfSize:12.0]];
//    
//    [lbl setTextColor:[UIColor magentaColor]]; // BlueColor
//    [lbl setTextAlignment:NSTextAlignmentRight];
//    self.trialTextField.leftView = lbl;
//    self.trialTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.trialTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ReturnProductInput"])
    {
        if (self.nameTextField.text.length && self.priceTextField.text.length)
        {
            NSString *name = self.nameTextField.text;
            NSDecimalNumber *price = [AmountFormatter amountFromEditText:self.priceTextField.text];
            
            if (self.product)
            {
                self.product.name = name;
                self.product.price = price;
                [self.dataController saveData];
            }
            else
            {
                [self.dataController addProductWithName:name price:price];
            }
        }
    }
//    else if ([[segue identifier] isEqualToString:@"CancelProductInput"])
//    {
//    }
}

#pragma mark - Text field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.priceTextField)
    {
        self.priceTextField.text = [AmountFormatter reformatEditText:self.priceTextField.text];
    }
}


@end
