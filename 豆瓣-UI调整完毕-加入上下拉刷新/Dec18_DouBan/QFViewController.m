//
//  QFViewController.m
//  Dec18_DouBan
//
//  Created by xqianfeng on 13-12-18.
//  Copyright (c) 2013年 Money. All rights reserved.
//

#import "QFViewController.h"
#import "QFBookCell.h"
//加入下拉刷新和上拉加载更多
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
@interface QFViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,MJRefreshBaseViewDelegate>
//联网获取书籍
-(void)getBook:(NSString *)name from:(int)num to:(int)count;
//将json转化成数据模型
-(void)changeJson:(NSDictionary *)dic;
//储存图片
-(BOOL)saveImage:(UIImage*)image;
//上拉加载更多的调用函数
-(void)getMoreBook;
//下拉刷新
-(void)refreshBook;
@end

@implementation QFViewController{
    NSMutableArray *bookArray;
    NSString *reuseID;
    NSMutableData *netData;
    NSString *searchText;
    MJRefreshFooterView *footView;
    MJRefreshHeaderView *headView;
    int page;
    int pageNum;
    BOOL isLoding;//判断是否正在加载数据，如果正在加载，禁止上下拉刷新
    BOOL isRefresh;//判断是否是刷新，如果是的话要清空数据源
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    page=0;
    pageNum=20;
    isLoding=false;
    isRefresh=false;
    searchText=@"漫画";
    bookArray=[NSMutableArray array];
    netData=[NSMutableData data];
    reuseID=@"xibCell";
	[self.bookTableView registerNib:[UINib nibWithNibName:@"QFBookCell" bundle:nil] forCellReuseIdentifier:reuseID];
    //加入上拉加载更多
    footView=[MJRefreshFooterView footer];
    footView.delegate=self;
    footView.scrollView=self.bookTableView;
    //加入下拉刷新
    headView=[MJRefreshHeaderView header];
    headView.delegate=self;
    headView.scrollView=self.bookTableView;
    
    
    //给tableview加一个小tablefootview，让它没有数据时，不显示那些多余的黑线
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    self.bookTableView.tableFooterView=v;
    
    
    [self getBook:searchText from:page*pageNum to:pageNum];
}
#pragma mark--
#pragma mark 自定义方法
//获取网络数据--书--json
-(void)getBook:(NSString *)name from:(int)num to:(int)count{
    static NSString *baseUrl=@"https://api.douban.com/v2/book/search";
    NSString *urlString=[NSString stringWithFormat:@"%@?q=%@&start=%d&count=%d&fields=id,title,image,author,pubdate,price,rating,summary",baseUrl,name,num,count];
    NSURL *url=[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    isLoding=TRUE;
    [self.loadAI startAnimating];
}
-(void)changeJson:(NSDictionary *)dic{
    if (isRefresh) {
        isRefresh=!isRefresh;
        [bookArray removeAllObjects];
    }
    NSArray *books=dic[@"books"];
    for (NSDictionary *book in books) {
        QFBookModel *model=[[QFBookModel alloc]initWithJsonDic:book];
        [bookArray addObject:model];
    }
    [self.bookTableView reloadData];
}
//储存图片
-(BOOL)saveImage:(UIImage *)image{
    NSData *picData=UIImagePNGRepresentation(image);
   return [picData writeToFile:@"<#string#>" atomically:YES];
}
//上拉获取更多的调用函数
-(void)getMoreBook{
    if (isLoding) {
        
    }else{
       [self getBook:searchText from:pageNum*page to:pageNum];
    }
}
-(void)refreshBook{
    if (!isLoding) {
        page=0;
        isRefresh=TRUE;
        [self getBook:searchText from:page*pageNum to:pageNum];
    }
    
}
#pragma mark--
#pragma mark tableview协议
//每段有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return bookArray.count;
}
//每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 162;
}
//返回每行的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QFBookCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    QFBookModel *model=bookArray[indexPath.row];
    [cell refreshUIWithModel:model];
    return cell;
}
#pragma mark--
#pragma mark NSURLConnection协议方法

//连接成功后调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)respons{
    netData.length=0;
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [netData appendData:data];
}
//数据接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *booksDic=[NSJSONSerialization JSONObjectWithData:netData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@",booksDic);
    [self changeJson:booksDic];
    isLoding=false;
    [self.loadAI stopAnimating];
    [footView endRefreshing];
    [headView endRefreshing];
    page++;
}

#pragma mark--
#pragma mark 上下拉刷新的控件代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if (refreshView==footView) {
        [self getMoreBook];
    }else{
        [self refreshBook];
    }
}
@end
