//
//  MMProductsViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "MMProductsViewController.h"
#import "MMMarketDataController.h"
#import "MMProductDetailViewController.h"
#import "MMAmountFormatter.h"
#import "MMProduct.h"

@interface MMProductsViewController ()

@end

@implementation MMProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController productCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    MMProduct *product = [self.dataController productAtIndex:indexPath.row];
    
    [cell.textLabel setText:product.name];
    [cell.detailTextLabel setText:[MMAmountFormatter textFromAmount:product.price]];
    return cell;
}

#pragma mark - Editing Table View

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataController removeProductAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.dataController moveProductAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = [segue destinationViewController];
    id detailController = navigationController.topViewController;
    
    if ([[segue identifier] isEqualToString:@"AddProduct"])
    {
        [detailController setOperationType:AddProduct];
    }
    else if([[segue identifier] isEqualToString:@"EditProduct"])
    {
        [detailController setProduct:[self.dataController productAtIndex:[self.tableView indexPathForSelectedRow].row]];
        [detailController setOperationType:EditProduct];
    }
}

-(IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnProductInput"])
    {
        MMProductDetailViewController * detailController = [segue sourceViewController];

        if (detailController.OperationType == AddProduct)
        {
            [self.dataController addProduct:detailController.product];
        }
//        else if (detailController.OperationType == EditProduct)
//        {
//            
//        }
        
        [self.tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

-(IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelProductInput"])
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - Temp for debug

- (IBAction)buttonTouchUpInside:(id)sender
{
    [self.tableView reloadData];
}

@end
