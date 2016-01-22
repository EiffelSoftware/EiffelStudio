note
	description: "MySQL Result Class"
	author: "haroth@student.ethz.ch"
	date: "$Date$"
	revision: "$Revision$"

class
	MYSQLI_RESULT

inherit
	ARRAYED_LIST [MYSQLI_ROW]
		redefine
			new_filled_list
		end

create {MYSQLI_RESULT, MYSQLI_EXTERNALS, MYSQLI_CLIENT, MYSQLI_ROW}
	make_with_fields,
	make_empty

feature{NONE} -- Initialization

	make_with_fields (a_field_list: like fields; a_info: like info; a_row_count, a_affected_rows, a_last_insert_id, a_warning_count: INTEGER)
			-- Initialize with field list, info, row count, affected rows, last insert id, warning count
		do
			make (a_row_count)
			fields := a_field_list
			info := a_info
			affected_rows := a_affected_rows
			last_insert_id := a_last_insert_id
			warning_count := a_warning_count
		end

	make_empty
			-- Initialize with empty field list, info, row count, affected rows, last insert id, warning count
		do
			make (0)
			create fields.make (0)
			create info.make_empty
			affected_rows := 0
			last_insert_id := 0
			warning_count := 0
		end

feature -- Access

	last_insert_id: INTEGER
			-- Returns the value generated for an AUTO_INCREMENT column by the previous INSERT or UPDATE statement.

	affected_rows: INTEGER
			-- It returns the number of rows changed, deleted, or inserted by the last statement if it was an UPDATE, DELETE, or INSERT.

	warning_count: INTEGER
			-- Number of warnings generated during execution

	info: STRING
			-- Information about the query
			-- http://dev.mysql.com/doc/refman/5.1/en/mysql-info.html

	field_by_name (a_field: STRING): MYSQLI_FIELD
			-- Field at field `a_field'
		require
			field_map.has (a_field)
		do
			Result := fields.at (field_map.at (a_field))
		end

feature -- Access

	fields: ARRAYED_LIST [MYSQLI_FIELD]
			-- The fields of this result set

	field_map: HASH_TABLE [INTEGER, STRING]
			-- Field names mapped to array offset
		local
			i: INTEGER
		once ("OBJECT")
			create Result.make (fields.count)
			from
				i := 1
			until
				i > fields.count
			loop
				Result.put (i, fields.at (i).name)
				i := i + 1
			end
		end
feature {NONE}	-- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_empty
		end

end
