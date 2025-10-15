/*
 * SqliDyn - Harbour SQLite API
 * Test of Harbour bindings - creates a database, writes and reads data
 *
 * Copyright 2025 Alexander S.Kresin <alex@kresin.ru>
 * www - http://www.kresin.ru
 */

FUNCTION Main()

   LOCAL hDb, hStmt

   IF sqlt_Init() != 0
      ? "Can't load sqlite shared library"
      FWait()
      RETURN Nil
   ENDIF

   FErase( "mytest.db" )

   IF Empty( hDb := sqlt_Create( "mytest.db" ) )
      ? "Can't create database"
      sqlt_Exit( )
      FWait()
      RETURN Nil
   ENDIF

   ? "Exec", sqlt_Exec( hDb, "CREATE TABLE data(id INTEGER, name TEXT NOT NULL, note TEXT NOT NULL, dcreate INTEGER)" )
   ? "Exec", sqlt_Exec( hDb, "CREATE INDEX data_i ON data (id)" )
   ? "Exec", sqlt_exec( hDb, "INSERT INTO data ( id, name, note, dcreate ) VALUES ( 10, 'sectid', 'Section id', unixepoch() )" )
   ? "Exec", sqlt_exec( hDb, "INSERT INTO data ( id, name, note, dcreate ) VALUES ( 11, 'newid', 'New identifier', unixepoch('2004-01-01 02:34:56') )" )
   ? "Changes:", sqlt_Changes( hDb )

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT SQLITE_VERSION()" ) )
      ? "Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? sqlt_ColumnText( hStmt, 1 )
      sqlt_Finalize( hStmt )
   ENDIF

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT max(dcreate) FROM data" ) )
      ? "Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? "max()", sqlt_ColumnText( hStmt, 1 )
      sqlt_Finalize( hStmt )
   ENDIF

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT id,name,note,dcreate FROM data" ) )
      ? "Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? sqlt_ColumnInt( hStmt, 1 ), sqlt_ColumnText( hStmt, 2 ), ;
         sqlt_ColumnText( hStmt, 3 ), sqlt_ColumnInt( hStmt, 4 )
      ? "Step " + Str( sqlt_Step(hStmt),3 ) + ": "
      ?? sqlt_ColumnInt( hStmt, 1 ), sqlt_ColumnText( hStmt, 2 ), ;
         sqlt_ColumnText( hStmt, 3 ), sqlt_ColumnInt( hStmt, 4 )
      sqlt_Finalize( hStmt )
   ENDIF

   sqlt_Exit( )

   FWait()

   RETURN Nil

STATIC FUNCTION FWait()

   ? "Press ant key"
   Inkey(0)
   RETURN Nil