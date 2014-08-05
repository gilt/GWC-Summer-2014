//
//  MyCollectionViewController.h
//  aggregate
//
//  Created by Kelsey Wong on 7/22/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "MyCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface MyCollectionViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong,nonatomic) NSMutableArray *clothesPics;
@property (strong,nonatomic) NSMutableArray *clothesNames;
@property (strong,nonatomic) NSMutableArray *clothesPrices;
@property (strong,nonatomic) NSMutableArray *clothesUrls;
@property (strong,nonatomic) NSMutableArray *clothesCategories;
@property (strong,nonatomic) NSMutableArray *faves;
@property (strong,nonatomic) NSMutableArray *unfaves;
@property (strong,nonatomic) NSMutableArray *categories;
@property (assign) int maxLoad;


- (IBAction)hearted:(id)sender;
-(void)setUpDBWithArray:(NSArray *)allclothes;
- (void) addCategory:(NSString *)category;

@end
