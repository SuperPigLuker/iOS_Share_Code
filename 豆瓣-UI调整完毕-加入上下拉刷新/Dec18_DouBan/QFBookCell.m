//
//  QFBookCell.m
//  Dec18_DouBan
//
//  Created by xqianfeng on 13-12-18.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import "QFBookCell.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@implementation QFBookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        UIView *view=[[UIView alloc]initWithFrame:self.bounds];
        view.backgroundColor=[UIColor orangeColor];
        self.selectedBackgroundView=view;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshUIWithModel:(QFBookModel *)modle{
    //设置书籍图片
    [self.bookImageView setImageWithURL:[NSURL URLWithString:modle.bookImageUrl]];
    self.bookImageView.contentMode=UIViewContentModeCenter;
    //设置图片的圆角（如果需要的话，这里只做演示）
    //使用layer记得导入QuartCore库
    self.bookImageView.layer.cornerRadius=15;
    self.bookImageView.clipsToBounds=YES;
    
    //设置书名
    self.bookTitle.text=modle.bookName;
    
    //设置评分小星星
    self.bookStoreView.clipsToBounds=YES;
    UIImage *storeImage=self.bookStore.image;
    self.bookStore.frame=CGRectMake(0, (modle.bookStroe.intValue+1)*11-storeImage.size.height, storeImage.size.width, storeImage.size.height);
    
    //设置作者、出版日期
    CGSize authorSize=[modle.bookAuthor sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(2000, 15)];
    //有的作者名字很长，所以限制一下最大长度
    authorSize.width=authorSize.width>130?130:authorSize.width;
    self.bookAuthor.frame=CGRectMake(0, 0, authorSize.width, authorSize.height);
    self.bookAuthor.text=modle.bookAuthor;
    
    self.bookSpit.frame=CGRectMake(authorSize.width, 0, self.bookSpit.frame.size.width,  self.bookSpit.frame.size.height);
    
    self.bookDate.text=modle.bookDate;
    self.bookDate.frame=CGRectMake((self.bookSpit.frame.origin.x+self.bookSpit.frame.size.width),0,200,15);
    
    //图书评分、评论人数
    self.bookStoreNum.text=[NSString stringWithFormat:@"%@分",modle.bookStroe];
    self.bookComment.text=[NSString stringWithFormat:@"(%@人评价)",modle.bookCommentNum];
    //图书简介
    /*
            注意！
        图书的json，有可能不存在你指定的某个字段，因此在model里面的某一项可能为空，当使用model中的属性时，要先判断是否为空，然后再使用，如果为空，给控件指定一个默认值，上面的那些控件都要做如此判断，我这里仅判断下面这一个做个示例。
     */
    if (modle.bookSummary.length>0) {
        self.bookSummary.text=modle.bookSummary;
    }else{
        self.bookSummary.text=@"简介：暂无";
    }
    
}






@end
