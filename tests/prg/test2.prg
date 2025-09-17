/*
 */

FUNCTION Main()

   LOCAL hConn, hDb, hStmt

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
   ? "Exec", sqlt_exec( hDb, "INSERT INTO data ( id, name, note ) VALUES ( 10, 'sectid', 'Section id' )" )
   ? "Changes:", sqlt_Changes( hDb )

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT SQLITE_VERSION()" ) )
      ? "Step", sqlt_Step( hStmt )
      ? sqlt_ColumnText( hStmt, 1 )
      sqlt_Finalize( hStmt )
   ENDIF

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT id,name,note FROM data" ) )
      ? "Step", sqlt_Step( hStmt )
      ? sqlt_ColumnInt( hStmt, 1 ), sqlt_ColumnText( hStmt, 2 ), sqlt_ColumnText( hStmt, 3 )
      sqlt_Finalize( hStmt )
   ENDIF

   sqlt_Exit( )

   FWait()

   RETURN Nil

STATIC FUNCTION FWait()

   ? "Press ant key"
   Inkey(0)
   RETURN Nil