//
//  YTSeatCollectionVIew.m
//  FanweApp
//
//  Created by hzc on 2019/2/19.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTSeatCollectionVIew.h"
#import "YTSeatCell.h"
#import "YTSeatHeader.h"
#import "JYEqualCellSpaceFlowLayout.h"
@interface YTSeatCollectionVIew()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray<YTAllSeatModel*>* arr;
@end
@implementation YTSeatCollectionVIew

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    JYEqualCellSpaceFlowLayout *cvlayout = [[JYEqualCellSpaceFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5.0];
    cvlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    cvlayout.minimumLineSpacing = collectionViewSpace;
    //    cvlayout.minimumInteritemSpacing = collectionViewSpace;
//        cvlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    cvlayout.estimatedItemSize = CGSizeMake(80, 80);

    
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[YTSeatCell class] forCellWithReuseIdentifier:@"YTSeatCell"];
    [self registerClass:[YTSeatHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.delegate=self;
    self.dataSource=self;
    
    
    
    
    
    return [super initWithFrame:frame collectionViewLayout:cvlayout];
//    self.tableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        [weakSelf getMore];
//    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.arr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr[section].arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellOfSeat:indexPath];
}

-(UICollectionViewCell*)cellOfSeat:(NSIndexPath*)indexPath{
    YTSeatCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"YTSeatCell" forIndexPath:indexPath];
    YTSeatModel* smodel = self.arr[indexPath.section].arr[indexPath.row];
    [cell updateCell:smodel buyBlock:^{
        self.buyBlock(smodel);
    } seeAnimationBlock:^{
        self.seeAnimationBlock(smodel);
    }];
    return cell;
}
//定义每个UICollectionViewCell 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((SCREEN_WIDTH-15)/2, 190);
//}

#pragma mark <UICollectionViewDelegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind==UICollectionElementKindSectionHeader) {
        YTSeatHeader* view=[self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [view updateCell:[self getTypeName:self.arr[indexPath.section].driver_type]];
        return view;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 45);
}

-(NSString*)getTypeName:(int)type{
    NSString* str;
    switch (type) {
        case 1:
            str= @"帝王座驾";
            break;
        case 2:
            str= @"豪华座驾";
            break;
        default:
            str= @"普通座驾";
            break;
    }
    return str;
}
-(void)updateView:(NSMutableArray<YTAllSeatModel *>*)arr{
    self.arr=arr;
    [self reloadData];
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];//因为header位置错乱 伪延迟执行reloadData
}

@end
