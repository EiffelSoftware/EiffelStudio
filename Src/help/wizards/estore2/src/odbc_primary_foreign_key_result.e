indexing
	description: "Class which encapsulates primary key information for a table recieved from ODBS SqlPrimaryKeys() function."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ODBC_PRIMARY_FOREIGN_KEY_RESULT

creation
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create table_cat.make (10)
			create table_schem.make (10)
			create table_name.make (10)
			create column_name.make (10)
			create pk_name.make (10)
		end

feature -- Implementation

	table_cat: STRING

	table_schem: STRING

	table_name: STRING

	column_name: STRING
	
	key_seq: BOOLEAN
	
	pk_name: STRING
	
end
