//
//  CoreDataManager.m
//  LessonApp
//
//  Created by hirokiumatani on 2015/07/05.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

static dispatch_semaphore_t _semaphore = nil;
static CoreDataManager  *_sharedInstance = nil;

#pragma mark - Initial
+ (void)initSettingWithCoreDataName:(NSString *)coreDataName
                         sqliteName:(NSString *)sqliteName
{
    static dispatch_once_t oneTime;
    dispatch_once(&oneTime, ^
    {
        _sharedInstance = [self new];
        _semaphore = dispatch_semaphore_create(0);
        [_sharedInstance managedObjectContextWithCoreDataName:coreDataName sqliteName:sqliteName];
    });
}

+ (CoreDataManager *)sharedInstance
{
    if (!_sharedInstance)
    {
        NSLog(@"must call 'initSettingWithCoreDataName:sqliteName' the first.");
    }
    return _sharedInstance;
}

#pragma mark - Insert
+ (id)createInsertEntityWithClassName:(NSString *)className
{
    return [NSEntityDescription insertNewObjectForEntityForName:className
                                         inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
}

#pragma mark - Save
+ (void)saveWithSuccess:(CoreDataSaveSuccess)success
                 failed:(CoreDataFailed)failed
{
    
    _THREAD_START
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
    _THREAD_END
}

#pragma mark - Fetch
+ (void)fetchWithEntity:(NSString *)entityClass
                   Predicate:(NSPredicate *)predicate
                     success:(CoreDataFetchSuccess)success
                      failed:(CoreDataFailed)failed
{
    _THREAD_START
    
    NSManagedObjectContext *managedObjectContext = [CoreDataManager sharedInstance].managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityClass
                                              inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    /*** Predicate ***/
    if (predicate)
    {
        [request setPredicate:predicate];
    }
    
    
    /*** Error ***/
    NSError *error;
    NSArray *fetchLists = [managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        failed(error);
    }
    else
    {
        success(fetchLists);
    }
    
    _THREAD_END
}

+ (void)autoIncrementIDWithEntityClass:(NSString *)entityClass
                               success:(CoreDataNewCreateIDSuccess)success
                                failed:(CoreDataFailed)failed;
{
    _THREAD_START
    
    NSManagedObjectContext *managedObjectContext = [CoreDataManager sharedInstance].managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityClass
                                              inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    
    NSError *error;
    NSArray *fetchLists = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (error)
    {
        failed(error);
    }
    else
    {
        success(fetchLists.count);
    }
    
    _THREAD_END
    
}
#pragma mark - Predicate
+ (NSPredicate *)setPredicateEqualWithSearchKey:(NSString *)searchkey
                                    searchValue:(id)searchValue
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=%@",searchkey,searchValue];
    return predicate;
}
+ (NSPredicate *)setPredicateOverWithSearchKey:(NSString *)searchkey
                                    searchValue:(id)searchValue
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=>%@",searchkey,searchValue];
    return predicate;
}
+ (NSPredicate *)setPredicateUnderWithSearchKey:(NSString *)searchkey
                                    searchValue:(id)searchValue
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K=<%@",searchkey,searchValue];
    return predicate;
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
