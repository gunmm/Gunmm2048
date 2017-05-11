//
//  MthedClass.m
//  Gunmm2048
//
//  Created by 闵哲 on 2016/12/22.
//  Copyright © 2016年 Gunmm. All rights reserved.
//

#import "MthedClass.h"

@implementation MthedClass


/**
 重写init

 */
- (instancetype)init{
    if (self = [super init]) {
        _dataArray = [NSMutableArray array];
        //初始化存放数据的array   0表示空
        for (int i = 0; i < 4; i ++) {
            NSMutableArray *arr = [NSMutableArray array];
            for (int j = 0; j < 4; j ++) {
                [arr addObject:@(0)];
            }
            [_dataArray addObject:arr];
        }
        
        //插入两个数  做初始值
        [self insertNumber];
        [self insertNumber];
        //总分置零
        _score = 0;

    }
    
    return self;
}

/**
 判断是否死亡

 @return 返回游戏是否结束
 */
- (BOOL)judgeWhetherDeath{
    //向上是否还能操作
    BOOL upJudge = [self judgeUp];
    //向下是否还能操作
    BOOL downJudge = [self judgeDown];
    //向左是否还能操作
    BOOL leftJudge = [self judgeLeft];
    //向右是否还能操作
    BOOL rightJudge = [self judgeRight];
    
    BOOL result = !upJudge&&!downJudge&&!leftJudge&&!rightJudge;
    return result;
}

/**
 随机生成一个数插入
 */
- (void)insertNumber{
    //i,j代表数组的第i组的第j个
    int i = 0,j = 0;
    
    //循环找可以插的位置插入数据
    do {
        i = arc4random() % 4;
        j = arc4random() % 4;
        
        //判断是否可插
        if ([_dataArray[i][j] intValue]==0) {
            NSLog(@"%d,,,,,%d",i,j);
            //用来判断插入 2 还是 4   numb是9则插入4  否则 插入2
            int numb = arc4random() % 10;
            if (numb == 9) {
                _dataArray[i][j] = @(4);
            }else{
                _dataArray[i][j] = @(2);
            }
            //成功插入后跳出
            break;
        }

    } while (1);
}

//上

/**
 判断不为空的位置上面是否有空位置  有的话则交换

 @return 返回是否有交换过
 */
- (BOOL)up_remove_blank{
    //i 表示第i纵列    j表示第j横行
    int i,j,k;
    //用来标记是否有空格被换下
    BOOL sign = NO;
    
    //循环遍历  外层固定i(也就是固定纵列)
    for(i=0;i<4;i++){
        
        //里面比较j(比较同一列的各行)
        for(j=1;j<4;j++){
            //用来存本行上面还有几行
            k=j;
            
            //从本行开始向上每一行依次便利
            while(k-1>=0&&[(_dataArray[k-1][i])intValue]==0){//判断上面的那个为空
                //判断当前位置是否为空  如果不为空 与上一行交换  为空则不懂
                if ([(_dataArray[k][i])intValue] != 0) {
                    [self swapWithi1:i withJ1:(k-1) withI1:i withJ2:k];
                    //如果交换了标记 交换了
                    sign = YES;
                }
                k--;
            }
        }
    }
    
    
    return sign;

}


/**
 判断向上是否有可合并的位置

 @return 是否合并过
 */
- (BOOL)up_combine{
    //i 表示第i纵列    j表示第j横行
    int i,j;
    BOOL sign = NO;
    //外层循环固定列
    for(i=0;i<4;i++){
        for(j=0;j<3;j++){
            //判断同一列的相邻行之间是否可以合并
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j+1][i] integerValue]) {
                _dataArray[j][i] = @(2*[_dataArray[j][i] integerValue]);
                //可合并的话加分
                _score += [_dataArray[j][i] integerValue];
                _dataArray[j+1][i] = @(0);
                sign = YES;
            }
        }
    }
    //执行一次向上的空格交换  因为合并后会有新的空格出现
    [self up_remove_blank];
    return sign;
}


/**
 跟上面的除空格  和 合并的思想一样  只是这次是用来判断是否还有空格或者有可以合并的位置  不改变数组的值

 @return 返回在向上方向是否还可以有操作
 */
- (BOOL)judgeUp{
    int i,j,k;
    BOOL sign1 = NO;
    BOOL sign2 = NO;

    for(i=0;i<4;i++){
        for(j=1;j<4;j++){
            k=j;
            while(k-1>=0&&[(_dataArray[k-1][i])intValue]==0){//上面的那个为空
                if ([(_dataArray[k][i])intValue] != 0) {
                    sign1 = YES;
                }
                k--;
            }
        }
    }
    
    for(i=0;i<4;i++){
        for(j=0;j<3;j++){
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j+1][i] integerValue]) {
                sign2 = YES;
            }
            
        }
    }

    return (sign1||sign2);

}
//下
- (BOOL)down_remove_blank{
    int i,j,k;
    BOOL sign = NO;
    for(i=0;i<4;i++){
        for(j=2;j>=0;j--){
            k=j;
            while(k+1<=3&&[(_dataArray[k+1][i])intValue]==0){//上面的那个为空
                if ([(_dataArray[k][i])intValue] != 0) {
                    [self swapWithi1:i withJ1:(k+1) withI1:i withJ2:k];
                    sign = YES;
                    
                }
                k++;
            }
        }
    }
    
    
    return sign;
    
}
- (BOOL)down_combine{
    int i,j;
    BOOL sign = NO;
    for(i=0;i<4;i++){
        for(j=3;j>0;j--){
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j-1][i] integerValue]) {
                _dataArray[j][i] = @(2*[_dataArray[j][i] integerValue]);
                _score += [_dataArray[j][i] integerValue];

                _dataArray[j-1][i] = @(0);
                sign = YES;
            }
            
        }
    }
    
    [self down_remove_blank];
    
    
    return sign;
    
    
}

