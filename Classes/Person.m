// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-

// person.m

#import "Person.h"
#import "EventManager.h"
#import "Database.h"

@implementation Person
@synthesize pkey, name;

- (id)init
{
    self = [super init];
    return self;
}

- (void)dealloc
{
    [name release];
    for (int i = 0; i < 3; i++) {
        [dates[i] release];
    }
    [super dealloc];
}

- (void)setDate:(SimpleDate *)date type:(int)type
{
    if (dates[type] == date) return;

    [dates[type] release];
    dates[type] = [date retain];
}

- (void)matchEvent:(int)year array:(NSMutableArray *)ary
{
    int yy;
    Event *e;
    EventManager *em = [EventManager sharedInstance];
    NSString *desc;
    int i;

    for (i = 0; i < 3; i++) {
        if (dates[i] == nil) continue;
        
        if (i != EV_DEATH && dates[EV_DEATH] != nil) {
            if (year >= dates[EV_DEATH].year) {
                // すでに死亡している場合は年齢・結婚イベントを出さない
                continue;
            }
        }

        yy = year - dates[i].year;

        e = [em matchEvent:i years:yy];
        if (e) {
            desc = [NSString stringWithFormat:@"%@ : %@", self.name, e.name];
            [ary addObject:desc];
        }
    }
}

#pragma mark Database handling

+ (void)checkTable
{
    Database *db = [Database instance];
    dbstmt *stmt;
    
    stmt = [db prepare:"SELECT sql FROM sqlite_master WHERE type='table' AND name='Persons';"];
    if ([stmt step] != SQLITE_ROW) {
        // テーブル新規作成
        [db exec:"CREATE TABLE Persons ("
            "pkey INTEGER PRIMARY KEY,"
            "name TEXT,"
            "birth_date TEXT,"
            "bridal_date TEXT,"
            "death_date TEXT"
            ");"
         ];
    }
}

+ (dbstmt *)selectAll
{
    Database *db = [Database instance];
    dbstmt *stmt;
    
    stmt = [db prepare:"SELECT * FROM Persons;"];
    return stmt;
}

- (void)loadRow:(dbstmt *)stmt
{
    self.pkey = [stmt colInt:0];
    self.name = [stmt colString:1];
    dates[0] = [[SimpleDate alloc] initWithString:[stmt colString:2]];
    dates[1] = [[SimpleDate alloc] initWithString:[stmt colString:3]];
    dates[2] = [[SimpleDate alloc] initWithString:[stmt colString:4]];
}

- (void)insert
{
    // TBD
}

- (void)update
{
    // TBD
}

- (void)delete
{
    Database *db = [Database instance];
    dbstmt *stmt = [db prepare:"DELETE FROM Persons WHERE pkey = ?;"];
    [stmt bindInt:0 val:pkey];
    [stmt step];
}

@end
