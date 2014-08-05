//
//  MyCollectionViewCell.h
//  aggregate
//
//  Created by Kelsey Wong on 7/22/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *prodName;
@property (weak, nonatomic) IBOutlet UILabel *prodPrice;

@property (weak, nonatomic) IBOutlet UIButton *hearted;


@end
