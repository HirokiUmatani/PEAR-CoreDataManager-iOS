//
//  CoreDataManager.h
//  LessonApp
//
//  Created by hirokiumatani on 2015/07/05.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//
#import <CoreData/CoreData.h>

//extern NSString * const CONST_CORE_DATA_ERROR;
//extern NSString * const CONST_CORE_DATA_FETCH_ERROR;
//extern NSString * const CONST_CORE_DATA_SAVE_ERROR;
//extern NSString * const CONST_CORE_DATA_FETCH_NO_DATA;
//extern NSString * const CONST_CORE_DATA_SEARCH;

@interface CoreDataManager : NSObject

@property (nonatomic,strong)NSManagedObjectModel         *managedObjectModel;
@property (nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong)NSManagedObjectContext       *managedObjectContext;

@property (nonatomic,strong)NSString * coreDataName;
@property (nonatomic,strong)NSString * sqliteName;
+ (CoreDataManager *)sharedInstance;
+ (CoreDataManager *)createSharedInstanceWithCoreDataName:(NSString *)coreDataName
                                               sqliteName:(NSString *)sqliteName;

@end
