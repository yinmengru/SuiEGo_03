//
//  RootViewController.m
//  SuYiGo
//
//  Created by lkjy on 16/5/26.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
-(void)awakeFromNib
{
    
    self.parallaxEnabled=NO;
    self.contentViewShadowEnabled=YES;
    self.scaleContentView=NO;
    self.contentViewScaleValue=1.0f;
    self.scaleMenuView=NO;
    self.contentViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    self.leftMenuViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SideTableViewController"];

    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
