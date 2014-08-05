//
//  HeartsVC.m
//  aggregate
//
//  Created by Kelsey Wong on 8/4/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import "HeartsVC.h"
#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface HeartsVC ()

@end

@implementation HeartsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setUpDisplay:(NSArray *)allclothes
{
    _maxLoad = [allclothes count];
    
    [_clothesNames removeAllObjects];
    [_heartPics removeAllObjects];
    [_clothesPrices removeAllObjects];
    
    _clothesNames = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    _heartPics = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    _clothesPrices = [[NSMutableArray alloc] initWithCapacity:_maxLoad];
    
    for (int i=0; i<[allclothes count]; i++)
    {
        NSDictionary *result = [BSONDecoder decodeDictionaryWithDocument:[allclothes objectAtIndex:i]];
        [_clothesNames addObject:(NSString*)[result objectForKey:@"name"]];
        [_heartPics addObject:(NSString*)[result objectForKey:@"image"]];
        [_clothesPrices addObject:(NSString*)[result objectForKey:@"price"]];
        [_clothesUrls addObject:(NSString*)[result objectForKey:@"purchaseUrl"]];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_heartPics count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Fave" forIndexPath:indexPath];
    
    int row = [indexPath row];
    [myCell.imageView sd_setImageWithURL:[NSURL URLWithString:[_heartPics objectAtIndex:row]]
                        placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    myCell.prodName.text = _clothesNames[row];
    myCell.prodPrice.text = _clothesPrices[row];
    
    return myCell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
