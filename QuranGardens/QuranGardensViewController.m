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
#import "PeriodicTaskManager.h"

@interface QuranGardensViewController ()

@property (strong, nonatomic) PeriodicTaskManager *periodicTaskManager;

@end

@implementation QuranGardensViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.periodicTaskManager = [PeriodicTaskManager new];
    [self.periodicTaskManager loadTasks];
    if (![self.periodicTaskManager taskCount]) {
        [self initSuras];
    }
    [self setupCollectionView];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(resetAllTasks)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)resetAllTasks{
    [self.periodicTaskManager resetTasks];
    [self.collectionView reloadData];
}

- (void)setupCollectionView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:@"SuraViewCell" bundle: nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
}

NSInteger const intervalInTenDays = 10*24*60*60;
//TODO: create suras in a method and randomize content in another method
- (void)initSuras{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    for (NSInteger i = 1; i <= 114; i++) {
        PeriodicTask *sura = [[PeriodicTask alloc] init];
        sura.name = [Sura suraNames][i-1];
        sura.cycleInterval = intervalInTenDays;
        sura.lastOccurrence = [NSDate dateWithTimeIntervalSince1970:0];
        [self.periodicTaskManager addPeriodicTask:sura];
    }
    [realm commitWriteTransaction];
    [self.periodicTaskManager saveTasks];
}

- (void)randomizeSuralastOccurrence{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    for (NSInteger i = 0; i <= 113; i++) {
        PeriodicTask *sura = [self.periodicTaskManager getTaskAtIndex:i];
        NSTimeInterval randomIntervalWithintenDays = arc4random_uniform(intervalInTenDays);
        sura.lastOccurrence = [NSDate dateWithTimeIntervalSinceNow:(-1 * randomIntervalWithintenDays)];
    }
    [realm commitWriteTransaction];
    [self.periodicTaskManager saveTasks];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.periodicTaskManager taskCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SuraViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    PeriodicTask *task = [self.periodicTaskManager getTaskAtIndex:indexPath.row];
    cell.alpha = MAX([task remainingTimeInterval] / task.cycleInterval, 0.2);
    
    cell.timeProgressView.progress = cell.alpha;
    cell.suraName.text = [NSString stringWithFormat:@"%u %@", indexPath.row + 1, task.name];
    cell.suraName.adjustsFontSizeToFitWidth = YES;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(170, 100);
}

- (void)collectionView:(UICollectionView *)collectionView  didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    PeriodicTask *task = [self.periodicTaskManager getTaskAtIndex:indexPath.row];
   
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    task.lastOccurrence = [[NSDate alloc] init];
    [realm commitWriteTransaction];
    
    [self.collectionView reloadData];
}

- (void)dealloc{
    [self.periodicTaskManager saveTasks];
}

@end
