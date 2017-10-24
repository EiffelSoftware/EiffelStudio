How to Install Microsoft ODBC Driver for SQL Server on Linux?

1. Install the driver from this link https://docs.microsoft.com/en-us/sql/connect/odbc/linux/installing-the-microsoft-odbc-driver-for-sql-server-on-linux

Select the Linux Version.
For example Ubuntu 16.04

sudo su 
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install msodbcsql=13.1.4.0-1 unixodbc-dev

If the package 13.1.4.0-1 is not found try to use 
sudo ACCEPT_EULA=Y apt-get install msodbcsql unixodbc-dev


2- Check the driver location.
/opt/microsoft/msodbcsql/lib64/libmsodbcsql-13.1.so.7.0

3- Check if the driver is defined.
#  odbcinst -j 
you will see something like this

unixODBC 2.3.1
DRIVERS............: /etc/odbcinst.ini
SYSTEM DATA SOURCES: /etc/odbc.ini
FILE DATA SOURCES..: /etc/ODBCDataSources
SQLULEN Size.......: 8
SQLLEN Size........: 8
SQLSETPOSIROW Size.: 8

4- Check the /etc/odbcinst.ini

The expected result should be something like this

[ODBC Driver 13 for SQL Server]
Description=Microsoft ODBC Driver 13 for SQL Server
Driver=/opt/microsoft/msodbcsql/lib64/libmsodbcsql-13.1.so.7.0
UsageCount=1


5- Updating the configuration file, we will need to update the driver to 'ODBC Driver 13 for SQL Server' or the corresponding version you have installed.
and then we will need to update the data related to the connection string, Server, Database Name, User and Password as needed. 

{
	"database": {
		"datasource": {
			"driver": "ODBC Driver 13 for SQL Server",
			"environment": "test"
		},
		"environments": {
		}
	},
	
}



Optional:
The following steps install the command-line tools and their dependencies. The mssql-tools package contains:

# sqlcmd: Command-line query utility.
# bcp: Bulk import-export utility.

sudo ACCEPT_EULA=Y apt-get install mssql-tools 
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc




