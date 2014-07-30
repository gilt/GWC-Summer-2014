//
//  DataViewController.m
//  test
//
//  Created by Francesca Colombo on 7/29/14.
//  Copyright (c) 2014 kelseyAndFran. All rights reserved.
//

#import "HomeTViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize cat, d; 
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[d.imageView = [[UIImage imageNamed:@"dresses.jpg"]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cat.text =  @"test";
}

@end
