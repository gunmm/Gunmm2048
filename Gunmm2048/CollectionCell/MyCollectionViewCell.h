//
//  MyCollectionViewCell.h
//  Gunmm2048
//
//  Created by 闵哲 on 2016/12/22.
//  Copyright © 2016年 Gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberL;



@property(nonatomic,copy)NSString *textValue;
@end
