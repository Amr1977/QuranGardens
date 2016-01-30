//
//  QuranGardensViewController.m
//  QuranGardens
//
//  Created by Amr Lotfy on 1/29/16.
//  Copyright © 2016 Amr Lotfy. All rights reserved.
//

#import "QuranGardensViewController.h"
#import "SuraViewCell.h"
#import "Sura.h"

@interface QuranGardensViewController ()

@property (strong, nonatomic) NSArray <Sura *> *suras;

@end

@implementation QuranGardensViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
}

- (void)setupSuras{
    if (!_suras) {
        NSMutableArray <Sura *>* mutableSuras = @[].mutableCopy;
        for (NSInteger i = 1; i<=114; i++) {
            Sura *sura = [[Sura alloc] init];
            mutableSuras addObject:<#(nonnull Sura *)#>
        }
        self.suras =
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.suras.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor colorWithWhite:255/255 alpha:0.5];
    
    //TODO: fix later
    cell.alpha = [self.suras[indexPath.row] remainingTimeForNextReview] / ReviewCyclePeriodInHours;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

@end
