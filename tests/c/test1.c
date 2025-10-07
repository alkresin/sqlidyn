/*
 * SqliDyn - Harbour SQLite API
 * Test of C Bindings
 *
 * Copyright 2025 Alexander S.Kresin <alex@kresin.ru>
 * www - http://www.kresin.ru
 */

#include <stdio.h>
#include "sqlit3.h"

int main( void ) {

   if( sqlt_Init( NULL ) ) {
      printf( "Can't load sqlite shared library" );
      return -1;
   }

   printf( "Library version: %d\n", sqlt_libVersion() );

   sqlt_Exit();

   return 0;
}