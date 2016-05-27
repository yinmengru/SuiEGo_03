//
//  MapLocationManager.m
//  SuYiGo
//
//  Created by lk on 16/5/27.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import "MapLocationManager.h"
@interface MapLocationManager()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager* locationManager;
@end


@implementation MapLocationManager
-(void)start
{
    _locationManager=[[CLLocationManager alloc]init];
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    
}
#pragma  mark---LocationManager代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [manager stopUpdatingLocation];
    if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didUpdateAndGetLastCLLocation:)])
    {
        CLLocation* location=[locations lastObject];
        [_delegate mapManager:self didUpdateAndGetLastCLLocation:location];
        
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    if ([CLLocationManager locationServicesEnabled]==NO)
    {
        NSLog(@"定位功能关闭");
        if (_delegate && [_delegate respondsToSelector:@selector(mapManagerServerClosed:)])
        {
            [_delegate mapManagerServerClosed:self];
            
        }
    }else
    {
        NSLog(@"定位功能开启");
        if (_delegate && [_delegate respondsToSelector:@selector(mapManager:didFailed:)])
        {
            NSLog(@"error:%@",error);
            [_delegate mapManager:self didFailed:error];
        }
    }
}
@synthesize authorizationStatus=_authorizationStatus;
-(CLAuthorizationStatus)authorizationStatus
{
    return [CLLocationManager authorizationStatus];
}
@end
