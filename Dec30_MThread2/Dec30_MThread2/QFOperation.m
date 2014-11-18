//
//  QFOperation.m
//  Dec30_MThread2
//
//  Created by xqianfeng on 13-12-30.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import "QFOperation.h"

@implementation QFOperation
-(void)main{
    //各种耗时的工作
    NSLog(@"QFOperation 开始");
    sleep(3);
    NSString *str=@"改变后的值";
    
    
    [self performSelectorOnMainThread:@selector(changeUI:) withObject:str waitUntilDone:YES];
    
    NSLog(@"QFOperation 完成");
}
-(void)changeUI:(NSString*)s{
    //设置UI，要在主线程执行
    self.label.text=s;
    NSLog(@"执行完毕");
}


@end
