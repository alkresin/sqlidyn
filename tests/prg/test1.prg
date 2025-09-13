/*
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