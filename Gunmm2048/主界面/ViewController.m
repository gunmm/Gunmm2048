//
//  ViewController.m
//  Gunmm2048
//
//  Created by 闵哲 on 2016/12/22.
//  Copyright © 2016年 Gunmm. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "MthedClass.h"
static NSString *identifier = @"cell";


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>




@end

@implementation ViewController
{
    UICollectionView *_collectionView;
    MthedClass *methC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化UI
    [self initUI];
    
    //初始化算法对象
    methC = [[MthedClass alloc]init];

    //初始化Collection
    [self initCollection];

    
    //最高分
    NSNumber *num = [kUserDefaults objectForKey:@"HighestScore"];
    if (num) {
        _zuiGaoScore.text = [NSString stringWithFormat:@"%@",num];
    }else{
        _zuiGaoScore.text = @"0";

    }

    //添加手势
    [self addGest];
}


//新游戏按钮事件
- (IBAction)newGameBtnAct:(id)sender {
    //重新初始化一个算法对象
    methC = [[MthedClass alloc]init];
    //刷新_collectionView
    [_collectionView reloadData];
    _scoreL.text = @"0";
    
}

//初始化UI
- (void)initUI{
    _bgView1.layer.cornerRadius = 4;
    _bgView1.layer.masksToBounds = YES;
    
    _deFenL.alpha = 0.7;
    _scoreL.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    _bgView2.layer.cornerRadius = 4;
    _bgView2.layer.masksToBounds = YES;
    
    _zuiGaoL.alpha = 0.7;
    _zuiGaoScore.adjustsFontSizeToFitWidth = YES;
    
    _btn.layer.cornerRadius = 5;
    _btn.layer.masksToBounds = YES;
    _btn.backgroundColor = [UIColor colorWithDisplayP3Red:240/255.0 green:152/255.0 blue:100/255.0 alpha:1];
    
    
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = [UIColor colorWithDisplayP3Red:237/255.0 green:195/255.0 blue:63/255.0 alpha:1];
    
    
}





- (void)addGest{
    //上
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAct:)];
    
    //设置清扫手势的方向
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    //添加清扫手势
    [_collectionView addGestureRecognizer:swipe];
    
    
    //下
   swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAct:)];
    
    //设置清扫手势的方向
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    //添加清扫手势
    [_collectionView addGestureRecognizer:swipe];
    
    //左
    swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAct:)];
    
    //设置清扫手势的方向
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    //添加清扫手势
    [_collectionView addGestureRecognizer:swipe];
    
    //右
    swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAct:)];
    
    //设置清扫手势的方向
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    //添加清扫手势
    [_collectionView addGestureRecognizer:swipe];

}


//清扫方法
- (void)swipeAct:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        //向上 清除空格和合并
        BOOL a = [methC up_remove_blank];
        BOOL b = [methC up_combine];
        //如果有空格被清除 或者 有被合并的   插入新的数字
        if (a || b) {
            [methC insertNumber];
        }
        
        [_collectionView reloadData];
        _scoreL.text = [NSString stringWithFormat:@"%ld",(long)methC.score];
    
        //判断最高分
        [self judgeHighestScoreWithScore:methC.score];
        
        //插入后判断游戏是否结束
        if ([methC judgeWhetherDeath]) {
            [self showAlert];
        }

    }
    else if(swipe.direction == UISwipeGestureRecognizerDirectionDown)
    {
        BOOL a = [methC down_remove_blank];
        BOOL b = [methC down_combine];
        
        if (a || b) {
            [methC insertNumber];
        }
        [UIView animateWithDuration:0.3 animations:^{
            [_collectionView reloadData];
            
        }];
        _scoreL.text = [NSString stringWithFormat:@"%ld",(long)methC.score];
        //判断最高分
        [self judgeHighestScoreWithScore:methC.score];

        
        
        if ([methC judgeWhetherDeath]) {
            [self showAlert];
        }

    }else if(swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        BOOL a = [methC left_remove_blank];
        BOOL b = [methC left_combine];
        
        if (a || b) {
            [methC insertNumber];
        }
        
        [_collectionView reloadData];
        _scoreL.text = [NSString stringWithFormat:@"%ld",(long)methC.score];
        //判断最高分
        [self judgeHighestScoreWithScore:methC.score];

        
        if ([methC judgeWhetherDeath]) {
            [self showAlert];
        }

    }else if(swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        BOOL a = [methC right_remove_blank];
        BOOL b = [methC right_combine];
        
        if (a || b) {
            [methC insertNumber];
        }
        [_collectionView reloadData];
        _scoreL.text = [NSString stringWithFormat:@"%ld",(long)methC.score];
        //判断最高分
        [self judgeHighestScoreWithScore:methC.score];

        
        
        if ([methC judgeWhetherDeath]) {
            [self showAlert];
        }
    }
}

