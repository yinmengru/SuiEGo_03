//
//  MapViewController.m
//  SuiEGo-01_Test
//
//  Created by lk on 16/5/17.
//  Copyright © 2016年 梦茹. All rights reserved.
//

#import "MapViewController.h"
#import "WeatherViewController.h"
@interface MapViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    MKMapView* _mapView;
    NSString* city;
}
@property(nonatomic,strong)CLGeocoder* geocoder;

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
    
     _mapView.showsUserLocation=YES;
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

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region;
    region.center.latitude=userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.2;
    region.span.longitudeDelta = 0.2;
    
    CLLocation* loc=[[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    
    if (_mapView)
    {
        _mapView.region = region;
        
        //NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        
        
        [_geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark* placemark=[placemarks firstObject];
            //NSDictionary* address=placemark.addressDictionary;
            city=placemark.locality;
            NSLog(@"city:%@",city);
        }];
        
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* ViewC=segue.destinationViewController;
    if ([ViewC isKindOfClass:[WeatherViewController class]])
    {
        WeatherViewController* weatherC=(WeatherViewController*)ViewC;
        if(city!=nil)
        {
        weatherC.cityName=city;
        }else
        {
            weatherC.cityName=@"合肥市";
        }
        
    }
}

@end
