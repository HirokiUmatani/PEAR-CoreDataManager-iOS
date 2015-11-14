//
//  CDTestEntity.h
//  CoreDataManager
//
//  Created by hirokiumatani on 2015/11/09.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CDTestEntity : NSManagedObject

@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *id;
@end


