note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: SQL, structure
	Product: EiffelStore
	Database: RDBMS

deferred class DB_DATA_SQL

inherit

	DB_DATA

feature  -- Status report

	count: INTEGER
			-- Number of columns in result
		deferred
		end

	map_table: detachable ARRAY [INTEGER]
			-- Correspondance table between column
			-- rank and attribute rank in mapped object
		deferred
		end

	column_name (index: INTEGER): detachable STRING
			-- Name of the `index-th' column
		require
			select_name_not_void: is_select_name_attached
		deferred
		end

	item (index: INTEGER): detachable ANY
			-- Data at `index-th' column
		require
			value_not_void: is_value_attached
		deferred
		end

	is_select_name_attached: BOOLEAN
			-- If `select_name' attached?
		do
			Result := select_name /= Void
		end

	is_value_attached: BOOLEAN
			-- If `value' attached?
		do
			Result := value /= Void
		end

feature -- Status setting

	update_map_table (object: ANY)
			-- Update map table according to field names of `object'.
		require else
			object_not_void: object /= Void
		deferred
		end

	fill_in (no_descriptor: INTEGER)
			-- Fill in attributes of Current with results obtained
			-- from server after execution of query statement.
		deferred
		end

feature {NONE} -- Status report

	value: detachable ARRAY [detachable ANY]
			-- Array of values corresponding to a tuple
		deferred
		end

	value_size: detachable ARRAY [INTEGER]
			-- Array of result value size for each column
		deferred
		end

	value_type: detachable ARRAY [INTEGER]
			-- Array of column result type coded according to Eiffel conventions
		deferred
		end

	select_name: detachable ARRAY [detachable STRING]
			-- Array of selected column names listed in select clause
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_DATA_SQL




