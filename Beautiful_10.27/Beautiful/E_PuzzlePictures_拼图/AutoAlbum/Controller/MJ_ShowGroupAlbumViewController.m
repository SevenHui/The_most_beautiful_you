//
//  MJ_ShowGroupAlbumViewController.m
//  Beautiful
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ShowGroupAlbumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MJ_ShowAutoAlbumViewController.h"
#import "ALAssetsLibrary+YF.h"

@interface MJ_ShowGroupAlbumViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

{
    ALAssetsLibrary *library;
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MJ_ShowGroupAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    [self createTopView];

    [self initTableView];
    
    //获得相册个数
    __weak typeof(self)weakSelf = self;
    
    library = [[ALAssetsLibrary alloc]init];
    
    [library countOfAlbumGroup:^(ALAssetsGroup *yfGroup) {
        
        [weakSelf.dataArray addObject:yfGroup];
        [_tableView reloadData];
        
    }];


}

#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 退出相册
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.06, topView.bounds.size.height * 0.38) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [topView addSubview:backButton];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(topView.bounds.size.width / 2 - topView.bounds.size.width * 0.1, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.2, topView.bounds.size.height * 0.4)];
    titleLabel.text = @"相册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [topView addSubview:titleLabel];
    
    
}

#pragma mark  加载表
- (void)initTableView {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
#pragma mark 表的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:ID];
    }
    ALAssetsGroup *group = (ALAssetsGroup *)[_dataArray objectAtIndex:indexPath.row];
    if (group) {
        //相册第一张图片
        cell.imageView.image = [UIImage imageWithCGImage:group.posterImage];
        //相册名字
        NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
        if ([groupName isEqualToString:@"Camera Roll"]) {
            groupName = @"我的相册";
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%ld)",groupName,(long)[group numberOfAssets]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转
    MJ_ShowAutoAlbumViewController *show = [[MJ_ShowAutoAlbumViewController alloc]init];
    ALAssetsGroup *group = (ALAssetsGroup *)[_dataArray objectAtIndex:indexPath.row];
    show.group = group;
    show.listCount = self.listCount;
    show.color = self.albumColor;
    show.showStyle = self.showAlbumStyle;
    [self.navigationController pushViewController:show animated:YES];
}



@end
