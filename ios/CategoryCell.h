//
//  CategoryCell.h
//  aggregate
//
//  Created by Francesca Colombo on 7/29/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CategoryCell: UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
