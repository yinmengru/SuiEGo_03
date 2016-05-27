//
//  WeatherViewController.m
//  SuYiGo
//
//  Created by lk on 16/5/27.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import "WeatherViewController.h"
#import "MapLocationManager.h"
@interface WeatherViewController ()
@property(nonatomic,strong)UIImageView* imageView;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView=[UIImageView new];
    _imageView.image=[UIImage imageNamed:@"bg.jpg"];
    _imageView.frame=self.view.frame;
    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
