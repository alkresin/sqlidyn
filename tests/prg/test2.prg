/*
 */

FUNCTION Main()

   LOCAL hConn, hDb, hStmt

   IF sqlt_Init() != 0
      ? "Can't load libdqlite"
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

   IF !Empty( hStmt := sqlt_Prepare( hDb, "SELECT SQLITE_VERSION()" ) )
      ? "Step", sqlt_Step( hStmt )
      ? sqlt_ColumnText( hStmt, 0 )
      sqlt_Finalize( hStmt )
   ENDIF

   sqlt_Exit( )

   FWait()

   RETURN Nil

STATIC FUNCTION FWait()

   ? "Press ant key"
   Inkey(0)
   RETURN Nil