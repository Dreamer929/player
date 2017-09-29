//
//  SeconedViewController.m
//  LuckProject
//
//  Created by moxi on 2017/9/25.
//  Copyright © 2017年 moxi. All rights reserved.
//

#import "SeconedViewController.h"

#import "SeconedDetialViewController.h"

@interface SeconedViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *myScrollView;

@end

@implementation SeconedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UI

-(void)createUI{
    
    
    self.navigationItem.title = @"开怀笑";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 32, 32);
    [rightBtn setImage:ECIMAGENAME(@"music") forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(popPlayerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    
   // self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DREAMCSCREEN_W, DREAMCSCREEN_H - 49)];
    self.myScrollView.bounces = NO;
    
    self.myScrollView.backgroundColor = ECCOLOR(230, 230, 230, 1);
    self.myScrollView.delegate = self;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.contentSize = CGSizeMake(DREAMCSCREEN_W, 441 + (DREAMCSCREEN_W - 4)/3*2 - 49);
    [self.view addSubview:self.myScrollView];
    
    CGFloat scrollViewW = self.myScrollView.bounds.size.width;
    UIImageView *titleImage = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"diantai")];
    titleImage.frame = CGRectMake(0, 0, scrollViewW, 150);//150
    titleImage.userInteractionEnabled = YES;
    titleImage.tag = 9;
    [titleImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(diantaiAction:)]];
    [self.myScrollView addSubview:titleImage];
    
    //电台、笑话大全、故事汇、成语、歇后语、童话、说书、纯音乐、钢琴曲、小提琴、吉他、阿卡贝拉
    
    NSArray *imgArr = @[@"joke",@"zyf5"];
    NSArray *titleArr = @[@"笑话大全",@"故事汇"];

    for (NSInteger index = 0; index<imgArr.count; index++) {
        
        CGFloat jokeW = (scrollViewW - 15)/2;
        CGFloat jokeH = 90;
        UIImageView *jokeImg = [[UIImageView alloc]initWithImage:ECIMAGENAME(imgArr[index])];
        //150 + 10 + 120 + 10 + 120 + 30
        jokeImg.frame = CGRectMake(5 + index*jokeW + 5*index, 150 + 10, jokeW, jokeH);
        jokeImg.tag = index + 10;
        jokeImg.userInteractionEnabled = YES;
        [jokeImg addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(diantaiAction:)]];
        [self.myScrollView addSubview:jokeImg];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(5 + index*jokeW + 5*index, 150 + 5 + jokeH, jokeW, 30)];
        lable.text = titleArr[index];
        lable.backgroundColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14];
        [self.myScrollView addSubview:lable];
    }
    
    UIImageView *CYimg = [[UIImageView alloc]initWithImage:ECIMAGENAME(@"zyf1")];
    CYimg.frame = CGRectMake(2, 150 + 130, scrollViewW/2 - 60, 120);
    CYimg.userInteractionEnabled = YES;
    CYimg.tag = 22;
    [CYimg addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(diantaiAction:)]];
    [self.myScrollView addSubview:CYimg];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(2, 150 + 130 + 120, scrollViewW/2 - 60, 30)];
    lable.text = @"趣说成语";
    lable.backgroundColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.myScrollView addSubview:lable];
    
    NSArray *imgData = @[@"zyf3",@"zyf4"];
    NSArray *titData = @[@"歇后语",@"童话故事"];
    for (NSInteger index = 0; index<titData.count;index++) {
        
        UIImageView *image = [[UIImageView alloc]initWithImage:ECIMAGENAME(imgData[index])];
        image.frame = CGRectMake(4 + CYimg.bounds.size.width, (150 + 130)+index*2 + index*74,scrollViewW - 6 - CYimg.bounds.size.width , 74);
        image.tag = index + 20;
        image.userInteractionEnabled = YES;
        [image addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(diantaiAction:)]];
        [self.myScrollView addSubview:image];
    }
    
    NSArray *imgs = @[@"chunyinyue",@"zyf7",@"zyf2",@"gangqin",@"guitar",@"zyf6"];
    NSArray *titles = @[@"纯音乐",@"阿卡贝拉",@"说书",@"钢琴曲",@"吉他",@"小提琴"];
    
    for (NSInteger i = 0;i<imgs.count; i++) {
        NSInteger index = i%3;
        NSInteger page = i/3;
        CGFloat itemW = (scrollViewW - 4)/3;
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(index * (itemW + 1) + 1, page  * (itemW + 1)+ 440, itemW, itemW)];
        baseView.tag = 30 + i;
        baseView.backgroundColor = [UIColor whiteColor];
        [baseView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(diantaiAction:)]];
        
        UIImageView *myImg = [[UIImageView alloc]initWithImage:ECIMAGENAME(imgs[i])];
        myImg.userInteractionEnabled = YES;
        myImg.frame = CGRectMake(0, 0, itemW, itemW - 30);
        [baseView addSubview:myImg];
        
        UILabel *lable = [[UILabel alloc]init];
        lable.frame = CGRectMake(0, itemW - 30, itemW, 30);
        lable.text = titles[i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14];
        [baseView addSubview:lable];
        
        [self.myScrollView addSubview:baseView];

    }
    
    
}


#pragma mark -click

-(void)popPlayerClick:(UIButton*)button{
    
    PlayerViewController *vc = [PlayerViewController sharedInstance];
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)diantaiAction:(UITapGestureRecognizer*)tap{
    NSInteger index = tap.view.tag;
    NSString *keyword;
    switch (index) {
        case 9:
        {
            keyword = @"电台";
        }
            break;
        case 10:
        {
            keyword = @"笑话大全";
        }
            break;
        case 11:
        {
            keyword = @"故事汇";
        }
            break;
        case 22:
        {
            keyword = @"成语";
        }
            break;
        case 20:
        {
            keyword = @"歇后语";
        }
            break;
        case 21:
        {
            keyword = @"童话";
        }
            break;
        case 30:
        {
            keyword = @"纯音乐";
        }
            break;
        case 31:
        {
            keyword = @"阿卡贝拉";
        }
            break;
        case 32:
        {
            keyword = @"说书";
        }
            break;
        case 33:
        {
            keyword = @"钢琴曲";
        }
            break;
        case 34:
        {
            keyword = @"吉他";
        }
            break;
        case 35:
        {
            keyword = @"小提琴";
        }
            break;
            
        default:
            break;
    }
    SeconedDetialViewController *vc = [[SeconedDetialViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    vc.keyword = keyword;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
