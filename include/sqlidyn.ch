/*
 */

#define SQLITE_OK           0

#define SQLITE_ERROR        1   /* Generic error */
#define SQLITE_INTERNAL     2   /* Internal logic error in SQLite */
#define SQLITE_PERM         3   /* Access permission denied */
#define SQLITE_ABORT        4   /* Callback routine requested an abort */
#define SQLITE_BUSY         5   /* The database file is locked */
#define SQLITE_LOCKED       6   /* A table in the database is locked */
#define SQLITE_NOMEM        7   /* A malloc() failed */
#define SQLITE_READONLY     8   /* Attempt to write a readonly database */
#define SQLITE_INTERRUPT    9   /* Operation terminated by sqlite3_interrupt()*/
#define SQLITE_IOERR       10   /* Some kind of disk I/O error occurred */
#define SQLITE_CORRUPT     11   /* The database disk image is malformed */
#define SQLITE_NOTFOUND    12   /* Unknown opcode in sqlite3_file_control() */
#define SQLITE_FULL        13   /* Insertion failed because database is full */
#define SQLITE_CANTOPEN    14   /* Unable to open the database file */
#define SQLITE_PROTOCOL    15   /* Database lock protocol error */
#define SQLITE_EMPTY       16   /* Internal use only */
#define SQLITE_SCHEMA      17   /* The database schema changed */
#define SQLITE_TOOBIG      18   /* String or BLOB exceeds size limit */
#define SQLITE_CONSTRAINT  19   /* Abort due to constraint violation */
#define SQLITE_MISMATCH    20   /* Data type mismatch */
#define SQLITE_MISUSE      21   /* Library used incorrectly */
#define SQLITE_NOLFS       22   /* Uses OS features not supported on host */
#define SQLITE_AUTH        23   /* Authorization denied */
#define SQLITE_FORMAT      24   /* Not used */
#define SQLITE_RANGE       25   /* 2nd parameter to sqlite3_bind out of range */
#define SQLITE_NOTADB      26   /* File opened that is not a database file */
#define SQLITE_NOTICE      27   /* Notifications from sqlite3_log() */
#define SQLITE_WARNING     28   /* Warnings from sqlite3_log() */
#define SQLITE_ROW         100  /* sqlite3_step() has another row ready */
#define SQLITE_DONE        101  /* sqlite3_step() has finished executing */

#define SQLITE_OPEN_READONLY         0x00000001  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_READWRITE        0x00000002  /* Ok for sqlite3_open_v2() */
#define SQLITE_OPEN_EXCLUSIVE        0x00000010  /* VFS only */

#define SQLITE_INTEGER  1
#define SQLITE_FLOAT    2
#define SQLITE_TEXT     3
#define SQLITE_BLOB     4
#define SQLITE_NULL     5


// translate commands for Harbour's hbsqlit3 library
#xtranslate sqlite3_open([<n,...>])           => sqlt_Create( <n> )
#xtranslate sqlite3_open_v2([<n,...>])        => sqlt_Open( <n> )
#xtranslate sqlite3_exec([<n,...>])           => sqlt_Exec( <n> )
#xtranslate sqlite3_prepare([<n,...>])        => sqlt_Prepare( <n> )
#xtranslate sqlite3_step([<n,...>])           => sqlt_Step( <n> )
#xtranslate sqlite3_column_blob([<n,...>])    => sqlt_ColumnBlob( <n> )
#xtranslate sqlite3_column_double([<n,...>])     => sqlt_ColumnDouble( <n> )
#xtranslate sqlite3_column_int([<n,...>])     => sqlt_ColumnInt( <n> )
#xtranslate sqlite3_column_int64([<n,...>])   => sqlt_ColumnInt64( <n> )
#xtranslate sqlite3_column_text([<n,...>])    => sqlt_ColumnText( <n> )
#xtranslate sqlite3_column_bytes([<n,...>])   => sqlt_ColumnBytes( <n> )
#xtranslate sqlite3_finalize([<n,...>])       => sqlt_Finalize( <n> )

#xtranslate sqlite3_bind_text([<n,...>])      => sqlt_BindText( <n> )
#xtranslate sqlite3_bind_int([<n,...>])       => sqlt_BindInt( <n> )
#xtranslate sqlite3_bind_int64([<n,...>])     => sqlt_BindInt64( <n> )
#xtranslate sqlite3_bind_blob([<n,...>])      => sqlt_BindBlob( <n> )

#xtranslate sqlite3_clear_bindings([<n,...>]) => sqlt_ClearBindings( <n> )
#xtranslate sqlite3_errcode([<n,...>])        => sqlt_ErrCode( <n> )
#xtranslate sqlite3_column_type([<n,...>])    => sqlt_ColumnType( <n> )
#xtranslate sqlite3_last_insert_rowid([<n,...>]) => sqlt_LastInsertRowid( <n> )