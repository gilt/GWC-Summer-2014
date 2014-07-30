//
//  HomeViewController.h
//  aggregate
//
//  Created by Francesca Colombo on 7/28/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryCell.h"

@interface HomeViewController :UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>

//@property  (nonatomic, strong)
//@property (strong, nonatomic) UIImage *dress;
//@property (strong, nonatomic) UIImage *top;
//@property (strong, nonatomic) UIImage *skirt;

@property (strong, nonatomic) IBOutlet CategoryCell *d;
@property (nonatomic, strong) IBOutlet UICollectionView *categories;
@property (strong, nonatomic) IBOutlet CategoryCell *t;

@property (strong, nonatomic) IBOutlet CategoryCell *sk;

@property (strong, nonatomic) IBOutlet CategoryCell *sh;

@property (strong, nonatomic) NSArray *categorypics;
@property (strong, nonatomic) NSArray *categorynames; 

@property (strong, nonatomic) IBOutlet CategoryCell *p;

@property (strong, nonatomic) IBOutlet CategoryCell *sw;


@end

