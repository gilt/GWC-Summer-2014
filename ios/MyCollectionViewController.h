//
//  MyCollectionViewController.h
//  aggregate
//
//  Created by Kelsey Wong on 7/22/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"

@interface MyCollectionViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>

//@property (strong,nonatomic) UICollectionViewCell *protoCell;
@property (strong,nonatomic) NSMutableArray *clothesPics;
@property (strong,nonatomic) NSMutableArray *clothesNames;


@end
