//
//  QFBookModel.h
//  Dec18_DouBan
//
//  Created by xqianfeng on 13-12-18.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFBookModel : NSObject
@property (nonatomic,copy) NSString *bookImageUrl;
@property (nonatomic,copy) NSString *bookName;
@property (nonatomic,copy) NSString *bookAuthor;
@property (nonatomic,copy) NSString *bookPrice;
@property (nonatomic,copy) NSString *bookDate;
@property (nonatomic,copy) NSString *bookCommentNum;
@property (nonatomic,copy) NSString *bookStroe;
@property (nonatomic,copy) NSString *bookSummary;

-(id)initWithJsonDic:(NSDictionary*)dic;
@end
