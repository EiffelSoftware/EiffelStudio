note
	description: "DB_CHANGE for dynamic sql"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DYN_CHANGE

inherit
	DB_CHANGE
		redefine
			implementation,
			make
		end

	PARAMETER_HDL

create
	make

feature {NONE} -- Initialization

	make
			-- Creation routine
		do
			implementation := handle.database.db_dyn_change
			create ht.make (name_table_size)
			implementation.set_ht (ht)
		end

feature -- Element change

	prepare (s: STRING)
			-- Parse of the sql statement `s'
		obsolete
			"Use `prepare_32' instead."
		require
			not_void: s /= Void
			meaning_full_sql: s.count > 0
			is_ok: is_ok
			is_allocatable: is_allocatable
		local
			u: UTF_CONVERTER
		do
			implementation.prepare (s)
			set_prepared (True)
			if not is_ok and then is_tracing then
				trace_output.putstring (u.utf_32_string_to_utf_8_string_8  (error_message_32))
				trace_output.new_line
			end
		ensure
			prepared_statement: is_prepared
		end

	prepare_32 (s: STRING_32)
			-- Parse of the sql statement `s'
		require
			not_void: s /= Void
			meaning_full_sql: s.count > 0
			is_ok: is_ok
			is_allocatable: is_allocatable
		local
			u: UTF_CONVERTER
		do
			implementation.prepare_32 (s)
			set_prepared (True)
			if not is_ok and then is_tracing then
				trace_output.putstring (u.utf_32_string_to_utf_8_string_8 (error_message_32))
				trace_output.new_line
			end
		ensure
			prepared_statement: is_prepared
		end

	execute
			-- Execute the sql statement
		require
			prepare_statement: is_prepared
		local
			u: UTF_CONVERTER
		do
			if is_ok then
				implementation.execute
			end
			if not is_ok and then is_tracing then
				trace_output.putstring (u.utf_32_string_to_utf_8_string_8 (error_message_32))
				trace_output.new_line
			end
		end

feature -- Status Report

	is_allocatable : BOOLEAN
		do
			Result := implementation.is_allocatable
		end

feature -- Basic Operations

	terminate
		do
			implementation.terminate
		end

feature {NONE} -- Implementation

	implementation: DATABASE_DYN_CHANGE [DATABASE];
		-- Handle reference to specific database implementation


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




end -- class DB_DYN_CHANGE


