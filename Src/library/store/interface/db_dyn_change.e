indexing
	description: "DB_CHANGE for dynamic sql"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DYN_CHANGE

inherit
	DB_CHANGE
		undefine
			set_map_name,
			unset_map_name,
			is_mapped,
			mapped_value,
			clear_all
		redefine
			implementation,
			make
		end

	PARAMETER_HDL
		redefine
			parameter_count
		end

create
	make

feature -- Initialization

	make is
			-- Creation routine
		do
			implementation := handle.database.db_dyn_change
			create ht.make (name_table_size)
			implementation.set_ht (ht)
			init
			implementation.init_implementation (parameters_value, parameters)
		end

feature -- Element change

	prepare (s: STRING) is
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_sql: s.count > 0
			is_ok: is_ok
			is_allocatable: is_allocatable
		do
			implementation.prepare (s)
			set_prepared (TRUE)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		ensure
			prepared_statement: is_prepared
		end

	execute is
			-- Execute the sql statement
		require
			prepare_statement: is_prepared
		do
			if is_ok then
				implementation.execute
			end
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		end

	parameter_count : INTEGER is
		do
			Result := implementation.parameter_count
		end

feature -- Status Report

	is_allocatable : BOOLEAN is
		do
			Result := implementation.is_allocatable
		end

feature -- Basic Operations

	terminate is
		do
			implementation.terminate
		end

feature {NONE} -- Implementation

	implementation: DATABASE_DYN_CHANGE [DATABASE];
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




end -- class DB_DYN_CHANGE


