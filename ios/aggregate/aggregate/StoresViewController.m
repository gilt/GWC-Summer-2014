//
//  StoresViewController.m
//  aggregate
//
//  Created by Francesca Colombo on 8/5/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import "StoresViewController.h"
#import "MyCollectionViewController.h"
#import "ObjCMongoDB.h"
#import "HeartsVC.h"
@interface StoresViewController ()

@end

@implementation StoresViewController

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
    

        MongoKeyedPredicate *predicate = [MongoKeyedPredicate predicate];
        MyCollectionViewController *SpecVC = [segue destinationViewController];
    
        if ([sender tag] == 6) [predicate keyPath:@"store" matches:@"ShopBop"];
        if ([sender tag] == 7) [predicate keyPath:@"store" matches:@"Saks"];
        if ([sender tag] == 8) [predicate keyPath:@"store" matches:@"Gilt"];
        if([sender tag] == 9) [predicate keyPath:@"store" matches:@"ae"];
        if ([sender tag] == 11) [predicate keyPath:@"store" matches:@"NastyGal"];
        if([sender tag] == 10) [predicate keyPath:@"store" matches:@"Lulus"];
        if([sender tag] == 13) [predicate keyPath:@"store" matches:@"Forever21"];
    
        
        allclothes = [collection findWithPredicate:predicate error:&error];
        [SpecVC setUpDBWithArray:allclothes];
        
}


@end
