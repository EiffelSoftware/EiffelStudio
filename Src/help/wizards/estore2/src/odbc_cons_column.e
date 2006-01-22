indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ODBC_CONS_COLUMN

create
	make

feature -- Initialization

	make (tname, colname: STRING) is
			-- Initialize.
		do
			table_name := tname
			column_name := colname
		end

feature -- Implementation

	table_name: STRING

	column_name: STRING

end
