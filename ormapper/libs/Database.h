// -*-  Mode:ObjC; c-basic-offset:4; tab-width:8; indent-tabs-mode:nil -*-
/*
  O/R Mapper library for iPhone

  Copyright (c) 2010, Takuya Murakami. All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

  1. Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer. 

  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution. 

  3. Neither the name of the project nor the names of its contributors
  may be used to endorse or promote products derived from this software
  without specific prior written permission. 

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// sqlite3 wrapper

#import <UIKit/UIKit.h>
#import <sqlite3.h>

/**
   Wrapper class of sqlite3_stmt
*/
@interface dbstmt : NSObject {
    sqlite3_stmt *stmt;	///< sqlite3_stmt handle.
    sqlite3 *handle;    ///< database handle.
}

@property(nonatomic,assign) sqlite3 *handle;

- (id)initWithStmt:(sqlite3_stmt *)st;
- (int)step;
- (void)reset;

- (void)bindInt:(int)idx val:(int)val;
- (void)bindDouble:(int)idx val:(double)val;
- (void)bindCString:(int)idx val:(const char *)val;
- (void)bindString:(int)idx val:(NSString*)val;
- (void)bindDate:(int)idx val:(NSDate*)date;

- (int)colInt:(int)idx;
- (double)colDouble:(int)idx;
- (const char*)colCString:(int)idx;
- (NSString*)colString:(int)idx;
- (NSDate*)colDate:(int)idx;
@end

/**
   Wrapper class of sqlite3 database
*/
@interface Database : NSObject {
    sqlite3 *handle; ///< Database handle

    NSDateFormatter *dateFormatter;
}

@property(nonatomic,readonly) sqlite3 *handle;

+ (Database*)instance;
+ (void)shutdown;

- (id)init;
- (void)dealloc;

- (void)exec:(NSString *)sql;
- (dbstmt*)prepare:(NSString *)sql;
- (int)lastInsertRowId;

- (void)beginTransaction;
- (void)commitTransaction;
- (void)rollbackTransaction;

- (NSString *)dbPath:(NSString *)dbname;
- (BOOL)open:(NSString *)dbname;

// utilities
- (NSDate*)dateFromString:(NSString *)str;
- (NSString *)stringFromDate:(NSDate*)date;

@end
