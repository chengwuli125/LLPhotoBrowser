//
//  PhotoEntryCollectionViewCell.m
//  LLPhotoBrowser
//
//  Created by cwli on 2017/9/5.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "PhotoEntryCollectionViewCell.h"

@implementation PhotoEntryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self setupSubviews];
    return self;
}


- (void)setupSubviews
{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.frame;
}


@end
