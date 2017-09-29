//
//  HomeViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "HomeViewController.h"

#import "DetialViewController.h"

#import "SanWenTableViewCell.h"
#import "ShiGeCollectionViewCell.h"
#import "XiaoShuoTableViewCell.h"
#import "ZhuanjiCollectionViewCell.h"
#import "MXConfig.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)UIScrollView *sccrollView;
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, strong)UITableView *myTableview;
@property (nonatomic, strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)UITableView *xsTableview;
@property (nonatomic, strong)UICollectionView *zjCollectionView;

@property (nonatomic, assign)BOOL myTabIsFresh;
@property (nonatomic, assign)BOOL myColIsFresh;
@property (nonatomic, assign)BOOL xsIsFresh;
@property (nonatomic, assign)BOOL zjIsFresh;

@property (nonatomic, assign)NSInteger swPage;
@property (nonatomic, assign)NSInteger sgPage;
@property (nonatomic, assign)NSInteger xsPage;
@property (nonatomic, assign)NSInteger zjPage;

@property (nonatomic, strong)NSMutableArray *swDataSource;
@property (nonatomic, strong)NSMutableArray*sgDataSource;
@property (nonatomic, strong)NSMutableArray *xsDataSource;
@property (nonatomic, strong)NSMutableArray *zjDataSource;

@property (nonatomic, strong)NSMutableArray *dataSouce;

@property (nonatomic, strong)MXConfig *mxConfig;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    self.myColIsFresh = NO;
    self.xsIsFresh = NO;
    self.zjIsFresh = NO;
    self.swDataSource = [NSMutableArray array];
    self.sgDataSource = [NSMutableArray array];
    self.xsDataSource = [NSMutableArray array];
    self.zjDataSource = [NSMutableArray array];
    
    [self.myTableview.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tongzhi:) name:@"change" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tongzhi:(NSNotification*)tion{

    
    NSArray *data = [tion.userInfo[@"1"] componentsSeparatedByString:@","];
    self.dataSouce = [NSMutableArray array];
    self.dataSouce = (NSMutableArray*)data;
    [self viewDidLoad];
}

#pragma mark -UI
-(void)createUI{
    
    self.navigationItem.title = @"涨知识";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 32, 32);
    [rightBtn setImage:ECIMAGENAME(@"music") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(popPlayerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    //文言文，散文，古诗，诗歌，小说，寓言，传记，
//    NSArray *btnTitleArr = @[@"散文",@"诗歌",@"小说",@"传记"];
    self.mxConfig = [MXConfig shareInstance];
    if (self.mxConfig.styleStr==nil) {
        self.dataSouce = (NSMutableArray*)@[@"散文",@"诗歌",@"小说",@"传记"];
    }else{
        NSArray *styleArr = [self.mxConfig.styleStr componentsSeparatedByString:@","];
        self.dataSouce = [NSMutableArray arrayWithArray:styleArr];
    }
   
    CGFloat buttonW = DREAMCSCREEN_W/self.dataSouce.count;
    CGFloat buttonH = 38;
    for (NSInteger index = 0; index < self.dataSouce.count; index++) {
      
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(index*buttonW, 64, buttonW, buttonH);
        button.backgroundColor = ECCOLOR(230, 230, 230, 1);
        [button setTitle:self.dataSouce[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = index + 10;
        [button addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }

    [self.sliderView removeFromSuperview];
    self.sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 38 + 64, buttonW, 2)];
    self.sliderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.sliderView];
    
    self.sccrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, DREAMCSCREEN_W, DREAMCSCREEN_H - 104 - 49)];
    self.sccrollView.delegate = self;
    self.sccrollView.pagingEnabled = YES;
    self.sccrollView.contentSize = CGSizeMake(DREAMCSCREEN_W*self.dataSouce.count, DREAMCSCREEN_H - 104 - 49);
    self.sccrollView.bounces = NO;
    [self.view addSubview:self.sccrollView];
    
    [self createTableviewOrCollectionView];
    
}

#pragma mark tableview

