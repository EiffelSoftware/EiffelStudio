note
	description: "Wrapper for a row in a SQLite result."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_ROW

inherit

	PS_SQL_ROW

create {PS_SQLITE_CONNECTION}
	make

feature {PS_ABEL_EXPORT} -- Status report

	has_column (column_name: STRING): BOOLEAN
			-- <Precursor>
		do
			Result := name_to_index_map.has (column_name)
		end


	is_null (column_name: STRING): BOOLEAN
			-- Is `column_name' NULL?
		do
			Result := not attached values.item (name_to_index_map [column_name])
		end

feature {PS_ABEL_EXPORT} -- Access

	count: INTEGER
			-- <Precursor>

	at alias "@" (column_name: STRING): STRING
			-- <Precursor>
		do
			if attached values.item (name_to_index_map [column_name]) as val then
				Result := val
			else
				Result := ""
			end
		end

	item alias "[]" (index: INTEGER): STRING
			-- <Precursor>
		do
			if attached values.item (index.as_natural_32) as val then
				Result := val
			else
				Result := ""
			end
		end

feature {NONE} -- Initialization

	make (sqlite_row: SQLITE_RESULT_ROW)
			-- Initialization for `Current'.
		local
			i: NATURAL
			field_value: detachable STRING
		do
				-- Create the hash tables
			count := sqlite_row.count.to_integer_32
			create name_to_index_map.make (count * 2)
			create values.make (count * 2)
				-- Copy all field values, as the entries in `sqlite_row' are not stable.
			from
				i := 1
			until
				i > sqlite_row.count
			loop
				if not sqlite_row.is_null (i) then
					field_value := sqlite_row.string_value (i)
				else
					field_value := Void
				end
				name_to_index_map.extend (i, sqlite_row.column_name (i))
				values.extend (field_value, i)
				i := i + 1
			end
		end

	values: HASH_TABLE [detachable STRING, NATURAL]
			-- Maps the column index to the actual result.

	name_to_index_map: HASH_TABLE [NATURAL, STRING]
			-- Maps the column name to its index.

end
