#import "Database.h"
#import "ORRecord.h"

@implementation ORRecord

@synthesize pid;

- (id)init
{
    self = [super init];
    if (self) {
        isInserted = NO;
    }
        
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}

/**
  @brief Migrate database table
*/

+ (BOOL)migrate:(NSArray *)array
{
    Database *db = [Database instance];
    dbstmt *stmt;
    
    // check if table exists.
    NSString *sql, *tablesql;
    sql = [NSString stringWithFormat:@"SELECT sql FROM sqlite_master WHERE type='table' AND name='%@';", [self tableName]];
    stmt = [db prepare:sql];

    // create table
    if ([stmt step] != SQLITE_ROW) {
        sql = [NSString stringWithFormat:@"CREATE TABLE %@ (id INTEGER PRIMARY KEY);", [self tableName]];
        [db exec:sql];
        tablesql = sql;
    } else {
        tablesql = [stmt colString:0];
    }

    // add columns
    int count = [array count] / 2;

    for (int i = 0; i < count; i++) {
        NSString *column = [array objectAtIndex:i * 2];
        NSString *type = [array objectAtIndex:i * 2 + 1];

        NSRange range = [tablesql rangeOfString:[NSString stringWithFormat:@" %@ ", column]];
        if (range.location == NSNotFound) {
            sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@;",
                            [self tableName], column, type];
            [db exec:sql];
        }
    }
    return YES;
}

/**
  @brief get all records
  @return array of all record
*/
+ (NSMutableArray *)find_all
{
    return [self find_cond:nil];
}

/**
  @brief get all records matche the conditions

  @param cond Conditions (WHERE phrase and so on)
  @return array of records

  You must override this.
*/
+ (NSMutableArray *)find_cond:(NSString *)cond
{
    return nil;
}

/**
  @brief get the record matchs the id

  @param id Primary key of the record
  @return record
*/
+ (id)find:(int)pid
{
    return nil;
}

/**
  @brief Save record
*/
- (void)save
{
    if (isInserted) {
        [self update];
    } else {
        [self insert];
    }
}

+ (NSString *)tableName
{
    return nil; // must be override
}

- (void)insert
{
    isInserted = YES;
    return;
}

- (void)update
{
    return;
}

/**
  @brief Delete record
*/
- (void)delete
{
    return;
}

+ (void)delete_all
{
    // must be override
}

@end
