//
//  ViewController.h
//  Gunmm2048
//
//  Created by 闵哲 on 2016/12/22.
//  Copyright © 2016年 Gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreL;



//用户
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameL;

@property (weak, nonatomic) IBOutlet UILabel *paiMingL;

//需要设置UI的控件
//得分view
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UILabel *deFenL;
@property (weak, nonatomic) IBOutlet UILabel *deFenScoreL;

//最高分View
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (weak, nonatomic) IBOutlet UILabel *zuiGaoL;
@property (weak, nonatomic) IBOutlet UILabel *zuiGaoScore;

@property (weak, nonatomic) IBOutlet UIButton *btn;





@end

