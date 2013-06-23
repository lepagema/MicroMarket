//
//  EditCustomerDetailViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 18.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "EditCustomerDetailViewController.h"
#import "MarketDataController.h"
#import "Customer.h"
#import "Product.h"
#import "AmountFormatter.h"

@interface EditCustomerDetailViewController ()
{
    Product *oneAndOnlyProduct;
}

@end

@implementation EditCustomerDetailViewController

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
    
    self.nameTextField.delegate = self;
    self.paymentTextField.delegate = self;
    
    [self.productStepper addTarget:self action:@selector(stepperValueChangedHandler) forControlEvents:UIControlEventValueChanged];
    
    if (self.customer)
    {
        self.nameTextField.text = self.customer.name;
    }
    
    if (self.dataController &&  [self.dataController productCount] > 0)
    {
        oneAndOnlyProduct = [self.dataController productAtIndex:0];
        self.productLabel.text = oneAndOnlyProduct.name;
        self.productStepper.enabled = true;
    }
    else
    {
        self.productLabel.text = @"no product";
        self.productStepper.enabled = false;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stepperValueChangedHandler
{
    static NSNumberFormatter *formatter = nil;

    if (formatter == nil)
    {
        formatter = [[NSNumberFormatter alloc] init];
    }
    
    NSNumber *productCount = [[NSNumber alloc] initWithDouble:self.productStepper.value];
    self.procuctCountLabel.text = [formatter stringFromNumber:productCount];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ReturnEditCustomerInput"])
    {
        if (self.nameTextField.text.length)
        {
            self.customer.name = self.nameTextField.text;
        }

        if (self.paymentTextField.text.length)
        {
            NSDecimalNumber *payment = [AmountFormatter amountFromEditText:self.paymentTextField.text];
            self.customer.balance = [self.customer.balance decimalNumberByAdding:payment];
        }
        
        if (self.productStepper.enabled)
        {
            NSDecimalNumber *productCount = [[NSDecimalNumber alloc] initWithDouble:self.productStepper.value];
            NSDecimalNumber *totalPurchase = [oneAndOnlyProduct.price decimalNumberByMultiplyingBy:productCount];
            self.customer.balance = [self.customer.balance decimalNumberBySubtracting:totalPurchase];
        }
        
        [self.dataController saveData];
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.paymentTextField)
    {
        self.paymentTextField.text = [AmountFormatter reformatEditText:self.paymentTextField.text];
    }
}

@end
