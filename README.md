# SqliDyn
A small library - bindings to the Sqlite C API for C and Harbour.

## Short introduction

Why was it needed to write this library? C API exists already, Harbour bindings - too, why write
another one?.

The main goal is to simplify as much as possible compiling, linking and using applications,
which uses Sqlite.

Building the app doesn't require Sqlite headers and binaries. Sqlite shared library will be called
dynamically when the ready application needs them, no need for Sqlite files before.

SqliDyn provides a minimum set of functions, those only, which are really necessary, IMO, to use Sqlite.
This approach makes life easier for the developer.

## Functions list

#### sqlt_Init( [ cDllName ] )
This functions loads the sqlite shared library (dll or so), it must be called before any other SqliDyn function.

#### sqlt_Exit()
Unloads the sqlite shared library.

#### sqlt_LibVersion() -> nVersion

#### sqlt_Create( cDbName ) -> pDb
Creates a new database *cDbName* and returns the handler.

#### sqlt_Open( cDbName, iOpt ) -> pDb
Opens a new database *cDbName* and returns the handler.

#### sqlt_Close( pDb )
Closes the connection to a database

#### sqlt_Exec( pDb, cQuery ) -> iRes

#### sqlt_Prepare( pDb, cQuery ) -> pStmt

#### sqlt_Step( pStmt ) -> iRes

#### sqlt_Finalize( pStmt ) -> iRes

#### sqlt_ColumnBlob( pStmt, iCol ) -> cValue

#### sqlt_ColumnDouble( pStmt, iCol ) -> iValue

#### sqlt_ColumnInt( pStmt, iCol ) -> iValue

#### sqlt_ColumnInt64( pStmt, iCol ) -> lValue

#### sqlt_ColumnText( pStmt, iCol ) -> cValue

#### sqlt_ColumnType( pStmt ) -> iType

#### sqlt_ColumnBytes( pStmt ) -> iType

#### sqlt_BindBlob( pStmt, iPos, szValue ) -> iRes

#### sqlt_BindDouble( pStmt, iPos, dValue ) -> iRes

#### sqlt_BindInt( pStmt, iPos, iValue ) -> iRes

#### sqlt_BindInt64( pStmt, iPos, lValue ) -> iRes

#### sqlt_BindText( pStmt, iPos, szValue ) -> iRes

#### sqlt_ClearBindings( pStmt ) -> iRes

#### sqlt_LastInsertRowid( pDb )

#### sqlt_Errcode( pDb ) -> iRes

#### sqlt_Changes( pDb ) -> iRows