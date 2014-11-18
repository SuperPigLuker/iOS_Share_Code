//
//  QFViewController.m
//  Dec30_GCD
//
//  Created by xqianfeng on 13-12-30.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import "QFViewController.h"

@interface QFViewController ()
-(void)firstWork;
-(void)secondWork;
-(void)thirdWork;
@end

@implementation QFViewController{
    int a;
    int b;
    int c;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Grant Center Dispatch 伟大的中心调度系统
    a=0;
    b=0;
    c=0;
    
}
-(void)firstWork{
    NSLog(@"firstwork 开始");
    sleep(2);
    a=5;
    NSLog(@"firstwork 结束");
}
-(void)secondWork{
    NSLog(@"secondWork 开始");
    sleep(3);
    b=8;
    NSLog(@"secondWork 结束");
}
-(void)thirdWork{
    NSLog(@"thirdWork 开始");
    sleep(2);
    c=a+b;
    NSLog(@"thirdWork 结束");
}

- (IBAction)doSomething:(id)sender {
    //得到队列
    dispatch_queue_t rootQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //给队列分配任务
    dispatch_async(rootQueue, ^{
        //耗时的事情
        
        //想让1、2同时执行，执行完毕后，再执行3
        dispatch_group_t groupQueue=dispatch_group_create();
        //给组队列分配任务(1、2分配为并行执行）
        dispatch_group_async(groupQueue, rootQueue, ^{
            [self firstWork];
        });
        dispatch_group_async(groupQueue, rootQueue, ^{
            [self secondWork];
        });
        //当组队列把上面的所有并行任务都执行完毕，会自动通知，只需要调用下面方法，加入后面要做的事情即可
        dispatch_group_notify(groupQueue, rootQueue, ^{
            [self thirdWork];
            //如果要修改UI，要记得在主线程队列中修改
            dispatch_async(dispatch_get_main_queue(), ^{
                self.myLabel.text=[NSString stringWithFormat:@"C=%d",c];
            });
        });
        
    });
    
    
    
//    这种同步执行在这里不适合
//    dispatch_async(rootQueue, ^{
//        [self secondWork];
//    });
//    dispatch_async(rootQueue, ^{
//        [self thirdWork];
//    });
}



@end
