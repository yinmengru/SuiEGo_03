//
//  MapViewController.m
//  SuiEGo-01_Test
//
//  Created by lk on 16/5/17.
//  Copyright © 2016年 梦茹. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
{
    CLLocationManager* _locationManager;
    MKMapView* _mapView;
}
@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect=[UIScreen mainScreen].bounds;
    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    
    //请求定位服务
    _locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType=MKMapTypeStandard;

}


@end
