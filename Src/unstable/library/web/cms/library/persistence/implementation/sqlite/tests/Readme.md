SQLite ODBC.

Install the odbc driver from http://www.ch-werner.de/sqliteodbc/

Current version
	sqliteodbc.exe          -- Win32 
	sqliteodbc_w64.exe      -- Win64


Test the ODBC driver using Firefox SQLite DBManager https://addons.mozilla.org/en-US/firefox/addon/sqlite-manager/

1. Open the odbc manger from Windows, create a new database using the SQLite3 ODBC driver and then open it from Firefox.


EiffelStore + SQLiteODBC.

Connection String:  https://www.connectionstrings.com/sqlite3-odbc-driver/

	"Driver=SQLite3 ODBC Driver;Database=./cms_lite.db;LongNames=0;Timeout=1000;NoTXN=0;SyncPragma=NORMAL;StepAPI=0;"

Edit the database location based on your system.





