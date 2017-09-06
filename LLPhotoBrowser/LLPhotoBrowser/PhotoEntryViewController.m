//
//  PhotoEntryViewController.m
//  LLPhotoBrowser
//
//  Created by cwli on 2017/9/5.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "PhotoEntryViewController.h"
#import "PhotoEntryCollectionViewCell.h"

@interface PhotoEntryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

// 缩列图
@property (nonatomic, strong) NSMutableArray<NSString *> *thumbnailImageUrls;

// 大图
@property (nonatomic, strong) NSMutableArray<NSString *> *highQualityImageUrls;

// collection
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PhotoEntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self updateCurrentData];
    
    [self setupSubviews];
}

- (void)updateCurrentData
{
    self.thumbnailImageUrls = [NSMutableArray arrayWithObjects:
                               @"http://wx1.sinaimg.cn/thumbnail/bfc243a3gy1febm7n9eorj20i60hsann.jpg",
                               @"http://wx3.sinaimg.cn/thumbnail/bfc243a3gy1febm7nzbz7j20ib0iek5j.jpg",
                               @"http://wx1.sinaimg.cn/thumbnail/bfc243a3gy1febm7orgqfj20i80ht15x.jpg",
                               @"http://wx2.sinaimg.cn/thumbnail/bfc243a3gy1febm7pmnk7j20i70jidwo.jpg",
                               @"http://wx3.sinaimg.cn/thumbnail/bfc243a3gy1febm7qjop4j20i00hw4c6.jpg",
                               @"http://wx4.sinaimg.cn/thumbnail/bfc243a3gy1febm7rncxaj20ek0i74dv.jpg",
                               @"http://wx2.sinaimg.cn/thumbnail/bfc243a3gy1febm7sdk4lj20ib0i714u.jpg",
                               @"http://wx4.sinaimg.cn/thumbnail/bfc243a3gy1febm7tekewj20i20i4aoy.jpg",
                               @"http://wx3.sinaimg.cn/thumbnail/bfc243a3gy1febm7usmc8j20i543zngx.jpg",nil];
    
    self.highQualityImageUrls = [NSMutableArray arrayWithObjects:
                                 @"http://wx1.sinaimg.cn/large/bfc243a3gy1febm7n9eorj20i60hsann.jpg",
                                 @"http://wx3.sinaimg.cn/large/bfc243a3gy1febm7nzbz7j20ib0iek5j.jpg",
                                 @"http://wx1.sinaimg.cn/large/bfc243a3gy1febm7orgqfj20i80ht15x.jpg",
                                 @"http://wx2.sinaimg.cn/large/bfc243a3gy1febm7pmnk7j20i70jidwo.jpg",
                                 @"http://wx3.sinaimg.cn/large/bfc243a3gy1febm7qjop4j20i00hw4c6.jpg",
                                 @"http://wx4.sinaimg.cn/large/bfc243a3gy1febm7rncxaj20ek0i74dv.jpg",
                                 @"http://wx2.sinaimg.cn/large/bfc243a3gy1febm7sdk4lj20ib0i714u.jpg",
                                 @"http://wx4.sinaimg.cn/large/bfc243a3gy1febm7tekewj20i20i4aoy.jpg",
                                 @"http://wx3.sinaimg.cn/large/bfc243a3gy1febm7usmc8j20i543zngx.jpg",nil];
}

- (void)setupSubviews
{
    NSInteger colCount = 3;
    NSInteger rowCount = 3;
    
    CGFloat xMargin = 60.0;
    CGFloat interitemSpacing = 10.0;
    CGFloat width = self.view.bounds.size.width - xMargin * 2;
    CGFloat itemSize = (width - 2 * interitemSpacing) / (CGFloat)colCount;
    
    CGFloat lineSpacing = 10.0;
    CGFloat height = itemSize * (CGFloat)rowCount + lineSpacing * 2  + 100;
    CGFloat y = 60.0;
    
    CGRect frame = CGRectMake(xMargin, y, width, height);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = lineSpacing;
    layout.minimumInteritemSpacing = interitemSpacing;
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [self.collectionView  registerClass:[PhotoEntryCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoEntryCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return  self.thumbnailImageUrls.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoEntryCollectionViewCell *collectionCell = (PhotoEntryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoEntryCollectionViewCell" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[self.thumbnailImageUrls objectAtIndex:indexPath.row]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            collectionCell.imageView.image = image;
        });
    });
    return collectionCell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
