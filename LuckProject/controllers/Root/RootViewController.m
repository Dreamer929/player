//
//  RootViewController.m
//  LuckProject
//
//  Created by moxi on 2017/6/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "RootViewController.h"

#import "MineViewController.h"
#import "HomeViewController.h"
#import "SeconedViewController.h"
#import "SearchViewController.h"


@interface RootViewController ()

@property (nonatomic, strong)NSMutableArray *viewControllerData;

@end

@implementation RootViewController

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self configTabBarModel];
        [self createContentViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark meatch

-(void)configTabBarModel{
    
    self.viewControllerData = [NSMutableArray array];
    
    RootModel *homeModel = [RootModel modelWithTitle:@"首页" normalImage:@"home" selectedImage:@"home_s" className:@"HomeViewController"];
    RootModel *seconedModel = [RootModel modelWithTitle:@"娱乐" normalImage:@"happy" selectedImage:@"happy_s" className:@"SeconedViewController"];
    RootModel *searchModel = [RootModel modelWithTitle:@"搜索" normalImage:@"search" selectedImage:@"search_s" className:@"SearchViewController"];
    RootModel *MineModel = [RootModel modelWithTitle:@"定制" normalImage:@"faxian" selectedImage:@"faxian_s" className:@"MineViewController"];//根据不同的字段来存档，定制首页的内容 电台、笑话大全、故事汇、成语、歇后语、童话、说书、纯音乐、钢琴曲、小提琴、吉他、阿卡贝拉、
    
    [self.viewControllerData addObject:homeModel];
    [self.viewControllerData addObject:seconedModel];
    [self.viewControllerData addObject:searchModel];
    [self.viewControllerData addObject:MineModel];
}

-(void)createContentViewControllers{
    
    NSMutableArray *viewcontrollerArr = [NSMutableArray array];
    
    for (NSInteger index = 0; index < self.viewControllerData.count; index++) {
        
        RootModel *model = self.viewControllerData[index];
        
        UIViewController *viewcontroller = [[NSClassFromString(model.className) alloc]init];
        viewcontroller.title = model.tabbarTitle;
        
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
        nvc.tabBarItem.title = model.tabbarTitle;
        nvc.tabBarItem.image = [model normalImage];
        nvc.tabBarItem.selectedImage = [model selectedImage];
        
        nvc.navigationBar.barTintColor = [UIColor redColor];
        nvc.navigationBar.tintColor = [UIColor whiteColor];
        [nvc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        
        [viewcontrollerArr addObject:nvc];
    }
    
    self.tabBar.tintColor = [UIColor redColor];
    
    self.viewControllers = viewcontrollerArr;
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
