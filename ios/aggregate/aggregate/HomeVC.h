//
//  HomeVC.h
//  aggregate
//
//  Created by Kelsey Wong on 7/31/14.
//  Copyright (c) 2014 Gilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewController.h"

@interface HomeVC : UIViewController
- (IBAction)topsU:(id)sender;
- (IBAction)dressesU:(id)sender;
- (IBAction)skirtsU:(id)sender;
- (IBAction)pantsU:(id)sender;
- (IBAction)allU:(id)sender;

@property (assign) MyCollectionViewController *SpecVC;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;


@end
