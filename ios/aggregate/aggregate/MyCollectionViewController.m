//
//  MyCollectionViewController.m
//  aggregate
//
//  Created by Kelsey Wong on 7/22/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ObjCMongoDB.h"
#import "HomeVC.h"
#import "UIImageView+WebCache.h"
@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}


- (IBAction)hearted:(id)sender {
    [sender setSelected:![sender isSelected]];
    CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *hitIndex = [self.collectionView indexPathForItemAtPoint:hitPoint];
    int selected = [hitIndex row];
    
    //set up database connection
    NSError *error = nil;
    MongoConnection *dbConn = [MongoConnection connectionForServer:@"kahana.mongohq.com:10025/gilt" error:&error];
    [dbConn authenticate:@"gilt" username:@"francesca" password:@"harrison" error:&error];
    MongoDBCollection *collection = [dbConn collectionWithName:@"gilt.products"];
    
    MongoKeyedPredicate *predicate = [MongoKeyedPredicate predicate];
    [predicate keyPath:@"image" matches:_clothesPics[selected]];
    MongoUpdateRequest *updateRequest = [MongoUpdateRequest updateRequestWithPredicate:predicate firstMatchOnly:NO];
    
    if ([sender isSelected]){ //if user just favorited the product
        [updateRequest keyPath:@"hearted" setValue:@(1)];
    }
    
    if (![sender isSelected]){ //if user just unfavorited the product
        [updateRequest keyPath:@"hearted" setValue:@(0)];
    }
    
    [collection updateWithRequest:updateRequest error:&error];
    
}

- (void)setUpDBWithArray:(NSArray *)allclothes
{
    _maxLoad = [allclothes count];
        // at all times, the app has stored product info (name, etc.) for 14 items

    
    [_clothesNames removeAllObjects];
    [_clothesPics removeAllObjects];
    [_clothesPrices removeAllObjects];
    [_clothesHearted removeAllObjects];
    
        // initially clear the product info arrays so that they are not infinitely appended to
    _clothesNames = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    _clothesPics = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    _clothesPrices = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    _clothesHearted = [[NSMutableArray alloc] initWithCapacity:_maxLoad];

        // retrieve 14 items at a time, to display on the page
        // (FUTURE:) dynamically update arrays as the user scrolls, to conserve data storage/usage
    
    for (int i=0; i<_maxLoad; i++)
    {
        NSDictionary *result = [BSONDecoder decodeDictionaryWithDocument:[allclothes objectAtIndex:i]];
        [_clothesNames addObject:(NSString*)[result objectForKey:@"name"]];
        [_clothesPics addObject:(NSString*)[result objectForKey:@"image"]];
        [_clothesPrices addObject:(NSString*)[result objectForKey:@"price"]];
        [_clothesUrls addObject:(NSString*)[result objectForKey:@"purchaseUrl"]];
        [_clothesHearted addObject:(NSNumber*)[result objectForKey:@"hearted"]];
        //NSLog(@"hearted is %@",[result objectForKey:@"hearted"]);
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _maxLoad;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    int row = [indexPath row];
    [myCell.imageView sd_setImageWithURL:[NSURL URLWithString:[_clothesPics objectAtIndex:row]]
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    myCell.prodName.text = _clothesNames[row];
    myCell.prodPrice.text = _clothesPrices[row];
    if ([_clothesHearted[row]boolValue]) [myCell.hearted setSelected:YES];
    else [myCell.hearted setSelected:NO];
    
    return myCell;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{


}

- (void)viewWillDisappear:(BOOL)animated
{
    
}


@end
