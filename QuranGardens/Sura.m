//
//  Sura.m
//  QuranGardens
//
//  Created by Amr Lotfy on 1/29/16.
//  Copyright © 2016 Amr Lotfy. All rights reserved.
//

#import "Sura.h"

@implementation Sura

- (NSInteger)remainingTimeForNextReview{
    //TODO: Do it !
    return arc4random_uniform(ReviewCyclePeriodInHours);
}


@end
