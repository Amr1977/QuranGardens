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
        [self setupSuras];
    }
    [self setupCollectionView];
}

- (void)setupCollectionView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:@"SuraViewCell" bundle: nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cellIdentifier"];
    
    //[self.collectionView registerClass:[SuraViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
}

- (void)setupSuras{
    NSInteger intervalintenDays = 10*24*60*60;
    for (NSInteger i = 1; i <= 114; i++) {
        PeriodicTask *sura = [[PeriodicTask alloc] init];
        sura.name = [NSString stringWithFormat:@"%ld",(long)i];
        sura.cycleInterval = intervalintenDays;
        NSTimeInterval randomIntervalWithintenDays = arc4random_uniform(intervalintenDays);
        sura.lastOccurrence = [NSDate dateWithTimeIntervalSinceNow:(-1 * randomIntervalWithintenDays)];
        [self.periodicTaskManager addPeriodicTask:sura];
    }
    [self.periodicTaskManager saveTasks];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.periodicTaskManager taskCount];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SuraViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    //TODO: fix later
    PeriodicTask *task = [self.periodicTaskManager getTaskAtIndex:indexPath.row];
    cell.alpha = [task remainingTimeInterval] / task.cycleInterval;
    NSLog(@"last occurence Date: %@ alpha: %f",[task lastOccurrence],cell.alpha);
    
    cell.timeProgressView.progress = 0.5f;
    cell.suraName.text = [NSString stringWithFormat:@"Sura: %@", task.name];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView  didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    PeriodicTask *task = [self.periodicTaskManager getTaskAtIndex:indexPath.row];
    NSLog(@"Selected task: name: %@, remainingTimeinterval: %f, cycle: %f",task.name, [task remainingTimeInterval], task.cycleInterval);
    
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
