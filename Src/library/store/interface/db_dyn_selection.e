indexing
	description: "DB_SELECTION for dynamic sql"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Initialization

	make is
			-- Create an interface objet to query active base.
		do
			create ht.make (name_table_size)
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

	implementation: DATABASE_DYN_SELECTION [DATABASE];
		-- Handle reference to specific database implementation

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_DYN_SELECTION


