//
//  HeartsVC.h
//  aggregate
//
//  Created by Kelsey Wong on 8/4/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjCMongoDB.h"

@interface HeartsVC : UICollectionViewController

@property (strong,nonatomic) NSMutableArray *heartPics;
@property (strong,nonatomic) NSMutableArray *clothesNames;
@property (strong,nonatomic) NSMutableArray *clothesPrices;
@property (strong,nonatomic) NSMutableArray *clothesUrls;
@property (assign) int maxLoad;


- (void)setUpDisplay:(NSArray *)allclothes;


@end
