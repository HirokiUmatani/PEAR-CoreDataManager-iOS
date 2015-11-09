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
/*** save success blocks */
typedef void (^CoreDataSaveSuccess)();

/*** save failed blocks */
typedef void (^CoreDataSaveFailed)(NSError *error);
@interface CoreDataManager : NSObject

@property (nonatomic,strong)NSManagedObjectModel         *managedObjectModel;
@property (nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong)NSManagedObjectContext       *managedObjectContext;
+ (CoreDataManager *)sharedInstance;
+ (void)initSettingWithCoreDataName:(NSString *)coreDataName
                         sqliteName:(NSString *)sqliteName;
+ (id)createInsertEntityWithClassName:(NSString *)className;
+ (void)saveWithSuccess:(CoreDataSaveSuccess)success
                 failed:(CoreDataSaveFailed)failed;
@end
