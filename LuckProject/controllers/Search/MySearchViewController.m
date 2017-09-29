//
//  MySearchViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/28.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "MySearchViewController.h"

#import "SeconedDetialViewController.h"
#import "SeconedTableViewCell.h"
#import "DetialViewController.h"

@interface MySearchViewController ()

@property (nonatomic, assign)NSInteger page;

@property (nonatomic, strong)NSMutableArray *dataSouce;

@property (nonatomic, assign)BOOL isTrack;

@property (nonatomic, copy)NSString *flag;

@property (nonatomic, strong)NSIndexPath *selectFlag;


@end

@implementation MySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSouce = [NSMutableArray array];
    self.navigationItem.title = [self.keyword stringByAppendingString:@".单曲"];
    self.isTrack = YES;
    [self createUI];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:YES WithFootRefresh:YES WithScrollIndicator:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"SeconedTableViewCell" bundle:nil] forCellReuseIdentifier:@"seconeddetial"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setTitle:@"选择" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
    
}

-(void)fetchDataIsTracck:(BOOL)istrack page:(NSInteger)page{
    
    [self showBaseHud];
    
    [MXAPI getSearchResultListBykeyword:self.keyword isTrack:istrack page:page callblock:^(NSMutableArray *data, NSString *error) {
        if (data) {
            [self.dataSouce removeAllObjects];
            [self.dataSouce addObjectsFromArray:data];
            [self dismissHudWithSuccessTitle:@"" After:1.f];
            
        }else{
            [self dismissHudWithErrorTitle:error After:1.f];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)loadDataIsTrack:(BOOL)istrack page:(NSInteger)page{
    
    [self showBaseHud];
    
    [MXAPI getSearchResultListBykeyword:self.keyword isTrack:istrack page:page callblock:^(NSMutableArray *data, NSString *error) {
        if (data) {
            [self.dataSouce addObjectsFromArray:data];
            [self dismissHudWithSuccessTitle:@"" After:1.f];
            
        }else{
            [self dismissHudWithErrorTitle:error After:1.f];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSouce.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SeconedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seconeddetial"];
    if (!cell) {
        cell = [[SeconedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seconeddetial"];
    }
    if (self.isTrack) {
        ShiCiDetialModel *model = self.dataSouce[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.headView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:nil];
        cell.seconedTitle.text = model.title;
        
    }else{
        ShiciModel *model = self.dataSouce[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:nil];
        cell.seconedTitle.text = model.title;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isTrack) {
        
        ShiCiDetialModel *model = self.dataSouce[indexPath.row];
        
        PlayerViewController *vc = [PlayerViewController sharedInstance];
        vc.modelArr = [NSMutableArray arrayWithArray:self.dataSouce];
        vc.currtenflag = indexPath.row;
        [vc playCurrtnItem:model];
        self.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController presentViewController:vc animated:YES completion:nil];
        
        
    }else{
        
        ShiciModel *model = self.dataSouce[indexPath.row];
        DetialViewController *vc = [[DetialViewController alloc]init];
        vc.model = model;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

-(void)tableViewHeadRefresh{
    
    self.page  = 1;
    [self fetchDataIsTracck:self.isTrack page:self.page];
}
-(void)tableViewFootRefresh{
    
    self.page++;
    [self loadDataIsTrack:self.isTrack page:self.page];
}


#pragma mark -click

-(void)changeClick:(UIButton*)button{
    
    
    self.popView = [[ZYFPopview alloc]initInView:[UIApplication sharedApplication].keyWindow tip:@"选择类型" images:(NSMutableArray*)@[] rows:(NSMutableArray*)@[@"单曲",@"专辑"] doneBlock:^(NSInteger selectIndex) {
        self.page = 1;
        if (selectIndex) {
            self.isTrack = NO;
            self.navigationItem.title = [self.keyword stringByAppendingString:@".专辑"];
        }else{
            self.isTrack = YES;
            self.navigationItem.title = [self.keyword stringByAppendingString:@".单曲"];
        }
        [self.tableView.mj_header beginRefreshing];
        
    } cancleBlock:^{
        
        
    }];
    [self.popView showPopView];
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
