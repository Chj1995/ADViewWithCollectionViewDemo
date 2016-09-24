//
//  ViewController.m
//  ADView
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "ViewController.h"
#import "ADModel.h"
#import "ADView.h"

@interface ViewController ()

/**
 *  广告栏数组
 */
@property(nonatomic,strong)NSMutableArray *ADArray;

@property(nonatomic,weak)ADView *adView;

@end

@implementation ViewController
#pragma mark - 懒加载
-(NSMutableArray *)ADArray
{
    if (!_ADArray) {
        
        _ADArray = [NSMutableArray array];
    }
    return _ADArray;
}
-(ADView *)adView
{
    if (!_adView) {
        
        ADView *view = [[ADView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [self.view addSubview:view];
        
        _adView = view;
    }
    return _adView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlStr = @"http://api-v2.mall.hichao.com/forum/banner?ga=%2Fforum%2Fbanner";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //9.0版本之前可以用
    [NSURLConnection  sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [self handleDataObjectWithOnject:responseObject];
    }];

}
#pragma mark -封装数据
-(void)handleDataObjectWithOnject:(id)responseObject
{
    [self.ADArray removeAllObjects];
    
    NSArray *items = responseObject[@"data"][@"items"];
    for (NSDictionary *dic in items)
    {
        ADModel *adModel = [[ADModel alloc]init];
        
        NSDictionary *dict = dic[@"component"];
        
        adModel.picUrl = dict[@"picUrl"];
        
        [self.ADArray addObject:adModel];
    }
    self.adView.ADDataSource  =self.ADArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
