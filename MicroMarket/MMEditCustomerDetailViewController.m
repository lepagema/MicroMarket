//
//  MMEditCustomerDetailViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 18.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMEditCustomerDetailViewController.h"
#import "MarketDataController.h"
#import "Customer.h"
#import "Product.h"
#import "AmountFormatter.h"

@interface MMEditCustomerDetailViewController ()
{
    Product *oneAndOnlyProduct;
}

@end

@implementation MMEditCustomerDetailViewController

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

//    [self.tableView registerClass:[self.nameCell class] forCellReuseIdentifier:@"NameCell"];
//    [self.tableView registerClass:[self.paymentCell class] forCellReuseIdentifier:@"PaymentCell"];
//    [self.tableView registerClass:[self.purchaseCell class] forCellReuseIdentifier:@"PurchaseCell"];
    
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

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//        case 1:
//            return 1;
//            
//        case 2:
//            return self.products.count;
//            
//        default:
//            return 0;
//    }
//    
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *NameCellIdentifier = @"NameCell";
//    static NSString *PaymentCellIdentifier = @"PaymentCell";
//    static NSString *PurchaseCellIdentifier = @"PurchaseCell";
//
//    switch (indexPath.section) {
//        case 0:
//            return [tableView dequeueReusableCellWithIdentifier:NameCellIdentifier forIndexPath:indexPath];
//            
//        case 1:
//            return [tableView dequeueReusableCellWithIdentifier:PaymentCellIdentifier forIndexPath:indexPath];
//            
//        case 2:
//            return [tableView dequeueReusableCellWithIdentifier:PurchaseCellIdentifier forIndexPath:indexPath];
//            
//        default:
//            return nil;
//    }
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
