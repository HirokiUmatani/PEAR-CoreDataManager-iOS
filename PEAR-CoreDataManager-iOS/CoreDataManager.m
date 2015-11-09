//
//  CoreDataManager.m
//  LessonApp
//
//  Created by hirokiumatani on 2015/07/05.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "CoreDataManager.h"

//NSString * const CONST_CORE_DATA_ERROR          = @"CoreData error";
//NSString * const CONST_CORE_DATA_FETCH_ERROR    = @"CoreData fetch failed";
//NSString * const CONST_CORE_DATA_SAVE_ERROR     = @"CoreData save failed";
//NSString * const CONST_CORE_DATA_FETCH_NO_DATA  = @"CoreData fetch No data";
//NSString * const CONST_CORE_DATA_SEARCH         = @"%K=%@";

@implementation CoreDataManager

static CoreDataManager  *_sharedInstance = nil;

#pragma mark - Initial
+ (void)initSettingWithCoreDataName:(NSString *)coreDataName
                         sqliteName:(NSString *)sqliteName
{
    static dispatch_once_t oneTime;
    dispatch_once(&oneTime, ^
    {
        _sharedInstance = [self new];
        [_sharedInstance managedObjectContextWithCoreDataName:coreDataName sqliteName:sqliteName];
    });
}

+ (CoreDataManager *)sharedInstance
{
    if (!_sharedInstance)
    {
        NSLog(@"Have not finish the first call the initSettingWithCoreDataName:sqliteName");
    }
    return _sharedInstance;
}


+ (id)createInsertEntityWithClassName:(NSString *)className
{
    return [NSEntityDescription insertNewObjectForEntityForName:className
                                              inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
}

+ (void)saveWithSuccess:(CoreDataSaveSuccess)success
                 failed:(CoreDataSaveFailed)failed
{
    NSError *error = nil;
    BOOL ret = [[CoreDataManager sharedInstance].managedObjectContext save:&error];
    if (ret)
    {
        success();
    }
    else
    {
        failed(error);
    }
}


#pragma mark -  private

- (NSManagedObjectContext *)managedObjectContextWithCoreDataName:(NSString *)coreDataName
                                                      sqliteName:(NSString *)sqliteName
{
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinatorWithCoreDataName:coreDataName sqliteName:sqliteName];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithCoreDataName:(NSString *)coreDataName
                                                                  sqliteName:(NSString *)sqliteName
{
    NSURL *storeURL = [[self applicationLibraryDirectory] URLByAppendingPathComponent:sqliteName];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModelWithCoreDataName:coreDataName]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error])
    {
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModelWithCoreDataName:(NSString *)coreDataName
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:coreDataName
                                              withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSURL *)applicationLibraryDirectory
{
    NSString *coreDataDirPath = [NSString stringWithFormat:
                                 @"%@/%@",
                                 NSHomeDirectory(),
                                 @"Library"];
    return [NSURL fileURLWithPath:coreDataDirPath];
}
@end
