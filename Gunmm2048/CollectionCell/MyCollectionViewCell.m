//
//  MyCollectionViewCell.m
//  Gunmm2048
//
//  Created by 闵哲 on 2016/12/22.
//  Copyright © 2016年 Gunmm. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"MyCollectionViewCell" owner:self options:nil]lastObject];

    }
    
    
    return self;
    
}

- (void)setTextValue:(NSString *)textValue{
    _textValue = textValue;
    
    _numberL.text = _textValue;
    if ([_textValue isEqualToString:@""]) {
        _numberL.backgroundColor = [UIColor clearColor];
    }else if ([_textValue isEqualToString:@"2"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:236/255.0 green:225/255.0 blue:216/255.0 alpha:1];
        _numberL.textColor = [UIColor colorWithDisplayP3Red:114/255.0 green:105/255.0 blue:96/255.0 alpha:1];
    }if ([_textValue isEqualToString:@"4"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:235/255.0 green:221/255.0 blue:200/255.0 alpha:1];
        _numberL.textColor = [UIColor colorWithDisplayP3Red:118/255.0 green:109/255.0 blue:101/255.0 alpha:1];

    }if ([_textValue isEqualToString:@"8"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:242/255.0 green:175/255.0 blue:127/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];

    }if ([_textValue isEqualToString:@"16"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:246/255.0 green:147/255.0 blue:106/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];

    }if ([_textValue isEqualToString:@"32"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:248/255.0 green:121/255.0 blue:99/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];

    }if ([_textValue isEqualToString:@"64"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:248/255.0 green:91/255.0 blue:67/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];

    }if ([_textValue isEqualToString:@"128"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:236/255.0 green:204/255.0 blue:125/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];

    }if ([_textValue isEqualToString:@"256"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:236/255.0 green:201/255.0 blue:111/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];

    }if ([_textValue isEqualToString:@"512"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:236/255.0 green:196/255.0 blue:98/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];

    }if ([_textValue isEqualToString:@"1024"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:236/255.0 green:196/255.0 blue:98/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];
        
        _numberL.adjustsFontSizeToFitWidth = YES;

        
    }if ([_textValue isEqualToString:@"2048"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:236/255.0 green:196/255.0 blue:98/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];
        _numberL.adjustsFontSizeToFitWidth = YES;


    }if ([_textValue isEqualToString:@"4096"]) {
        _numberL.backgroundColor = [UIColor colorWithDisplayP3Red:236/255.0 green:196/255.0 blue:98/255.0 alpha:1];
        _numberL.textColor = [UIColor whiteColor];
        _numberL.adjustsFontSizeToFitWidth = YES;


    }
}

@end
