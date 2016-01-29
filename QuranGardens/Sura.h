//
//  Sura.h
//  QuranGardens
//
//  Created by Amr Lotfy on 1/29/16.
//  Copyright © 2016 Amr Lotfy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sura : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSDate *lastActionDate;
@property (nonatomic) NSInteger order;

@end
