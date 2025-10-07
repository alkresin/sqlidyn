/*
 * SqliDyn - Harbour SQLite API
 * Test of Harbour bindings
 *
 * Copyright 2025 Alexander S.Kresin <alex@kresin.ru>
 * www - http://www.kresin.ru
 */

FUNCTION Main( cHost )

   IF sqlt_Init() != 0
      ? "Can't load libsqlite"
      RETURN Nil
   ENDIF

   ? "Library version:", sqlt_LibVersion()

   sqlt_Exit( )

   ? "Press ant key"
   Inkey(0)

   RETURN Nil