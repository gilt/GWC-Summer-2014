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

- (void) getInfo:(NSArray *)allclothes{
    for(int j=0; j<[allclothes count]; j++){
        [_allclothes addObject:[allclothes objectAtIndex:j]];
    }
}

- (void)setUpDBWithArray:(NSArray *)allclothes
{
    NSLog(@"i went into my collection vc class method");
    
    int movingIndex = 0;
    
    _maxLoad = 14;
        // at all times, the app has stored product info (name, etc.) for 14 items
    _maxView = 6;
        // max # of products that can be simultaneously viewed on page
        // however, this also means 3 rows so the array must be updated two objects at a time
    int currentRow = 0;
        // viewable rows: 0, 1, 2 (aka 1st, 2nd, 3rd rows)
        // hidden rows: {above: [-2,-1]}, {below: [3,4]}

    
    [_clothesNames removeAllObjects];
    [_clothesPics removeAllObjects];
    [_clothesPrices removeAllObjects];
    
        // initially clear the product info arrays so that they are not infinitely appended to
    _clothesNames = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    _clothesPics = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    _clothesPrices = [[NSMutableArray alloc] initWithCapacity:_maxLoad];

    
        // retrieve 14 items at a time, to display on the page
        // (FUTURE:) dynamically update arrays as the user scrolls, to conserve data storage/usage
    
    for (int i=0; i<_maxLoad; i++)
    {
        NSDictionary *result = [BSONDecoder decodeDictionaryWithDocument:[allclothes objectAtIndex:movingIndex]];
        NSString *name = [result objectForKey:@"name"];
        [_clothesNames addObject:name];
        NSString *img = [result objectForKey:@"image"];
        [_clothesPics addObject:img];
        NSString *prix = [result objectForKey:@"price"];
        [_clothesPrices addObject:prix];
        movingIndex++;
    }
    

}

- (void)viewDidLoad
{
    // [self setUpDBWithArray:_allclothes];
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
    
    UIImage *image;
    int row = [indexPath row];
    // [myCell.imageView sd_setImageWithURL:[NSURL URLWithString:[_clothesPics objectAtIndex:row]]
                        // placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_clothesPics objectAtIndex:row]]]];

    myCell.imageView.image = image;
    myCell.prodName.text = _clothesNames[row];
    myCell.prodPrice.text = _clothesPrices[row];
    NSLog(@"updating display");
    
    return myCell;
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // [segue destinationViewController];
}


@end
