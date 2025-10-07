/*
 * SqliDyn - Harbour SQLite API
 * Test of C bindings
 *
 * Copyright 2025 Alexander S.Kresin <alex@kresin.ru>
 * www - http://www.kresin.ru
 */

#include <stdio.h>
#include "sqlit3.h"

int main( void ) {

   SQLTConn *db;
   SQLTstmt *stmt;

   if( sqlt_Init( NULL ) ) {
      printf( "Can't load sqlite shared library" );
      return -1;
   }

   printf( "Library version: %d\n", sqlt_libVersion() );
   db = sqlt_Create( "my.db" );
   if( db ) {
     printf( "Ok\n" );

     printf( "Exec: %d\n", sqlt_Exec( db, "CREATE TABLE data(id INTEGER, name TEXT NOT NULL, note TEXT NOT NULL, dcreate INTEGER)" ) );
     printf( "Exec: %d\n", sqlt_Exec( db, "CREATE INDEX data_i ON data (id)" ) );
     printf( "Exec: %d\n", sqlt_Exec( db, "INSERT INTO data ( id, name, note, dcreate ) VALUES ( 10, 'sectid', 'Section id', unixepoch() )" ) );
     printf( "Exec: %d\n", sqlt_Exec( db, "INSERT INTO data ( id, name, note, dcreate ) VALUES ( 11, 'newid', 'New identifier', unixepoch('2004-01-01 02:34:56') )" ) );
     printf( "Changes: %d\n", sqlt_Changes( db ) );

     stmt = sqlt_Prepare( db, "SELECT SQLITE_VERSION()" );
     if( stmt ) {
         printf( "Step: %d: ", sqlt_Step( stmt ) );
         printf( "Version: %s\n", sqlt_Column_text( stmt, 1 ) );
         sqlt_Finalize( stmt );
      }

     stmt = sqlt_Prepare( db, "SELECT max(dcreate) FROM data" );
     if( stmt ) {
         printf( "Step: %d: ", sqlt_Step( stmt ) );
         printf( "Max: %d\n", sqlt_Column_int(stmt,1) );
         sqlt_Finalize( stmt );
      }

      stmt = sqlt_Prepare( db, "SELECT id,name,note,dcreate FROM data" );
      if( stmt ) {
         printf( "Step: %d: ", sqlt_Step( stmt ) );
         printf( "%d %s %s %d\n", sqlt_Column_int(stmt,1), sqlt_Column_text(stmt,2),
            sqlt_Column_text(stmt,3), sqlt_Column_int(stmt,4) );
         printf( "Step: %d: ", sqlt_Step( stmt ) );
         printf( "%d %s %s %d\n", sqlt_Column_int(stmt,1), sqlt_Column_text(stmt,2),
            sqlt_Column_text(stmt,3), sqlt_Column_int(stmt,4) );
         sqlt_Finalize( stmt );
      }

     sqlt_Close( db );
   } else
     printf( "Failed\n" );

   sqlt_Exit();

   return 0;
}