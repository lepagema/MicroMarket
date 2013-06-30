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
#import "EditableTableViewCell.h"
#import "PurchaseItem.h"
#import "PurchaseTableViewCell.h"

@interface EditCustomerDetailViewController ()
{
    UITextField *nameTextField;
    UITextField *paymentTextField;
    NSMutableArray *purchaseItems;
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

    purchaseItems = [[NSMutableArray alloc] init];
    PurchaseItem *item;
    for (int i = 0; i < self.dataController.productCount; i++)
    {
        item = [[PurchaseItem alloc] init];
        item.productCount = 0;
        Product * product = [self.dataController productAtIndex:i];
        item.productName = product.name;
        [purchaseItems addObject:item];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController productCount] + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomerNameCellIdentifier = @"CustomerNameCell";
    static NSString *PaymentCellIdentifier = @"PaymentCell";
    static NSString *ProductCellIdentifier = @"ProductCell";

    UITableViewCell* cell;
    switch (indexPath.row)
    {
        case 0:
        {
            EditableTableViewCell* editableCell = [tableView dequeueReusableCellWithIdentifier:CustomerNameCellIdentifier];
            editableCell.detailTextField.text = self.customer.name;
            editableCell.detailTextField.delegate = self;
            nameTextField = editableCell.detailTextField;
            cell = editableCell;
            break;
        }
            
        case 1:
        {
            EditableTableViewCell* editableCell = [tableView dequeueReusableCellWithIdentifier:PaymentCellIdentifier];
            editableCell.detailTextField.delegate = self;
            paymentTextField = editableCell.detailTextField;
            cell = editableCell;
            break;
        }
            
        default:
        {
            PurchaseTableViewCell* newPurchaseCell = [tableView dequeueReusableCellWithIdentifier:ProductCellIdentifier];
            newPurchaseCell.purchaseItem = purchaseItems[indexPath.row - 2];
            cell = newPurchaseCell;
            break;
        }
    }
    
    return cell;
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
        if (nameTextField.text.length)
        {
            self.customer.name = nameTextField.text;
        }

        if (paymentTextField.text.length)
        {
            NSDecimalNumber *payment = [AmountFormatter amountFromEditText:paymentTextField.text];
            self.customer.balance = [self.customer.balance decimalNumberByAdding:payment];
        }
        
        for (int i = 0; i < self.dataController.productCount; i++)
        {
            PurchaseItem * purchaseItem = purchaseItems[i];
            Product * product = [self.dataController productAtIndex:i];

            NSDecimalNumber *productCount = [[NSDecimalNumber alloc] initWithInteger:purchaseItem.productCount];
            NSDecimalNumber *totalPurchase = [product.price decimalNumberByMultiplyingBy:productCount];
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
    if (textField == paymentTextField)
    {
        paymentTextField.text = [AmountFormatter reformatEditText:paymentTextField.text];
    }
}

@end
