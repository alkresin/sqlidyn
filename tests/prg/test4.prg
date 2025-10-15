/*
 * SqliDyn - Harbour SQLite API
 * Test of Harbour bindings - jsonb functions
 *
 * Copyright 2025 Alexander S.Kresin <alex@kresin.ru>
 * www - http://www.kresin.ru
 */

FUNCTION Main()

   LOCAL hConn, hDb, hStmt, nVer, cq, text_json

   IF sqlt_Init() != 0
      ? "Can't load sqlite shared library"
      FWait()
      RETURN Nil
   ENDIF

   nVer := sqlt_LibVersion()
   ? "Current version is " + ver2str( nVer )
   IF nVer < 3045000
      ? "You need, at least, 3.45.0 version of sqlite to use jsonb"
      sqlt_Exit( )
      FWait()
      RETURN Nil
   ENDIF

   FErase( "mytest_jsonb.db" )

   IF Empty( hDb := sqlt_Create( "mytest_jsonb.db" ) )
      ? "Can't create database"
      sqlt_Exit( )
      FWait()
      RETURN Nil
   ENDIF

   ? "Exec", sqlt_Exec( hDb, "CREATE TABLE data(id INTEGER, name TEXT NOT NULL, jsb BLOB)" )
   ? "Exec", sqlt_Exec( hDb, "CREATE INDEX idx_val ON data((jsb->>'$.val'))" )

   text_json := '{ "title": "first line", "val": 10 }'
   cq := "INSERT INTO data ( id, name, jsb ) VALUES ( 10, 'first', jsonb('" + text_json + "') )"
   ? "Exec", sqlt_exec( hDb, cq )

   text_json := '{ "title": "second line", "val": 12 }'
   cq := "INSERT INTO data ( id, name, jsb ) VALUES ( 10, 'first', jsonb('" + text_json + "') )"
   ? "Exec", sqlt_exec( hDb, cq )

   ? "Changes:", sqlt_Changes( hDb )

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT id, jsb, json(jsb) FROM data" ) )
      ? "1 Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      hb_Memowrit( "data.jsonb", sqlt_ColumnBlob( hStmt, 2 ) )
      ?? sqlt_ColumnInt( hStmt, 1 ), sqlt_ColumnText( hStmt, 3 )
      ? "1 Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? sqlt_ColumnInt( hStmt, 1 ), sqlt_ColumnText( hStmt, 3 )
      sqlt_Finalize( hStmt )
   ENDIF

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT  json_valid(jsb) FROM data WHERE id = 10" ) )
      ? "2 Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? "Valid:", sqlt_ColumnInt( hStmt, 1 )
      sqlt_Finalize( hStmt )
   ENDIF

   IF !Empty( hStmt := sqlt_Prepare( hDb, ;
      "SELECT jsb->>'$.title', json_extract(jsb,'$.val') FROM data WHERE id = 10" ) )
      ? "3 Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? sqlt_ColumnText( hStmt, 1 ), sqlt_ColumnInt( hStmt, 2 )
      sqlt_Finalize( hStmt )
   ENDIF

   IF !Empty( hStmt := sqlt_Prepare( hDb, ;
      "SELECT jsb->>'$.title', json_extract(jsb,'$.val') FROM data WHERE jsb->>'$.val'>11" ) )
      ? "4 Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? sqlt_ColumnText( hStmt, 1 ), sqlt_ColumnInt( hStmt, 2 )
      sqlt_Finalize( hStmt )
   ENDIF

   IF !Empty( hStmt := sqlt_Prepare( hDb, ;
      "SELECT json_type(jsb,'$.title'), json_type(jsb,'$.val') FROM data WHERE id = 10" ) )
      ? "5 Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? sqlt_ColumnText( hStmt, 1 ), sqlt_ColumnText( hStmt, 2 )
      sqlt_Finalize( hStmt )
   ENDIF

   sqlt_Exit( )

   FWait()

   RETURN Nil

STATIC FUNCTION FWait()

   ? "Press ant key"
   Inkey(0)
   RETURN Nil

STATIC FUNCTION ver2str( nVer )
   RETURN Ltrim(Str(Int(nVer/1000000))) + "." + Ltrim(Str(Int((nVer/1000)%1000))) + ;
      "." + Ltrim(Str(Int(nVer%1000)))