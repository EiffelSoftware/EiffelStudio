indexing
	description: "DB_SELECTION for dynamic sql"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DYN_SELECTION

inherit
	DB_SELECTION
		rename
			implementation as db_sel_imp
		undefine
			set_map_name, unset_map_name, is_mapped, mapped_value, clear_all
		redefine
			make
		end

	DB_SELECTION
		undefine
			set_map_name, unset_map_name, is_mapped, mapped_value, clear_all
		redefine
			implementation,
			make
		select
			implementation
		end

	PARAMETER_HDL
		redefine
			parameter_count
		end

creation
	make

feature -- Initialization

	make is
			-- Create an interface objet to query active base.
		do
			!! ht.make (name_table_size)
			implementation := handle.database.db_dyn_selection
			implementation.set_ht (ht)
			init
			implementation.init_implementation (parameters_value, parameters)
		end

feature -- Element change

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_statement: s.count > 0
			is_ok: is_ok
			is_allocatable: is_allocatable
		do
			set_executed (FALSE)
			implementation.prepare (s)
			set_prepared (TRUE)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		ensure
			prepared_statement: is_prepared
			prepared_statement: not is_executed
		end

	bind_parameter is 
			-- Bind of the parameters of the sql statement 
		require
			prepared_statement: is_prepared
		do
			implementation.bind_parameter
		end

	execute  is
			-- Execute the sql statement
		require
			prepared_statement: is_prepared
		do
			if is_ok then
				if is_executed then
					implementation.reset_cursor
				else
					set_executed (TRUE)
				end
				implementation.execute
			end
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		ensure
			prepared_statement: is_executed
		end

	parameter_count : INTEGER is
		do
			Result := implementation.parameter_count
		end

feature {NONE} -- Implementation

	implementation: DATABASE_DYN_SELECTION [DATABASE]
		-- Handle reference to specific database implementation

end -- class DB_DYN_SELECTION

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

