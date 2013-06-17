//
//  MMProductDetailViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 15.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMProductDetailViewController.h"
#import "MMProduct.h"
#import "MMAmountFormatter.h"

@interface MMProductDetailViewController ()

@end

@implementation MMProductDetailViewController

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
        self.priceTextField.text = [MMAmountFormatter editTextFromAmount:self.product.price];
    }
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
            NSDecimalNumber *price = [MMAmountFormatter amountFromEditText:self.priceTextField.text];
            
            if (self.OperationType == EditProduct)
            {
                self.product.name = name;
                self.product.price = price;
            }
            else if (self.OperationType == AddProduct)
            {
                self.product = [[MMProduct alloc] initWithName:name price:price];
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
        self.priceTextField.text = [MMAmountFormatter reformatEditText:self.priceTextField.text];
    }
}


@end
