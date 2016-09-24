//
//  ADCell.m
//  ADView
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 CHJ. All rights reserved.
//

#import "ADCell.h"

@implementation ADCell

-(void)setAdModel:(ADModel *)adModel
{
    _adModel = adModel;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.bounds;
    [self.contentView addSubview:imageView];
    
    //将请求网络数据放入分线程中
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:adModel.picUrl]];
        
        //在主线程中修改imageView
        dispatch_async(dispatch_get_main_queue(), ^{
            
            imageView.image = [UIImage imageWithData:data];
        });
        
    });
    
    
}

@end
