//
//  AppDelegate.h
//  LeeBaidu
//
//  Created by Cocoa Lee on 16/3/14.
//  Copyright © 2016年 Lee. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

