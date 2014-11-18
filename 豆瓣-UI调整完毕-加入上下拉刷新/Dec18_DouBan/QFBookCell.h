//
//  QFBookCell.h
//  Dec18_DouBan
//
//  Created by xqianfeng on 13-12-18.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFBookModel.h"
@interface QFBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookSpit;
@property (weak, nonatomic) IBOutlet UILabel *bookDate;
@property (weak, nonatomic) IBOutlet UIView *bookStoreView;
@property (weak, nonatomic) IBOutlet UIImageView *bookStore;
@property (weak, nonatomic) IBOutlet UILabel *bookStoreNum;
@property (weak, nonatomic) IBOutlet UILabel *bookComment;
@property (weak, nonatomic) IBOutlet UILabel *bookPrice;
@property (weak, nonatomic) IBOutlet UILabel *bookSummary;

-(void)refreshUIWithModel:(QFBookModel*)modle;
@end
