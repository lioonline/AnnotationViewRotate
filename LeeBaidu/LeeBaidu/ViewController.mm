//
//  ViewController.m
//  LeeBaidu
//
//  Created by Cocoa Lee on 16/3/14.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "UIImage+Rotate.h"


@interface ViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate>
@property (nonatomic,strong) BMKMapView         * mapView;
@property (nonatomic,strong) BMKLocationService *locService;
@property (nonatomic,strong) BMKRouteSearch     *searcher;
@property (nonatomic,strong) NSArray            *degreesArray;
@property (nonatomic,strong) NSMutableArray * annotationArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#warning 实际情况请根据斜率算角度
    _degreesArray    = @[@30,@60,@80,@150,@80,@24,@200,@360,@60,@60,@123];
    _annotationArray = [NSMutableArray array];

    _mapView         = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view        = _mapView;

    //初始化BMKLocationService
    _locService          = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//显示定位图层
    

    
    
  

}


//实现相关delegate 处理位置信息更新
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
        [_mapView updateLocationData:userLocation];
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    BMKCoordinateSpan span        = BMKCoordinateSpanMake(0, 0);
    _mapView.limitMapRegion       = BMKCoordinateRegionMake(center, span);
    _mapView.rotateEnabled        = YES;

    
    if (_mapView.annotations.count > 0) {
        [_mapView removeAnnotations:_mapView.annotations];

    }
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate          = userLocation.location.coordinate;
    annotation.title               = @"test";
    [_mapView addAnnotation:annotation];
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor     = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = NO;
        UIImage* image                 = [UIImage imageNamed:@"map-uberx"];
        int index                      = arc4random()%11;
#warning 实际情况请根据斜率算角度
        newAnnotationView.image        = [image imageRotatedByDegrees:[_degreesArray[index] integerValue]];

        [_annotationArray addObject:newAnnotationView];
        return newAnnotationView;
    }
    return nil;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

@end
