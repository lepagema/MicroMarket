//
//  MMAddCustomerDetailViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 18.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMAddCustomerDetailViewController.h"
#import "MarketDataController.h"

@interface MMAddCustomerDetailViewController ()

@end

@implementation MMAddCustomerDetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ReturnAddCustomerInput"])
    {
        if (self.nameTextField.text.length)
        {
            NSString *name = self.nameTextField.text;
            [self.dataController addCustomerWithName:name];
        }
    }
    //    else if ([[segue identifier] isEqualToString:@"CancelAddCustomerInput"])
    //    {
    //    }
}

#pragma mark - Text field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
