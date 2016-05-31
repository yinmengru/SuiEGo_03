//
//  WeatherViewController.m
//  SuYiGo
//
//  Created by lk on 16/5/27.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import "WeatherViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define APIKEY @"4c014bb0873acad9e08d328b3784c63b"
#define HTTPURL @"http://apis.baidu.com/thinkpage/weather_api/suggestion"
#define HTTPARG @"location=%@&language=zh-Hans&unit=c&start=0&days=3"


@interface WeatherViewController ()
@property(nonatomic,strong)UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherText;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@property (weak, nonatomic) IBOutlet UILabel *windScaleLabel;

@property (weak, nonatomic) IBOutlet UILabel *tomHighTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomLowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomWindDirLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomWindScaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *AfterHighTeLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterLowTeLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterWindDirLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterWindScaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tomWeaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tomimageWeatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *afterImageWeaLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterWeaLabel;




@end


@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView=[UIImageView new];
    _imageView.image=[UIImage imageNamed:@"bg.jpg"];
    _imageView.frame=self.view.frame;
    [self.view addSubview:_imageView];
    
    
    [self request:HTTPURL withHttpArg:[NSString stringWithFormat:HTTPARG,[self chineseToPinyin:[_cityName substringToIndex:_cityName.length-1] withSpace:NO]]];
    NSLog(@"%@",[self chineseToPinyin:[_cityName substringToIndex:_cityName.length-1] withSpace:NO]);
  
    
    
}
//中文转成拼音
- (NSString *)chineseToPinyin:(NSString *)chinese withSpace:(BOOL)withSpace
{
    CFStringRef hanzi = (__bridge CFStringRef)chinese;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, hanzi); CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO); CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO); NSString *pinyin = (NSString *)CFBridgingRelease(string); if (!withSpace) { pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return pinyin;
}
-(void)request:(NSString*)httpUrl withHttpArg:(NSString*)HttpArg
{
    NSString* urlStr=[[NSString alloc]initWithFormat:@"%@?%@",httpUrl,HttpArg];
    NSURL* url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request addValue:APIKEY forHTTPHeaderField:@"apikey"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * error) {
        if (error)
        {
            NSLog(@"HttpError:%@%ld",error.localizedDescription,error.code);
            
        }else
        {
            NSInteger responseCode=[(NSHTTPURLResponse*)response statusCode];
            NSString* responseString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HttpResponseCode:%ld",responseCode);
            NSLog(@"HttpResponseBody:%@",responseString);
            
            //
            
            NSDictionary* weatherInfo=[NSJSONSerialization JSONObjectWithData:data options:nil error:&error];
            
            NSDictionary* path=[[[[weatherInfo objectForKey:@"results"]objectAtIndex:0]objectForKey:@"daily"]objectAtIndex:0];
             NSLog(@"path--%@",path);
            
            
            NSDictionary* todayDate=[[[[weatherInfo objectForKey:@"results"]objectAtIndex:0]objectForKey:@"daily"]objectAtIndex:0];
            
            
            NSDictionary* cityName=[[[weatherInfo objectForKey:@"results"]objectAtIndex:0]objectForKey:@"location"];
            NSDictionary* tomorPath=[[[[weatherInfo objectForKey:@"results"]objectAtIndex:0]objectForKey:@"daily"]objectAtIndex:1];
            NSLog(@"tomorPath--%@",tomorPath);
            NSDictionary* afterPath=[[[[weatherInfo objectForKey:@"results"]objectAtIndex:0]objectForKey:@"daily"]objectAtIndex:2];
            
            //今天的温度
            _cityLabel.text=[cityName objectForKey:@"name"];
           _highTempLabel.text=[path objectForKey:@"high"];
            _lowTempLabel.text=[path objectForKey:@"low"];
            _dataLabel.text=[todayDate objectForKey:@"date"];
            _weatherText.text=[todayDate objectForKey:@"text_day"];
            _windDirectionLabel.text=[path objectForKey:@"wind_direction"];
            _windScaleLabel.text=[path objectForKey:@"wind_scale"];
            //天气图片
            if ([_weatherText.text isEqual:@"阴"])
            {
                _weatherImage.image=[UIImage imageNamed:@"01.png"];
            }else if ([_weatherText.text isEqual:@"多云"])
            {
                _weatherImage.image=[UIImage imageNamed:@"02.png"];                }else if ([_weatherText.text isEqual:@"晴"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"00.png"];
                }else if ([_weatherText.text isEqual:@"小雨"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"07.png"];
                }else if ([_weatherText.text isEqual:@"中雨"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"08.png"];
                }else if ([_weatherText.text isEqual:@"大雨"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"10.png"];
                }else if ([_weatherText.text isEqual:@"小雪"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"15.png"];
                }else if ([_weatherText.text isEqual:@"中雪"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"16.png"];
                }else if ([_weatherText.text isEqual:@"大雪"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"17.png"];
                }else if ([_weatherText.text isEqual:@"冰雹"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"29.png"];
                }else if ([_weatherText.text isEqual:@"大雾"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"31.png"];
                }else if ([_weatherText.text isEqual:@"雷阵雨"])
                {
                    _weatherImage.image=[UIImage imageNamed:@"04.png"];
                }


            //明天的温度
            _tomHighTempLabel.text=[tomorPath objectForKey:@"high"];
            _tomLowTempLabel.text=[tomorPath objectForKey:@"low"];
            _tomWindDirLabel.text=[tomorPath objectForKey:@"wind_direction"];
            _tomWindScaleLabel.text=[tomorPath objectForKey:@"wind_scale"];
            _tomWeaLabel.text=[tomorPath objectForKey:@"text_day"];
            //天气图片
            if ([_tomWeaLabel.text isEqual:@"阴"])
            {
                _tomimageWeatherLabel.image=[UIImage imageNamed:@"01.png"];
            }else if ([_tomWeaLabel.text isEqual:@"多云"])
            {
                _tomimageWeatherLabel.image=[UIImage imageNamed:@"02.png"];
            }else if ([_tomWeaLabel.text isEqual:@"晴"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"00.png"];
                }else if ([_tomWeaLabel.text isEqual:@"小雨"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"07.png"];
                }else if ([_tomWeaLabel.text isEqual:@"中雨"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"08.png"];
                }else if ([_tomWeaLabel.text isEqual:@"大雨"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"10.png"];
                }else if ([_tomWeaLabel.text isEqual:@"小雪"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"15.png"];
                }else if ([_tomWeaLabel.text isEqual:@"中雪"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"16.png"];
                }else if ([_tomWeaLabel.text isEqual:@"大雪"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"17.png"];
                }else if ([_tomWeaLabel.text isEqual:@"冰雹"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"29.png"];
                }else if ([_tomWeaLabel.text isEqual:@"大雾"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"31.png"];
                }else if ([_tomWeaLabel.text isEqual:@"雷阵雨"])
                {
                    _tomimageWeatherLabel.image=[UIImage imageNamed:@"04.png"];
                }


           // 后天的温度
            _AfterHighTeLabel.text=[afterPath objectForKey:@"high"];
            _afterLowTeLabel.text=[afterPath objectForKey:@"low"];
            _afterWindDirLabel.text=[afterPath objectForKey:@"wind_direction"];
            _afterWindScaleLabel.text=[afterPath objectForKey:@"wind_scale"];
            _afterWeaLabel.text=[afterPath objectForKey:@"text_day"];
            //天气图片
            if ([_afterWeaLabel.text isEqual:@"阴"])
            {
                _afterImageWeaLabel.image=[UIImage imageNamed:@"01.png"];
            }else if ([_afterWeaLabel.text isEqual:@"多云"])
            {
                _afterImageWeaLabel.image=[UIImage imageNamed:@"02.png"];
            }else if ([_afterWeaLabel.text isEqual:@"晴"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"00.png"];
                }else if ([_afterWeaLabel.text isEqual:@"小雨"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"07.png"];
                }else if ([_afterWeaLabel.text isEqual:@"中雨"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"08.png"];
                }else if ([_afterWeaLabel.text isEqual:@"大雨"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"10.png"];
                }else if ([_afterWeaLabel.text isEqual:@"小雪"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"15.png"];
                }else if ([_afterWeaLabel.text isEqual:@"中雪"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"16.png"];
                }else if ([_afterWeaLabel.text isEqual:@"大雪"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"17.png"];
                }else if ([_afterWeaLabel.text isEqual:@"冰雹"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"29.png"];
                }else if ([_afterWeaLabel.text isEqual:@"大雾"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"31.png"];
                }else if ([_afterWeaLabel.text isEqual:@"雷阵雨"])
                {
                    _afterImageWeaLabel.image=[UIImage imageNamed:@"04.png"];
                }

            
            
            
        }
    }];
}



@end
