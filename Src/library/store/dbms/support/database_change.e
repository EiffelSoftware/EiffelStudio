indexing
	description: "Implmentation of DB_CHANGE"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DATABASE_CHANGE [G -> DATABASE create default_create end]

inherit

	DB_STATUS_USE
		export
			{ANY} is_ok
			{ANY} is_connected
		undefine
			is_equal, out, copy
		end

	DB_EXEC_USE
		undefine
			is_equal, out, copy
		end

	SQL_SCAN

create -- Creation procedure

	make

create {DATABASE_CHANGE}
	string_make

feature -- Access

	last_parsed_query : STRING
			-- Last parsed query

feature -- Element change

	modify (sql: STRING) is
			-- Pass to active database handle a modification
			-- query with SQL statement `sql'.
			-- Execute `sql' statement.
		require else
			argument_exists: sql /= Void
			connected: is_connected
			descriptor_is_available: db_spec.descriptor_is_available
		local
			tmp_string: STRING
			temp_descriptor: INTEGER
			parsed: BOOLEAN
		do
			if not immediate_execution then
				temp_descriptor := db_spec.new_descriptor
			end
			if not db_spec.normal_parse then
			--	handle.execution_type.set_immediate
				parsed := db_spec.parse (temp_descriptor, ht, ht_order, handle, sql)
				tmp_string := sql
			end

			if not parsed then
				tmp_string := parse (sql)
				if immediate_execution then
					db_spec.pre_immediate (temp_descriptor, 0)
				else
					db_spec.init_order (temp_descriptor, tmp_string)
				end
			end
			last_parsed_query := tmp_string
			if tmp_string /= Void then
				if immediate_execution then
						-- Allocate a new descriptor, just for the exec_immediate.
					temp_descriptor := db_spec.new_descriptor
					db_spec.exec_immediate (temp_descriptor, tmp_string)
					db_spec.terminate_order (temp_descriptor)
				else
					if is_ok then
						db_spec.start_order (temp_descriptor)
						if is_ok then
							handle.status.set (db_spec.results_order (temp_descriptor))
						end
					end
					db_spec.terminate_order (temp_descriptor)
				end
			end
			handle.execution_type.unset_immediate
		end

feature -- Status setting

	set_ht (table: HASH_TABLE [ANY, STRING]) is
			-- Pass map `table' to current.
			-- Set `ht' with `table'.
		require else
			table_exists: table /= Void
		do
			ht := table
		ensure then
			ht = table
		end

	set_ht_order (list: ARRAYED_LIST [STRING]) is
			-- Pass map `list' to current.
			-- Set `ht_order' with `list'.
		require else
			list_exists: list /= Void
		do
			ht_order := list
		ensure then
			ht_order = list
		end

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




end -- class DATABASE_CHANGE


