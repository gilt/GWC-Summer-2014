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
    NSNumber *selected = [NSNumber numberWithInt:[hitIndex row]];
    
    // MyCollectionViewCell *clicked = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:hitIndex];
    
    if ([sender isSelected]){ //if user just favorited the product
        if ([_unfaves containsObject:selected]) [_unfaves removeObject:selected];
        else [_faves addObject:selected];
    }
    
    if (![sender isSelected]){ //if user just unfavorited the product
        if ([_faves containsObject:selected]) [_faves removeObject:selected];
        else [_unfaves addObject:selected];
    }
}

- (void)setUpDBWithArray:(NSArray *)allclothes
{
    NSLog(@"i went into my collection vc class method");
    
    _maxLoad = [allclothes count];
        // at all times, the app has stored product info (name, etc.) for 14 items

    
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
        NSDictionary *result = [BSONDecoder decodeDictionaryWithDocument:[allclothes objectAtIndex:i]];
        NSString *name = [result objectForKey:@"name"];
        [_clothesNames addObject:name];
        NSString *img = [result objectForKey:@"image"];
        [_clothesPics addObject:img];
        NSString *prix = [result objectForKey:@"price"];
        [_clothesPrices addObject:prix];
        NSURL *url = [result objectForKey:@"purchaseUrl"];
        [_clothesUrls addObject:url];
        [_clothesCategories addObject:(NSString*)[result objectForKey:@"category"]];
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
    
    return myCell;
}

- (void) addCategory:(NSString *)category
{
    [_categories addObject:category];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{


}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"view will disappear");
    
    if ([_categories count]>1){
        for (int x=0; x<[_faves count]; x++){
            int pointer = [_faves[x] intValue];
            if (![_categories containsObject:_clothesCategories[pointer]]) [_categories addObject:_clothesCategories[pointer]];
        }
        for (int y=0; y<[_unfaves count]; y++){
            int pointer = [_faves[y] intValue];
            if (![_categories containsObject:_clothesCategories[pointer]]) [_categories addObject:_clothesCategories[pointer]];
        }
    }
    
    for (NSString *category in _categories) {
        NSMutableArray *merge = [(NSArray*)[[NSUserDefaults standardUserDefaults]arrayForKey:category] mutableCopy];
        for (int k=0; k<[merge count]; k++){
            for (int m=0; m<[_unfaves count]; m++){
                if (merge[k]==_clothesPics[m]){
                    [merge removeObjectAtIndex:k];
                }
            }
        }
        
        for (int n=0; n<[_faves count]; n++){
            int pointer = [_faves[n] intValue];
            [merge addObject:_clothesPics[pointer]];
        }
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:category];
        [[NSUserDefaults standardUserDefaults]setObject:merge forKey:category];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
}


@end
