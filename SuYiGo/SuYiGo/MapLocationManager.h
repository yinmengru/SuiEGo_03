//
//  MapLocationManager.h
//  SuYiGo
//
//  Created by lk on 16/5/27.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@class MapLocationManager;
//添加代理：因为不知道什么时候定位
@protocol  MapManagerLocationDelegate<NSObject>

@optional
- (void)mapManager:(MapLocationManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location;
- (void)mapManager:(MapLocationManager *)manager didFailed:(NSError *)error;
- (void)mapManagerServerClosed:(MapLocationManager *)manager;

@end
@interface MapLocationManager : NSObject
@property(nonatomic,weak)id<MapManagerLocationDelegate>delegate;
@property(nonatomic,readonly)CLAuthorizationStatus authorizationStatus;
-(void)start;

@end
