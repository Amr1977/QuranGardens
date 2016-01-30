//
//  PeriodicTask.m
//  QuranGardens
//
//  Created by Amr Lotfy on 1/30/16.
//  Copyright © 2016 Amr Lotfy. All rights reserved.
//

#import "PeriodicTask.h"

@implementation PeriodicTask

- (instancetype)initWithName:(NSString *)name description:(NSString *)description interval:(NSTimeInterval)interval lastOccurrence:(NSDate *)lastOccurrence{
    self = [super init];
    if (self) {
        _name = name;
        _taskDescription = description;
        _cycleInterval = interval;
        _lastOccurrence = lastOccurrence;
    }
    return self;
}

- (NSTimeInterval)remainingTimeInterval{
    NSTimeInterval result = 0;
    NSTimeInterval timeFromLastOccurrenceToNow = [self.lastOccurrence timeIntervalSinceNow];
    result = self.cycleInterval - timeFromLastOccurrenceToNow;
    
    return result;
}

@end
