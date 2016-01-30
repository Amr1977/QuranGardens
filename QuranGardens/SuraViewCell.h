//
//  SuraView.h
//  QuranGardens
//
//  Created by Amr Lotfy on 1/29/16.
//  Copyright © 2016 Amr Lotfy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuraViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *suraName;

//amount of time left for next due review time
@property (strong, nonatomic) UIProgressView *timeProgressView;


@end
