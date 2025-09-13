#include <stdio.h>
#include "sqlit3.h"

int main( void ) {

   SQLTConn *db;

   if( sqlt_Init( NULL ) ) {
      printf( "Can't load libsqlite3" );
      return -1;
   }

   printf( "Library version: %d\n", sqlt_libVersion() );
   db = sqlt_Create( "my.db" );
   if( db ) {
     printf( "Ok\n" );
     sqlt_Close( db );
   } else
     printf( "Failed\n" );

   sqlt_Exit();

   return 0;
}