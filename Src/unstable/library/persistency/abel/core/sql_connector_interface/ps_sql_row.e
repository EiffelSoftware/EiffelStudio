note
	description: "Provides an interface for a wrapper to a single row of an SQL result."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_SQL_ROW

feature {PS_ABEL_EXPORT} -- Status report

	has_column (column_name: STRING): BOOLEAN
			-- Does `Current' have a column with name `column_name'?
		deferred
		end

	is_null (column_name: STRING): BOOLEAN
			-- Is `column_name' NULL?
		deferred
		end

feature {PS_ABEL_EXPORT} -- Access

	count: INTEGER
			-- The number of items in `Current' row.
		deferred
		end

	at alias "@" (column_name: STRING): STRING
			-- Get the item at column `column_name'. Empty string if database field is NULL.
		require
			column_exists: has_column (column_name)
		deferred
		end

	item alias "[]" (index: INTEGER): STRING
			-- Get the item at index `index'. Empty string if database field is NULL.
		require
			valid_index: 0 < index and index <= count
		deferred
		end

end
