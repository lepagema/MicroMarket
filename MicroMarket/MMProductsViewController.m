//
//  MMProductsViewController.m
//  MicroMarket
//
//  Created by Marc-Andre Lepage on 13.06.13.
//  Copyright (c) 2013 Self. All rights reserved.
//

//#import <CoreData/NSManagedObjectContext.h>
//#import <CoreData/NSFetchRequest.h>
//#import <CoreData/NSEntityDescription.h>

#import "MMProductsViewController.h"
#import "MarketDataController.h"
#import "MMProductDetailViewController.h"
#import "AmountFormatter.h"
#import "Product.h"

@interface MMProductsViewController ()

//-(void)reorderAndSaveProducts;

@end

@implementation MMProductsViewController

//@synthesize products;
//@synthesize managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Temporarly disable the button until we can handle more than one product.
//    self.navigationItem.rightBarButtonItem.enabled = false;

//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:managedObjectContext];
//    [request setEntity:entity];
//    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
//    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//    [request setSortDescriptors:sortDescriptors];
//    
//    NSError *error = nil;
//    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//    if (mutableFetchResults == nil) {
//        // Handle the error.
//    }
//    
//    products = mutableFetchResults;
//    
//    if (products.count == 0)
//    {
//        // Create and configure a new instance of the Product entity.
//        Product *product1 = (Product *)[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:managedObjectContext];
//
//        product1.name = @"New product";
//        product1.price = [[NSDecimalNumber alloc] initWithDouble:10.0];
//        product1.index = 0;
//        
//        Product *product2 = (Product *)[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:managedObjectContext];
//        
//        product2.name = @"Another product";
//        product2.price = [[NSDecimalNumber alloc] initWithDouble:7.0];
//        product2.index = 0;
//        
//        NSError *error = nil;
//        if (![managedObjectContext save:&error]) {
//            // Handle the error.
//        }
//        
//        [products insertObject:product1 atIndex:0];
//        [products insertObject:product2 atIndex:1];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)reorderAndSaveProducts
//{
//    int i = 0;
//    for (Product* product in products) {
//        product.index = [[NSNumber alloc] initWithInt:i];
//        i++;
//    }
//    
//    NSError *error = nil;
//    if (![managedObjectContext save:&error]) {
//        // Handle the error.
//    }
//}


#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return products.count;
    return [self.dataController productCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"ProductCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//    Product *product = [products objectAtIndex:indexPath.row];
//    
//    [cell.textLabel setText:product.name];
//    [cell.detailTextLabel setText:[MMAmountFormatter textFromAmount:product.price]];
//    return cell;

    static NSString *CellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Product *product = [self.dataController productAtIndex:indexPath.row];
    
    [cell.textLabel setText:product.name];
    [cell.detailTextLabel setText:[AmountFormatter textFromAmount:product.price]];
    return cell;
}

#pragma mark - Editing Table View

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        // Delete the managed object at the given index path.
//        NSManagedObject *productToDelete = [products objectAtIndex:indexPath.row];
//        [managedObjectContext deleteObject:productToDelete];
//
//        [products removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        [self reorderAndSaveProducts];
//    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataController removeProductAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
//    Product *product = [self.products objectAtIndex:fromIndexPath.row];
//    [products removeObjectAtIndex:fromIndexPath.row];
//    [products insertObject:product atIndex:toIndexPath.row];
//    
//    [self reorderAndSaveProducts];
    
    [self.dataController moveProductAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = [segue destinationViewController];
    id detailController = navigationController.topViewController;
    
    if ([[segue identifier] isEqualToString:@"AddProduct"])
    {
        [detailController setDataController:self.dataController];
        [detailController setProduct:nil];
//        [detailController setOperationType:AddProduct];
    }
    else if([[segue identifier] isEqualToString:@"EditProduct"])
    {
        [detailController setDataController:self.dataController];
        [detailController setProduct:[self.dataController productAtIndex:[self.tableView indexPathForSelectedRow].row]];
        
//        Product *product = [self.dataController productAtIndex:[self.tableView indexPathForSelectedRow].row];
//        [detailController setProductName:product.name];
//        [detailController setProductPrice:product.price];
//        [detailController setOperationType:EditProduct];
    }
}

-(IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnProductInput"])
    {
//        MMProductDetailViewController * detailController = [segue sourceViewController];

//        if (detailController.OperationType == AddProduct)
//        {
//            if (detailController.productName && detailController.productPrice)
//            {
//                [self.dataController addProductWithName:detailController.productName price:detailController.productPrice];
//            }
//        }
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
//    if ([[segue identifier] isEqualToString:@"CancelProductInput"])
//    {
//        [self dismissViewControllerAnimated:YES completion:NULL];
//    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Temp for debug

- (IBAction)buttonTouchUpInside:(id)sender
{
    [self.tableView reloadData];
}

@end
