//
//  TabBarViewController.m
//  SuYiGo
//
//  Created by lkjy on 16/5/26.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import "TabBarViewController.h"
#import <RESideMenu.h>
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard* homePage=[UIStoryboard storyboardWithName:@"home" bundle:nil];
    UINavigationController* navC=[homePage instantiateViewControllerWithIdentifier:@"Nav"];
    
   
   UIStoryboard* Denglu=[UIStoryboard storyboardWithName:@"Denglu" bundle:nil];
    UINavigationController*navA=[Denglu instantiateViewControllerWithIdentifier:@"NavB"];
    
    self.tabBar.translucent=NO;
    
    UIViewController* one=[UIViewController new];
    UIViewController* two=[UIViewController new];
   // UIViewController* three=[UIViewController new];

    self.viewControllers=@[navC,one,two,navA];
    
    NSArray* titles=@[@"首页",@"发现",@"心情",@"我的"];
    
    NSArray* images=@[@"home.png",@"eye.png",@"mine_heart_6P",@"User 2.png"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * item, NSUInteger idx, BOOL *stop)
     {
         [item setTitle:titles[idx]];
         [item setImage:[UIImage imageNamed:images[idx]]];
         
     }];
    




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
