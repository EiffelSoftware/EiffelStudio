note
	description: "MySQL Row Class"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_ROW

inherit
	ARRAYED_LIST [MYSQLI_VALUE]
		redefine
			out,
			new_filled_list
		end

create{MYSQLI_EXTERNALS, MYSQLI_ROW}
	make_with_result

feature{NONE} -- Initialization

	make_with_result (n: INTEGER; a_result: MYSQLI_RESULT)
			-- Initialize this row with size `n' and result set `a_result'.
		do
			make (n)
			mysql_result := a_result
		end

feature -- Access

	at_field (a_field: STRING): MYSQLI_VALUE
			-- Value at column `a_column'
		require
			mysql_result.field_map.has (a_field)
		do
			Result := at (mysql_result.field_map.at (a_field))
		end

	as_hash_table: HASH_TABLE [MYSQLI_VALUE, STRING]
			-- This row as a hash table, keys are field names, values are values
		once ("OBJECT")
			create Result.make (mysql_result.fields.count)
			from
				mysql_result.fields.start
			until
				mysql_result.fields.after
			loop
				Result.extend (at_field (mysql_result.fields.item.name), mysql_result.fields.item.name)
				mysql_result.fields.forth
			end
		end

feature -- Access

	out: STRING
			-- Return all the values in this row joined by commas
		once ("OBJECT")
			create Result.make_empty
			from
				Current.start
			until
				Current.after
			loop
				Result.append (Current.item.as_string)
				Current.forth
				if not Current.after then
					Result.append_character (',')
				end
			end
		end

feature -- Access (Result)

	mysql_result: MYSQLI_RESULT
			-- Result set this row is contained in

feature {NONE}	-- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_with_result (0, create {MYSQLI_RESULT}.make_empty)
		end

end
