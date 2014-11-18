//
//  QFBookModel.m
//  Dec18_DouBan
//
//  Created by xqianfeng on 13-12-18.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import "QFBookModel.h"

@implementation QFBookModel

-(id)initWithJsonDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        NSArray *authors=dic[@"author"];
        if (authors.count>0) {
            self.bookAuthor=dic[@"author"][0];
        }else{
            self.bookAuthor=@"未知";
        }
        
        self.bookName=dic[@"title"];
        self.bookPrice=dic[@"price"];
        self.bookStroe=dic[@"rating"][@"average"];
        self.bookDate=dic[@"pubdate"];
        self.bookCommentNum=dic[@"rating"][@"numRaters"];
        self.bookImageUrl=dic[@"image"];
        self.bookSummary=dic[@"summary"];
    }
    return self;
}
@end
