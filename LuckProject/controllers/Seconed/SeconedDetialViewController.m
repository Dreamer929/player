//
//  SeconedDetialViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/28.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "SeconedDetialViewController.h"
#import "SeconedTableViewCell.h"
#import "DetialViewController.h"

@interface SeconedDetialViewController ()

@property (nonatomic, strong)NSMutableArray *dataSouce;
@property (nonatomic, assign)NSInteger page;

@end

@implementation SeconedDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createUI{
    self.dataSouce = [NSMutableArray array];
    self.navigationItem.title = self.keyword;
    [self initTableViewWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H) WithHeadRefresh:YES WithFootRefresh:YES WithScrollIndicator:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"SeconedTableViewCell" bundle:nil] forCellReuseIdentifier:@"seconeddetial"];

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 32, 32);
    [rightBtn setImage:ECIMAGENAME(@"music") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(popPlayerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    
}


#pragma mark -click

-(void)popPlayerClick:(UIButton*)button{
    
    PlayerViewController *vc = [PlayerViewController sharedInstance];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark -netquest

-(void)netquest{
    [self showBaseHud];
    self.page = 1;
    [MXAPI getShiCiListByKeyword:self.keyword page:self.page dataBlock:^(NSMutableArray *data, NSString *error) {
        
        if (data) {
            [self.dataSouce removeAllObjects];
            [self.dataSouce addObjectsFromArray:data];
            [self.tableView reloadData];
            [self dismissHudWithSuccessTitle:@"" After:1.f];
        }else{
            [self dismissHudWithErrorTitle:error After:1.f];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)loadData{
    
    [self showBaseHud];
    self.page++;
    [MXAPI getShiCiListByKeyword:self.keyword page:self.page dataBlock:^(NSMutableArray *data, NSString *error) {
        
        if (data) {
            [self.dataSouce addObjectsFromArray:data];
            [self.tableView reloadData];
            [self dismissHudWithSuccessTitle:@"" After:1.f];
        }else{
            [self dismissHudWithErrorTitle:error After:1.f];
        }
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -tableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSouce.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SeconedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"seconeddetial" forIndexPath:indexPath];
    if (!cell) {
        cell = [[SeconedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seconeddetial"];
    }
    ShiciModel *model = self.dataSouce[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.headView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:ECIMAGENAME(@"zhanwei")];
    cell.seconedTitle.text = model.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShiciModel *model = self.dataSouce[indexPath.row];
    DetialViewController *vc = [[DetialViewController alloc]init];
    vc.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)tableViewHeadRefresh{
    [self netquest];
}

-(void)tableViewFootRefresh{
    [self loadData];
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