-(void)createTableviewOrCollectionView{
    
    CGFloat scrollviewW = self.sccrollView.bounds.size.width;
    CGFloat scrollviewH = self.sccrollView.bounds.size.height;
    
   // self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, scrollviewW, scrollviewH) style:UITableViewStylePlain];
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    self.myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(myTableviewHeadFresh)];
    self.myTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(myTableviewFootLoad)];
    [self.myTableview registerNib:[UINib nibWithNibName:@"SanWenTableViewCell" bundle:nil] forCellReuseIdentifier:@"sanwen"];
    [self.sccrollView addSubview:self.myTableview];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.itemSize = CGSizeMake((DREAMCSCREEN_W - 40)/3,(DREAMCSCREEN_W - 40)/3);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W, 0, scrollviewW, scrollviewH) collectionViewLayout:flowLayout];
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(collectionHeadView)];
    self.myCollectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(collectionFootView)];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"ShiGeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"shige"];
    [self.sccrollView addSubview:self.myCollectionView];

    self.xsTableview = [[UITableView alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W*2, 0, scrollviewW, scrollviewH) style:UITableViewStylePlain];
    self.xsTableview.delegate = self;
    self.xsTableview.dataSource = self;
    self.xsTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.xsTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(xsTableviewHeadFresh)];
    self.xsTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(xsTableviewFootLoad)];
    [self.xsTableview registerNib:[UINib nibWithNibName:@"XiaoShuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"xiaoshuo"];
    [self.sccrollView addSubview:self.xsTableview];
    
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc]init];
    flowLayout1.minimumInteritemSpacing = 15;
    flowLayout1.minimumLineSpacing = 15;
    flowLayout1.itemSize = CGSizeMake(DREAMCSCREEN_W/2-25,(DREAMCSCREEN_H - 113)/2);
    flowLayout1.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    flowLayout1.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.zjCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(DREAMCSCREEN_W*3, 0, scrollviewW , scrollviewH) collectionViewLayout:flowLayout1];
    
    self.zjCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.zjCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(zjcollectionHeadView)];
    self.zjCollectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(zjcollectionFootView)];
    
    self.zjCollectionView.delegate = self;
    self.zjCollectionView.dataSource = self;
    
    [self.zjCollectionView registerNib:[UINib nibWithNibName:@"ZhuanjiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"zhuanji"];
    [self.sccrollView addSubview:self.zjCollectionView];
}



#pragma mark netquest

-(void)netquest:(NSInteger)flag{
    self.swPage = 1;
    NSString *keyword;
    if (flag == 0) {
        keyword = self.dataSouce[0];
    }else if(flag == 1){
        keyword = self.dataSouce[1];
    }else if (flag == 2){
        keyword = self.dataSouce[2];
    }else{
       keyword = self.dataSouce[3];
    }
    [MXAPI getShiCiListByKeyword:keyword page:self.swPage dataBlock:^(NSMutableArray *data, NSString *error) {
        
        if (data) {
            switch (flag) {
                case 0:
                {
                    [self.swDataSource removeAllObjects];
                    [self.swDataSource addObjectsFromArray:data];
                    [self.myTableview reloadData];
                    [self.myTableview.mj_header endRefreshing];
                }
                    break;
                case 1:
                {
                    [self.sgDataSource removeAllObjects];
                    [self.sgDataSource addObjectsFromArray:data];
                    [self.myCollectionView reloadData];
                    self.myColIsFresh = YES;
                    [self.myCollectionView.mj_header endRefreshing];
                }
                    break;
                case 2:
                {
                    [self.xsDataSource removeAllObjects];
                    [self.xsDataSource addObjectsFromArray:data];
                    [self.xsTableview reloadData];
                    self.xsIsFresh = YES;
                    [self.xsTableview.mj_header endRefreshing];
                }
                    break;
                case 3:
                {
                    [self.zjDataSource removeAllObjects];
                    [self.zjDataSource addObjectsFromArray:data];
                    self.zjIsFresh = YES;
                    [self.zjCollectionView reloadData];
                    [self.zjCollectionView.mj_header endRefreshing];
                }
                    break;
                    
                default:
                    break;
            }
           // [self showBaseHudWithTitle:@""];
           // [self dismissHudWithSuccessTitle:@"" After:1.f];
        }else{
            [self showBaseHudWithTitle:@""];
            [self dismissHudWithErrorTitle:error After:1.f];
            [self.myTableview.mj_header endRefreshing];
            [self.myCollectionView.mj_header endRefreshing];
            [self.xsTableview.mj_header endRefreshing];
            [self.zjCollectionView.mj_header endRefreshing];
        }
    }];
}

-(void)loadData:(NSInteger)flag{
    self.swPage++;
    NSString *keyword;
    if (flag == 0) {
        keyword = @"散文";
    }else if(flag == 1){
        keyword = @"诗歌";
    }else if (flag == 2){
        keyword = @"小说";
    }else{
        keyword = @"传记";
    }
    [self showBaseHud];
    [MXAPI getShiCiListByKeyword:keyword page:self.swPage dataBlock:^(NSMutableArray *data, NSString *error) {
        
        if (data) {
            switch (flag) {
                case 0:
                {
                    [self.swDataSource addObjectsFromArray:data];
                    [self.myTableview reloadData];
                    [self.myTableview.mj_footer endRefreshing];
                }
                    break;
                case 1:
                {
                    [self.sgDataSource addObjectsFromArray:data];
                    [self.myCollectionView reloadData];
                    [self.myCollectionView.mj_footer endRefreshing];
                }
                    break;
                case 2:
                {
                    [self.xsDataSource addObjectsFromArray:data];
                    [self.xsTableview reloadData];
                    [self.xsTableview.mj_footer endRefreshing];
                }
                    break;
                case 3:
                {
                    [self.zjDataSource addObjectsFromArray:data];
                    [self.zjCollectionView reloadData];
                    [self.zjCollectionView.mj_footer endRefreshing];
                }
                    break;
                    
                default:
                    break;
            }
            [self dismissHudWithSuccessTitle:@"" After:1.f];
        }else{
            [self dismissHudWithErrorTitle:error After:1.f];
            [self.myTableview.mj_footer endRefreshing];
            [self.myCollectionView.mj_footer endRefreshing];
            [self.xsTableview.mj_footer endRefreshing];
            [self.zjCollectionView.mj_footer endRefreshing];
        }
    }];
}


#pragma mark tabelviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.myTableview) {
        return self.swDataSource.count;
    }else{
        return self.xsDataSource.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.myTableview) {
        return 180;
    }else{
        return 90;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.myTableview) {
        SanWenTableViewCell *cell = [self.myTableview dequeueReusableCellWithIdentifier:@"sanwen"];
        if (!cell) {
            cell = [[SanWenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sanwen"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ShiciModel *model = self.swDataSource[indexPath.row];
        [cell headViewAndTitleInCellWith:model];
        return cell;
    }else{
        XiaoShuoTableViewCell *cell = [self.xsTableview dequeueReusableCellWithIdentifier:@"xiaoshuo"];
        if (!cell) {
            cell = [[XiaoShuoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xiaoshuo"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ShiciModel *model = self.xsDataSource[indexPath.row];
        [cell headViewAndTitleInCellWith:model];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShiciModel *model;
    if (tableView == self.myTableview) {
        model = self.swDataSource[indexPath.row];
    }else{
        model = self.zjDataSource[indexPath.row];
    }
    
    DetialViewController *vc = [[DetialViewController alloc]init];
    vc.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
-(void)myTableviewHeadFresh{
    self.myTabIsFresh = YES;
    [self netquest:0];
}

-(void)myTableviewFootLoad{
    
    [self loadData:0];
}

-(void)xsTableviewHeadFresh{
    [self netquest:2];
}

-(void)xsTableviewFootLoad{
    [self loadData:2];
}

#pragma mark -collectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.myCollectionView) {
        return self.sgDataSource.count;
    }else{
        return self.zjDataSource.count;
    }
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.myCollectionView) {
        ShiGeCollectionViewCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:@"shige" forIndexPath:indexPath];
        ShiciModel *model = self.sgDataSource[indexPath.row];
        [cell itemHeadViewAndTitleInCellBy:model];
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        [UIView animateWithDuration:1 animations:^{
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }];
        return cell;
    }else{
        ZhuanjiCollectionViewCell *cell = [self.zjCollectionView dequeueReusableCellWithReuseIdentifier:@"zhuanji" forIndexPath:indexPath];
        ShiciModel *model = self.zjDataSource[indexPath.row];
        [cell.headview sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:ECIMAGENAME(@"zhanwei")];
        return cell;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShiciModel *model;
    if (collectionView == self.myCollectionView) {
        model = self.sgDataSource[indexPath.row];
    }else{
        model = self.zjDataSource[indexPath.row];
    }
    DetialViewController *vc = [[DetialViewController alloc]init];
    vc.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)collectionHeadView{
    [self netquest:1];
}

-(void)collectionFootView{
    [self loadData:1];
}

-(void)zjcollectionHeadView{
    [self netquest:3];
}
-(void)zjcollectionFootView{
    [self loadData:3];
}

#pragma mark -click

-(void)popPlayerClick:(UIButton*)button{
    
    PlayerViewController *vc = [PlayerViewController sharedInstance];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)changeClick:(UIButton*)button{
    
    CGFloat buttonW = DREAMCSCREEN_W/4;
    NSInteger btnFlag = button.tag - 10;
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderView.frame = CGRectMake(btnFlag*buttonW, 38 + 64, buttonW, 2);
        self.sccrollView.contentOffset = CGPointMake(btnFlag*DREAMCSCREEN_W, 0);
    }];
    if (button.tag == 11&&self.myColIsFresh==NO) {
        [self.myCollectionView.mj_header beginRefreshing];
    }
    if (button.tag == 12&&self.xsIsFresh == NO) {
        [self.xsTableview.mj_header beginRefreshing];
    }
    if (button.tag == 13&&self.zjIsFresh == NO) {
        [self.zjCollectionView.mj_header beginRefreshing];
    }
}

#pragma mark -scrollviewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.sccrollView) {
        CGFloat buttonW = DREAMCSCREEN_W/4;
        CGFloat btnFlag = scrollView.contentOffset.x/DREAMCSCREEN_W*1.0;
        [UIView animateWithDuration:0.2 animations:^{
            self.sliderView.frame = CGRectMake(btnFlag*buttonW, 38 + 64, buttonW, 2);
        }];
    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.sccrollView) {
        CGFloat btnFlag = scrollView.contentOffset.x/DREAMCSCREEN_W*1.0;
        if (btnFlag == 1&&self.myColIsFresh == NO) {
            [self.myCollectionView.mj_header beginRefreshing];
        }
        if (btnFlag == 2&&self.xsIsFresh == NO) {
            [self.xsTableview.mj_header beginRefreshing];
        }
        if (btnFlag == 3&&self.zjIsFresh ==NO) {
            [self.zjCollectionView.mj_header beginRefreshing];
        }
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
