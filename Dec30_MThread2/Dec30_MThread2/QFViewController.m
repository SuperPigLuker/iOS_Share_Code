//
//  QFViewController.m
//  Dec30_MThread2
//
//  Created by xqianfeng on 13-12-30.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import "QFViewController.h"
#import "QFOperation.h"
@interface QFViewController ()

@end

@implementation QFViewController{
    QFOperation *operation;
    NSOperationQueue *oQueue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// NSOperation
    //实例化operation
    operation=[[QFOperation alloc]init];
    //初始化属性
    operation.label=self.myLabel;
    
    //实例化队列
    oQueue=[[NSOperationQueue alloc]init];
}

- (IBAction)onBtnClicked:(id)sender {
    //把operation加入队列执行
    [oQueue addOperation:operation];
}






@end
