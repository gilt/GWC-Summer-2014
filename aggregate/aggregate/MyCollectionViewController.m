//
//  MyCollectionViewController.m
//  aggregate
//
//  Created by Kelsey Wong on 7/22/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ObjCMongoDB.h"

@interface MyCollectionViewController ()

@end


@implementation MyCollectionViewController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _clothesPics = [@[@"tops1.jpg",
                      @"tops2.jpg",
                      @"tops3.jpg",
                      @"tops4.jpg"] mutableCopy];
    _clothesNames = [@[@"sweater", @"shirt", @"peplum", @"tee"] mutableCopy];
    //set up database connection
    NSError *error = nil;
    MongoConnection *dbConn = [MongoConnection connectionForServer:@"kahana.mongohq.com:10025/gilt" error:&error];
    [dbConn authenticate:@"gilt" username:@"francesca" password:@"harrison" error:&error];
    MongoDBCollection *collection = [dbConn collectionWithName:@"gilt.products2"];
    
    
    //    NSMutableArray *displayPics = [NSMutableArray array];
    NSMutableArray *displayNames = [NSMutableArray array];
    //array of product n
    NSArray *allclothes = [collection findAllWithError:&error];
    for (BSONDocument *resultDoc in allclothes){
        NSDictionary *result = [BSONDecoder decodeDictionaryWithDocument:resultDoc];
        // NSString *name = [result objectForKey:@"name"];
        [displayNames addObject:[result objectForKey:@"name"]];
        NSLog(@"fetch result: %@", result);
        
}
    /*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}
   //ames for the selected category
    
  
    NSArray *allclothes = [collection findAllWithError:&error];
    for (BSONDocument *resultDoc in allclothes){
        NSDictionary *result = [BSONDecoder decodeDictionaryWithDocument:resultDoc];
        // NSString *name = [result objectForKey:@"name"];
        [displayNames addObject:[result objectForKey:@"name"]];
        NSLog(@"fetch result: %@", result);
     */
    }

    
    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _clothesPics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    UIImage *image;
    NSInteger row = [indexPath row];
    
    image = [UIImage imageNamed:_clothesPics[row]];
    
    myCell.imageView.image = image;
    myCell.priceName.text = _clothesNames[row];
    
    return myCell;
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image;
    NSInteger row = [indexPath row];
    
    image = [UIImage imageNamed:_clothesPics[row]];
    
    return image.size;
}


/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    [segue destinationViewController];
}
 */


@end
