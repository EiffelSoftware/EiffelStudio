note
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

	SQL_SCAN [G]

create -- Creation procedure

	make

create {DATABASE_CHANGE}
	string_make

feature -- Access

	last_parsed_query : detachable STRING
			-- Last parsed query
		obsolete
			"Use `last_parsed_query_32' instead  [2017-11-30]."
		do
			if attached last_parsed_query_32 as l_str then
				Result := l_str.as_string_8
			end
		end

	last_parsed_query_32 : detachable STRING_32
			-- Last parsed query

	affected_row_count: INTEGER
			-- The number of rows changed, deleted, or inserted by the last statement
		require
			is_affected_row_count_supported: is_affected_row_count_supported
		do
			Result := internal_affected_row_count
		end

feature -- Query

	is_affected_row_count_supported: BOOLEAN
			-- Is `affected_row_count' supported?
		do
			Result := db_spec.is_affected_row_count_supported
		end

feature -- Element change

	modify (sql: READABLE_STRING_GENERAL)
			-- Pass to active database handle a modification
			-- query with SQL statement `sql'.
			-- Execute `sql' statement.
		require else
			argument_exists: sql /= Void
			connected: is_connected
		local
			tmp_string: detachable STRING_32
			temp_descriptor: INTEGER
			parsed: BOOLEAN
			l_is_ok: BOOLEAN
		do
			if not immediate_execution then
				temp_descriptor := db_spec.new_descriptor
				l_is_ok := is_ok
			else
				l_is_ok := True
			end
			if l_is_ok then
				if not db_spec.normal_parse then
				--	handle.execution_type.set_immediate
					parsed := db_spec.parse (temp_descriptor, ht, ht_order, handle, sql, False)
					tmp_string := sql.as_string_32
				end

				if not parsed then
					tmp_string := parse_32 (sql)
					if immediate_execution then
						db_spec.pre_immediate (temp_descriptor, 0)
					else
						db_spec.init_order (temp_descriptor, tmp_string)
					end
				end
				last_parsed_query_32 := tmp_string
				internal_affected_row_count := 0
				if tmp_string /= Void then
					if immediate_execution then
							-- Allocate a new descriptor, just for the exec_immediate.
						temp_descriptor := db_spec.new_descriptor
						if is_ok then
							db_spec.exec_immediate (temp_descriptor, tmp_string)
							db_spec.terminate_order (temp_descriptor)
						end
					else
						if is_ok then
							db_spec.start_order (temp_descriptor)
							if is_ok then
								db_spec.results_order (temp_descriptor).do_nothing
							end
						end
						db_spec.terminate_order (temp_descriptor)
					end
					if is_affected_row_count_supported then
						internal_affected_row_count := db_spec.affected_row_count
					end
				end
			else
				if is_affected_row_count_supported then
					internal_affected_row_count := 0
				end
			end
			handle.execution_type.unset_immediate
		end

feature -- Status setting

	set_ht (table: attached like ht)
			-- Pass map `table' to current.
			-- Set `ht' with `table'.
		require
			table_exists: table /= Void
		do
			ht := table
		ensure then
			ht = table
		end

	set_ht_order (list: attached like ht_order)
			-- Pass map `list' to current.
			-- Set `ht_order' with `list'.
		require
			list_exists: list /= Void
		do
			ht_order := list
		ensure then
			ht_order = list
		end

feature {NONE} -- Implementation

	internal_affected_row_count: like affected_row_count;
			-- Internal `affected_row_count'


note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATABASE_CHANGE