//判断最高分
- (void)judgeHighestScoreWithScore:(NSInteger)score{
    NSNumber *num = [kUserDefaults objectForKey:@"HighestScore"];
    if (num) {
        if ([num integerValue]<= score) {
            [kUserDefaults setObject:[NSNumber numberWithInteger:score] forKey:@"HighestScore"];
            _zuiGaoScore.text = [NSString stringWithFormat:@"%ld",(long)score];

        }
    }else{
        [kUserDefaults setObject:[NSNumber numberWithInteger:score] forKey:@"HighestScore"];
        _zuiGaoScore.text = [NSString stringWithFormat:@"%ld",(long)score];
    }
}


- (void)showAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"GAME OVER" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        methC = [[MthedClass alloc]init];
        
        
        [_collectionView reloadData];
        _scoreL.text = @"0";
        
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}


//
- (void)initCollection{
    
    
    //1.创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //2.设置单元格属性
    //设置单元格大小
    layout.itemSize = CGSizeMake((kDeviceWidth-15 - 40 - 16)/4, (kDeviceWidth-15-40 - 16)/4);
    
    //设置单元格之间的间隙， 水平方向 默认为10
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5/3;

    
    
    
    //设置滚动方向
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置头部视图大小
    //    layout.headerReferenceSize = CGSizeMake(65 , 165);
    //    //设置尾部视图大小
    //    layout.footerReferenceSize = CGSizeMake(65, 165);
    
    //2.实例化UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 100, kDeviceWidth-40, kDeviceWidth-40) collectionViewLayout:layout];
    
    _collectionView.top = kDeviceHeight/2 - _collectionView.height/2 + 30;
    
    _collectionView.backgroundColor = [UIColor colorWithDisplayP3Red:185/255.0 green:171/255.0 blue:160/255.0 alpha:1];
    
    _collectionView.layer.borderWidth = 8;
    _collectionView.layer.borderColor = [UIColor colorWithDisplayP3Red:185/255.0 green:171/255.0 blue:160/255.0 alpha:1].CGColor;
    
    _collectionView.layer.cornerRadius = 4;
    _collectionView.layer.masksToBounds = YES;
    
    
    //3.设置数据代理 和数据源协议
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    
    //4.添加到窗口
    [self.view addSubview:_collectionView];
    
    //5.注册单元格  系统自动复用池查看
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:identifier];

    
    
    
}


//返回单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
}

//返回单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //通过注册的方式注册单元格  不需要判断是否从复用池中拿到单元格
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSInteger sec = indexPath.row/4;
    NSInteger roww = indexPath.row%4;

    
    
    
    
    if ([methC.dataArray[sec][roww] integerValue]==0) {
        cell.textValue = @"";
    }else{
        cell.textValue = [NSString stringWithFormat:@"%@",methC.dataArray[sec][roww]];

    }
    
    cell.backgroundColor = [UIColor colorWithDisplayP3Red:202/255.0 green:190/255.0 blue:179/255.0 alpha:1];
    
    //返回单元格
    return cell;
    
    
    
    
}

//设置四周间距 上下左右
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8,8,8,8);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