- (BOOL)judgeDown{
    int i,j,k;
    BOOL sign1 = NO;
    BOOL sign2 = NO;
    
    for(i=0;i<4;i++){
        for(j=2;j>=0;j--){
            k=j;
            while(k+1<=3&&[(_dataArray[k+1][i])intValue]==0){//上面的那个为空
                if ([(_dataArray[k][i])intValue] != 0) {
                    sign1 = YES;
                }
                k++;
            }
        }
    }
    
    for(i=0;i<4;i++){
        for(j=3;j>0;j--){
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j-1][i] integerValue]) {
                sign2 = YES;
            }
            
        }
    }
    return (sign1||sign2);
    
}


//左
- (BOOL)left_remove_blank{
    int i,j,k;
    BOOL sign = NO;
    for(j=0;j<4;j++){
        for(i=1;i<4;i++){
            k=i;
            while(k-1>=0&&[(_dataArray[j][k-1])intValue]==0){//上面的那个为空
                if ([(_dataArray[j][k])intValue] != 0) {
                    [self swapWithi1:(k-1) withJ1:j withI1:k withJ2:j];
                    sign = YES;
                    
                }
                k--;
            }
        }
    }
    
    
    return sign;
}
- (BOOL)left_combine{
    int i,j;
    BOOL sign = NO;
    for(j=0;j<4;j++){
        for(i=0;i<3;i++){
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j][i+1] integerValue]) {
                _dataArray[j][i] = @(2*[_dataArray[j][i] integerValue]);
                _score += [_dataArray[j][i] integerValue];

                _dataArray[j][i+1] = @(0);
                sign = YES;
            }
            
        }
    }
    
    [self left_remove_blank];
    
    
    return sign;
    
    
}

- (BOOL)judgeLeft{
    int i,j,k;
    BOOL sign1 = NO;
    BOOL sign2 = NO;
    
    for(j=0;j<4;j++){
        for(i=1;i<4;i++){
            k=i;
            while(k-1>=0&&[(_dataArray[j][k-1])intValue]==0){//上面的那个为空
                if ([(_dataArray[j][k])intValue] != 0) {
                    sign1 = YES;
                }
                k--;
            }
        }
    }

    
    for(j=0;j<4;j++){
        for(i=0;i<3;i++){
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j][i+1] integerValue]) {
                sign2 = YES;
            }
            
        }
    }
    return (sign1||sign2);
    
}
//右
- (BOOL)right_remove_blank{
    int i,j,k;
    BOOL sign = NO;
    for(j=0;j<4;j++){
        for(i=2;i>=0;i--){
            k=i;
            while(k+1<=3&&[(_dataArray[j][k+1])intValue]==0){//上面的那个为空
                if ([(_dataArray[j][k])intValue] != 0) {
                    [self swapWithi1:k+1 withJ1:j withI1:k withJ2:j];
                    sign = YES;
                    
                }
                k++;
            }
        }
    }
    
    
    return sign;
    
}
- (BOOL)right_combine{
    int i,j;
    BOOL sign = NO;
    for(j=0;j<4;j++){
        for(i=3;i>0;i--){
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j][i-1] integerValue]) {
                _dataArray[j][i] = @(2*[_dataArray[j][i] integerValue]);
                _score += [_dataArray[j][i] integerValue];

                _dataArray[j][i-1] = @(0);
                sign = YES;
            }
            
        }
    }
    
    [self right_remove_blank];
    
    
    return sign;
    
    
}

- (BOOL)judgeRight{
    int i,j,k;
    BOOL sign1 = NO;
    BOOL sign2 = NO;
    
    for(j=0;j<4;j++){
        for(i=2;i>=0;i--){
            k=i;
            while(k+1<=3&&[(_dataArray[j][k+1])intValue]==0){//上面的那个为空
                if ([(_dataArray[j][k])intValue] != 0) {
                    sign1 = YES;
                    
                }
                k++;
            }
        }
    }
    
    for(j=0;j<4;j++){
        for(i=3;i>0;i--){
            if ([_dataArray[j][i] integerValue] != 0 && [_dataArray[j][i] integerValue] == [_dataArray[j][i-1] integerValue]) {
                sign2 = YES;
            }
            
        }
    }
    return (sign1||sign2);
    
}





//交换数组中两个元素位置
- (void)swapWithi1:(int)i1 withJ1:(int)j1 withI1:(int)i2 withJ2:(int)j2{
    NSNumber *number1 = _dataArray[j1][i1];
    _dataArray[j1][i1] = _dataArray[j2][i2];
    _dataArray[j2][i2] = number1;
}




@end
