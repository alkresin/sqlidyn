/*
 * SqliDyn - Harbour SQLite API
 * Test of Harbour bindings
 *
 * Copyright 2025 Alexander S.Kresin <alex@kresin.ru>
 * www - http://www.kresin.ru
 */

FUNCTION Main()

   LOCAL hConn, hDb, hStmt, cq, text_json

   IF sqlt_Init() != 0
      ? "Can't load sqlite shared library"
      FWait()
      RETURN Nil
   ENDIF

   FErase( "mytest.db" )

   IF Empty( hDb := sqlt_Create( "mytest_json.db" ) )
      ? "Can't create database"
      sqlt_Exit( )
      FWait()
      RETURN Nil
   ENDIF

   ? "Exec", sqlt_Exec( hDb, "CREATE TABLE data(id INTEGER, name TEXT NOT NULL, jst TEXT, jsb BLOB)" )

   text_json := '{ "title": "first line", "val": 10 }'
   cq := "INSERT INTO data ( id, name, jst, jsb ) VALUES ( 10, 'first', '" + text_json + ;
      "', jsonb('" + text_json + "') )"
   ? "Exec", sqlt_exec( hDb, cq )

   ? "Changes:", sqlt_Changes( hDb )

   sqlt_Exit( )

   FWait()

   RETURN Nil

STATIC FUNCTION FWait()

   ? "Press ant key"
   Inkey(0)
   RETURN Nil