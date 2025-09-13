#include <stdio.h>
#include "sqlit3.h"

int main( void ) {

   if( sqlt_Init( NULL ) ) {
      printf( "Can't load libsqlite3" );
      return -1;
   }

   printf( "Library version: %d\n", sqlt_libVersion() );

   sqlt_Exit();

   return 0;
}