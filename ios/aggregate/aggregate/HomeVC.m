//
//  HomeVC.m
//  aggregate
//
//  Created by Kelsey Wong on 7/31/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import "HomeVC.h"
#import "MyCollectionViewController.h"
#import "ObjCMongoDB.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)onButtonClick:(id)sender
{
    NSLog(@"button clicked");
    
    
    //set up database connection
    NSError *error = nil;
    MongoConnection *dbConn = [MongoConnection connectionForServer:@"kahana.mongohq.com:10025/gilt" error:&error];
    [dbConn authenticate:@"gilt" username:@"francesca" password:@"harrison" error:&error];
    MongoDBCollection *collection = [dbConn collectionWithName:@"gilt.products"];
    NSArray *allclothes;
    
        // first condition is always if the user selected "view all"
        // adjust if more categories are added!!
    if ([sender tag] == 5){
        NSLog(@"clicked view all");
        // allclothes = [collection findAllWithError:&error];
        allclothes = [[collection cursorForFindAllWithError:&error] allObjects];
        _SpecVC = [_SpecVC setUpDBWithArray:allclothes];
    } else {
        MongoKeyedPredicate *predicate = [MongoKeyedPredicate predicate];
        
        if ([sender tag] == 1)
        {
            [predicate keyPath:@"category" matches:@"tops"];
        }
        
        if ([sender tag] == 2)
        {
            [predicate keyPath:@"category" matches:@"dresses"];
        }
        
        if ([sender tag] == 3)
        {
            [predicate keyPath:@"category" matches:@"skirts"];
        }
        
        if ([sender tag] == 4)
        {
            [predicate keyPath:@"category" matches:@"pants"];
        }
        
        // allclothes = [collection findWithPredicate:predicate error:&error];
        allclothes = [[collection cursorForFindWithPredicate:predicate error:&error] allObjects];
        _SpecVC = [_SpecVC setUpDBWithArray:allclothes];
    }

}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"tops"])
    {
        _SpecVC = [segue destinationViewController];
    }
    
    if ([[segue identifier] isEqualToString:@"dresses"])
    {
        _SpecVC = [segue destinationViewController];
    }
    
    if ([[segue identifier] isEqualToString:@"skirts"])
    {
        _SpecVC = [segue destinationViewController];
    }
    
    if ([[segue identifier] isEqualToString:@"pants"])
    {
        _SpecVC = [segue destinationViewController];
    }
    
    if ([[segue identifier] isEqualToString:@"all"])
    {
        _SpecVC = [segue destinationViewController];
    }
}


- (IBAction)topsU:(id)sender {
    [self onButtonClick:sender];
}

- (IBAction)dressesU:(id)sender {
    [self onButtonClick:sender];
}

- (IBAction)skirtsU:(id)sender {
    [self onButtonClick:sender];
}

- (IBAction)pantsU:(id)sender {
    [self onButtonClick:sender];
}

- (IBAction)allU:(id)sender {
    [self onButtonClick:sender];
}

@end
