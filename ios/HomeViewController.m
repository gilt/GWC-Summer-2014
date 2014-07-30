//
//  HomeViewController.m
//  aggregate
//
//  Created by Francesca Colombo on 7/28/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import "HomeViewController.h"
#import "MyCollectionViewController.h"
@implementation HomeViewController

@synthesize categories;
@synthesize categorypics = _categorypics;
@synthesize categorynames = _categorynames;
@synthesize d, sh,sk,sw,p,t;
- (void)viewDidLoad
{
    
    [super viewDidLoad];
     //dress = [UIImage imageNamed: @"dresses.jpg"];
     //skirt = [UIImage imageNamed:@"skirts.jpg"];
    //top = [UIImage imageNamed:@"tops.jpg"];
   _categorypics = [NSArray arrayWithObjects:@"dresses.jpg", @"tops.jpg", @"pants.jpg", @"skirts.jpg", @"shorts.png", @"swim.png", nil];
    
    _categorynames= @[@"Dresses",@"Tops", @"Pants", @"Skirts", @"Shorts", @"Swim"];
    [categories addSubview:d.imageView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];

     }

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *catCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"catCell" forIndexPath:indexPath];
    
    NSInteger row = [indexPath row];
    
    
    catCell.imageView.image = _categorypics[row];
    catCell.title.text = _categorynames[row];
    
    return catCell;
}
/*
[d.imageView setImage:[[UIImage imageNamed:@"dresses.jpg"];
                       [sk.imageView setImage: [UIImage imageNamed:@"skirts.jpg"]];
                       [t.imageView setImage: [UIImage imageNamed:@"tops,jpg"]];
*/
    //CALLED HERE!!
   // CollectionViewCellButton *cellButton = [self makeDeleteButtonForCell:cell];
    
    //cellButton.indexPath = indexPath;
   // [cell addSubview:[self->photos objectAtIndex:indexPath.row]];
 //   [cell addSubview:cellButton];
    


@end
