/*
 * SqliDyn - Harbour SQLite API
 * Test of Harbour bindings - just loads the shared library and prints it's version
 *
 * Copyright 2025 Alexander S.Kresin <alex@kresin.ru>
 * www - http://www.kresin.ru
 */

FUNCTION Main( cHost )

   LOCAL nVer

   IF sqlt_Init() != 0
      ? "Can't load libsqlite"
      RETURN Nil
   ENDIF

   ? "Library version:", nVer := sqlt_LibVersion()
   ?? " (" + ver2str(nVer) + ")"

   sqlt_Exit( )

   ? "Press ant key"
   Inkey(0)

   RETURN Nil

STATIC FUNCTION ver2str( nVer )
   RETURN Ltrim(Str(Int(nVer/1000000))) + "." + Ltrim(Str(Int((nVer/1000)%1000))) + ;
      "." + Ltrim(Str(Int(nVer%1000)))