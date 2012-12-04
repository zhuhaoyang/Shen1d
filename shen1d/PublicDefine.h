//
//  PublicDefine.h
//  excel
//
//  Created by zhuhaoyang on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// Log Print  on->1  off->0
#define LOG_STATE 1

#if LOG_STATE
#define LOGS(msg1, ...) NSLog(msg1, ##__VA_ARGS__)
#else
#define LOGS(msg1, ...)
#endif

// Safe Release
#define SAFE_RELEASE(object)\
{\
if (nil != object)\
{\
[object release];\
object = nil;\
}\
}


// Time out setting for Http engine
#define kTimeOutDuration 20


#define TableNamePersonalInfo @"PersonalInfo_Table"
#define TableNameMyShops @"MyShops_Table"
#define TableNameShopDetails @"ShopDetails_Table"

#define kTableFormatPersonalInfo @"userId text, email text, password text, uname text, phone text, created text, qrcode blob"
#define kTableFormatMyShops @"shopId text, cardType text, shopName text, images blob"
#define kTableFormatShopDetails @"shopId text, province text, city text, latitude text, longitude text, shopName text, format_addr text, area text, level text, created text, cId text, uname text, address text, contact_name text, password text, contact_phone text, images blob"


#define SQL_CREATE_TABLE @"CREATE TABLE %@ (%@)"// Table Name, Table Format
#define SQL_DELETE_ALL_FROM_TABLE @"DELETE FROM %@"// Table Name
#define SQL_QUERY_DATA_IF_EXIST @"SELECT * FROM %@ WHERE %@ = ?"// Table Name, attribute name

#define SQL_INSERT_PERSONAL_INFO_TABLE @"INSERT INTO %@ (%@) VALUES (?,?,?,?,?,?,?)"// Table Name, attribute name
#define SQL_QUERY_DATA_IF_EXIST @"SELECT * FROM %@ WHERE %@ = ?"// Table Name, attribute name
#define SQL_QUERY_PERSONAL_INFO_FROM_TABLE @"SELECT * FROM %@"// Table Name

#define SQL_INSERT_MYSHOPS_INFO_TABLE @"INSERT INTO %@ (%@) VALUES (?,?,?,?)"// Table Name, attribute name
#define SQL_QUERY_MYSHOPS_INFO_FROM_TABLE @"SELECT * FROM %@"// Table Name

#define SQL_INSERT_ShopDetails_INFO_TABLE @"INSERT INTO %@ (%@) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"// Table Name, attribute name
#define SQL_QUERY_ShopDetails_INFO_FROM_TABLE @"SELECT * FROM %@ WHERE %@ = ?"// Table Name, attribute name


#define SQL_DELETE_BOOKSHELF @"DELETE FROM BookShelf_Table WHERE bookShelf = ?"
#define SQL_DELETE_BOOK @"DELETE FROM AllBookData_Table WHERE %@ = ?"
#define SQL_DELETE_BOOKMARK @"DELETE FROM AllBookMark_Table WHERE id = ?"

#define SQL_QUERY_ALL_FROM_TABLE @"SELECT * FROM %@"// Table Name
#define SQL_QUERY_BOOKDATA_FROM_TABLE @"SELECT * FROM %@ WHERE %@ = ?"// Table Name, attribute name
#define SQL_QUERY_APPSET_FROM_TABLE @"SELECT * FROM APPSet_Table WHERE APPName = ?"
#define SQL_QUERY_BOOKSHELF_FROM_TABLE @"SELECT * FROM BookShelf_Table"


#define SQL_INSERT_BOOKDATA_INTO_TABLE @"INSERT INTO %@ (%@) VALUES (?,?,?,?,?)"// Table Name, attribute name
#define SQL_INSERT_BOOKMARK_INTO_TABLE @"INSERT INTO %@ (%@) VALUES (?,?,?,?)"// Table Name, attribute name
#define SQL_INSERT_APPSET_INTO_TABLE @"INSERT INTO %@ (%@) VALUES (?,?,?,?,?,?,?,?,?)"// Table Name, attribute name
#define SQL_INSERT_BOOKSHELF_INTO_TABLE @"INSERT INTO %@ (%@) VALUES (?)"// Table Name, attribute name

#define SQL_UPDATA_LASTREAD_INTO_TABLE @"UPDATE AllBookData_Table SET %@ = ? WHERE name = ?"
#define SQL_UPDATA_BOOKSHELF_INTO_TABLE @"UPDATE AllBookData_Table SET bookShelf = ? WHERE name = ?"
#define SQL_UPDATA_APPSET_INTO_TABLE @"UPDATE APPSet_Table SET %@ = ? WHERE APPName = ?"
