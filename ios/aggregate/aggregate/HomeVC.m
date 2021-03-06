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
#import "HeartsVC.h"

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



// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //set up database connection
    NSError *error = nil;
    MongoConnection *dbConn = [MongoConnection connectionForServer:@"kahana.mongohq.com:10025/gilt" error:&error];
    [dbConn authenticate:@"gilt" username:@"francesca" password:@"harrison" error:&error];
    MongoDBCollection *collection = [dbConn collectionWithName:@"gilt.products"];
    NSArray *allclothes;
    allclothes = [[NSArray alloc] init];
    
        // first condition is always if the user selected "view all"
        // adjust if more categories are added!!
    if ([sender tag] == 5){
        MyCollectionViewController *SpecVC = [segue destinationViewController];
        allclothes = [collection findAllWithError:&error];
        [SpecVC setUpDBWithArray:allclothes];
    }
    
    else if ([sender tag] == 20) {
        StoresViewController *StoresVC;
        StoresVC = [segue destinationViewController];
    }
    
    else if ([sender tag] == -1) { // user clicked hearts/faves button
        HeartsVC *hearts = [segue destinationViewController];
        MongoKeyedPredicate *predicate = [MongoKeyedPredicate predicate];
        [predicate keyPath:@"hearted" matches:@(1)];
        allclothes = [collection findWithPredicate:predicate error:&error];
        [hearts setUpDisplay:allclothes];
        
    }
    
    else {
        MongoKeyedPredicate *predicate = [MongoKeyedPredicate predicate];
        MyCollectionViewController *SpecVC = [segue destinationViewController];
        if ([sender tag] == 1) {
            [predicate keyPath:@"category" matches:@"tops"];
        } if ([sender tag] == 2) {
            [predicate keyPath:@"category" matches:@"dresses"];
        } if ([sender tag] == 3) {
            [predicate keyPath:@"category" matches:@"skirts"];
        } if ([sender tag] == 4) {
            [predicate keyPath:@"category" matches:@"pants"];
        } if ([sender tag] == 22) {
            [predicate keyPath:@"category" matches:@"shorts"];
        } if ([sender tag] == 23) {
            [predicate keyPath:@"category" matches:@"swimwear"];
        }
        
        allclothes = [collection findWithPredicate:predicate error:&error];
        [SpecVC setUpDBWithArray:allclothes];
        
    }
}


@end
