//
//  MineViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MineViewController.h"

#import "DingzhiCollectionViewCell.h"
#import "MXConfig.h"

@interface MineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSArray *dataSouce;

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *styleData ;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSouce = @[@"名校公开课",@"情感生活",@"旅游",@"戏曲",@"百家讲坛",@"广播剧",@"健康养生",@"历史人文",@"3D体验馆",@"时尚生活",@"动漫游戏",@"资讯",@"汽车",@"商业财经",@"科技",@"散文",@"诗歌",@"小说",@"传记"];
    self.styleData = [NSMutableArray array];
    [self creatUI];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UI

-(void)creatUI{
    
    self.navigationItem.title = @"我做主";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 32, 32);
    [rightBtn setImage:ECIMAGENAME(@"music") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(popPlayerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    //名校公开课、情感生活、旅游、戏曲、百家讲坛、广播剧、健康养生、历史人文、3D体验馆、时尚生活、动漫游戏、
    //资讯、汽车、商业财经、科技、散文,诗歌,小说,传记

    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(DREAMCSCREEN_W/2,40);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, DREAMCSCREEN_W, DREAMCSCREEN_H - 49 - 20 - 50) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
        
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DingzhiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"dingzhi"];
    
    [self.view addSubview:self.collectionView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 8;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(8);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-57);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(-30);
    }];
    
}


#pragma mark -click

-(void)popPlayerClick:(UIButton*)button{
    
    PlayerViewController *vc = [PlayerViewController sharedInstance];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)doneClick:(UIButton*)button{
    [self showBaseHudWithTitle:@""];
    if (self.styleData.count == 4) {
        
        MXConfig *config = [MXConfig shareInstance];
        NSString *styleStr = [self.styleData componentsJoinedByString:@","];
        [config saveStyleStr:styleStr];
        NSNotification *notion = [NSNotification notificationWithName:@"change" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notion];
        [self dismissHudWithSuccessTitle:@"定制成功" After:1.f];
    }else{
        
        [self dismissHudWithWarningTitle:@"选取四种类型" After:1.f];
    }

}


#pragma mark -uicollectionViewDelegate

#pragma mark -collectionDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.dataSouce.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DingzhiCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"dingzhi" forIndexPath:indexPath];
    cell.dzTitle.text = self.dataSouce[indexPath.row];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 15;
    cell.layer.borderColor = ECCOLOR(230, 230, 230, 1).CGColor;
    cell.layer.borderWidth = 0.5;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DingzhiCollectionViewCell *cell = (DingzhiCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isSelected) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.dzTitle.textColor = [UIColor blackColor];
        cell.isSelected = NO;
        [self.styleData removeObject:self.dataSouce[indexPath.row]];
    }else{
        cell.backgroundColor = [UIColor redColor];
        cell.dzTitle.textColor = [UIColor whiteColor];
        cell.isSelected = YES;
        [self.styleData addObject:self.dataSouce[indexPath.row]];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
