//
//  QYViewController.m
//  JSONKitDemo
//
//  Created by qingyun on 15-3-14.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "JSONKit.h"

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)queryWeather:(id)sender {
    
    NSString *urlStr = @"http://m.weather.com.cn/data/101110101.html";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            return ;
        }
        
//        id result = [data objectFromJSONDataWithParseOptions:JKParseOptionValidFlags];
        
//        id result = [data objectFromJSONDataWithParseOptions:JKParseOptionValidFlags error:&error];
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        NSLog(@"%@", result);
        
        NSMutableDictionary *weatherInfo = result[@"weatherinfo"];
        
        NSLog(@"weather:%@", weatherInfo);
        
        NSString *city = weatherInfo[@"city"];
        NSString *cityEn = weatherInfo[@"city_en"];
        
        NSLog(@"city:%@, city_en:%@", city,  cityEn);
    }];
    
    [task resume];
}

@end
