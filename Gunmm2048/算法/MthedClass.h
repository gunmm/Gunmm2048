//
//  MthedClass.h
//  Gunmm2048
//
//  Created by 闵哲 on 2016/12/22.
//  Copyright © 2016年 Gunmm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MthedClass : NSObject

//存放游戏结果
@property (nonatomic, retain) NSMutableArray *dataArray;
//存放分数
@property (nonatomic, assign) NSInteger score;


/**
 生成新的格子 插入数组
 */
- (void)insertNumber;


/**
 判断游戏结束

 @return 是否游戏结束
 */
- (BOOL)judgeWhetherDeath;



/**
 向上移除空格
 
 @return 是否有移除
 */
- (BOOL)up_remove_blank;

/**
 向上合并相同的格子

 @return 是否有合并
 */
- (BOOL)up_combine;


/**
 向下的两个方法
 */
- (BOOL)down_remove_blank;
- (BOOL)down_combine;

/**
 向左的两个方法
 */
- (BOOL)left_remove_blank;
- (BOOL)left_combine;

/**
 向右的两个方法
 */
- (BOOL)right_remove_blank;
- (BOOL)right_combine;









@end
