//
//  DataViewController.h
//  test
//
//  Created by Francesca Colombo on 7/29/14.
//  Copyright (c) 2014 kelseyAndFran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCell.h"
@interface HomeViewController : UICollectionViewController

@property (strong, nonatomic) IBOutlet UILabel *cat;
@property (strong, nonatomic) MyCell *d;

@end
