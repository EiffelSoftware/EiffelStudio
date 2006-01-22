indexing
	description: "Class which encapsulates primary key information for a table recieved from ODBS SqlPrimaryKeys() function."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ODBC_FOREIGN_KEY_RESULT

creation
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create pktable_cat.make (10)
			create pktable_schem.make (10)
			create pktable_name.make (10)
			create pkcolumn_name.make (10)
			create fktable_cat.make (10)
			create fktable_schem.make (10)
			create fktable_name.make (10)
			create fkcolumn_name.make (10)
		end

feature -- Implementation

	pktable_cat: STRING

	pktable_schem: STRING

	pktable_name: STRING

	pkcolumn_name: STRING
	
	fktable_cat: STRING

	fktable_schem: STRING

	fktable_name: STRING

	fkcolumn_name: STRING
	
	key_seq: INTEGER
	
	update_rule: INTEGER
	
end
