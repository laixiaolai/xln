//
//  YTMySeatCollectionView.m
//  FanweApp
//
//  Created by hzc on 2019/2/19.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTMySeatCollectionView.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "YTSeatHeader.h"
#import "YTMySeatCollectionViewCell.h"
@interface YTMySeatCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray<YTAllMySeatModel*>* arr;
@end
@implementation YTMySeatCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    JYEqualCellSpaceFlowLayout *cvlayout = [[JYEqualCellSpaceFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:5.0];
    cvlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    cvlayout.minimumLineSpacing = collectionViewSpace;
    //    cvlayout.minimumInteritemSpacing = collectionViewSpace;
    //        cvlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    cvlayout.estimatedItemSize = CGSizeMake(80, 80);
    
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[YTMySeatCollectionViewCell class] forCellWithReuseIdentifier:@"YTMySeatCollectionViewCell"];
    [self registerClass:[YTSeatHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.delegate=self;
    self.dataSource=self;
    return [super initWithFrame:frame collectionViewLayout:cvlayout];
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
    YTMySeatCollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"YTMySeatCollectionViewCell" forIndexPath:indexPath];
    cell.refreshBlock = ^{
        self.refreshBlock();
    };
    cell.buyBlock = ^(YTMySeatModel *model) {
        self.buyBlock(model);
    };
    [cell updateMySeat:self.arr[indexPath.section].arr[indexPath.row]];
    return cell;
}


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

-(void)updateView:(NSMutableArray<YTAllMySeatModel*>*)arr{
    self.arr=arr;
    [self reloadData];
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];//因为header位置错乱 伪延迟执行reloadData
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


@end
