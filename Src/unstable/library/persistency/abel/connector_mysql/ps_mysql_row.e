note
	description: "Wrapper for a row in a MySQL result."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_ROW

inherit

	PS_SQL_ROW

create {PS_MYSQL_CONNECTION}
	make

feature {PS_ABEL_EXPORT} -- Status report

	has_column (column_name: STRING): BOOLEAN
			-- Does `Current' have a column with name `column_name'?
		do
			Result := internal_row.mysql_result.field_map.has (column_name)
		end

feature {PS_ABEL_EXPORT} -- Access

	count: INTEGER
			-- The number of items in `Current' row.
		do
			Result := internal_row.count
		end

	at alias "@" (column_name: STRING): STRING
			-- Get the item at column `column_name'. Empty string if database field is NULL.
		do
			Result := internal_row.at_field (column_name).as_string_8
		end

	item alias "[]" (index: INTEGER): STRING
			-- Get the item at index `index'. Empty string if database field is NULL.
		do
			Result := internal_row.at (index).as_string_8
		end

feature {NONE} -- Initialization

	make (a_row: MYSQLI_ROW)
			-- Initialization for `Current'.
		do
			internal_row := a_row
		end

	internal_row: MYSQLI_ROW
			-- The actual row that gets wrapped here

end
