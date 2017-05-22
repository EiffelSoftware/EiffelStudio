note
	description: "Implementation of DB_SELECTION"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_SELECTION [G -> DATABASE create default_create end]

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

create {DATABASE_SELECTION}
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

	last_parsed_query_32: detachable STRING_32
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

feature -- Basic operations

	query (s: READABLE_STRING_GENERAL)
			-- Query database server using SQL `statement'.
		require
			argument_exists: s /= Void
			connected: is_connected
			prepare_execute: not immediate_execution
		local
			parsed_s: detachable STRING_32
			parsed: BOOLEAN
			l_db_spec: like db_spec
			l_status: DB_STATUS
		do
			l_db_spec := db_spec
			l_status := handle.status
			descriptor := l_db_spec.new_descriptor
			if l_status.is_ok then
				if not l_db_spec.normal_parse then
					parsed := l_db_spec.parse (descriptor, ht, ht_order, handle, s, False)
				end
				if not parsed then
					parsed_s := parse_32 (s)
					l_db_spec.init_order (descriptor, parsed_s)
				end
				last_parsed_query_32 := parsed_s
				internal_affected_row_count := 0
				if l_status.is_ok then
					l_db_spec.start_order (descriptor)
				end
				if l_status.is_ok then
					l_db_spec.result_order (descriptor)
					if is_affected_row_count_supported then
						internal_affected_row_count := l_db_spec.affected_row_count
					end

						-- Move to next row.
					l_db_spec.next_row (descriptor)
				end
			end
		end

	next
			-- Move to next row matching execute clause.
		require else
			connected: is_connected
		do
			if is_ok then
				db_spec.next_row (descriptor)
				--if not handle.status.found then
				--	reset
				--end
			end
		end

	terminate
			-- Release cursor descriptor used with last query.
		require else
			connected: is_connected
		do
			db_spec.terminate_order (descriptor)
		ensure
			descriptor_is_available: descriptor_available
		end

	modify (s: READABLE_STRING_GENERAL)
			-- Do nothing.
		do
		end

feature -- Status setting

	cursor_to_object (object: ANY; cursor: DB_RESULT)
			-- Effectively load `object' attributes with
			-- `cursor' fields.
		require
			cursor_exists: cursor /= Void
			object_exists: object /= Void
		local
			i, pos: INTEGER
			r_any: detachable ANY
			tst : BOOLEAN
			l_db_count: INTEGER
			l_is_convert_string_type_required: BOOLEAN
		do
				-- Does a database field need conversion to an Eiffel object?
			if attached {DATABASE_DATA [G]} cursor.data as database_data and then attached database_data.map_table as l_map_table then
				from
					i := 1
					l_db_count := database_data.count
					l_is_convert_string_type_required := db_spec.is_convert_string_type_required
				until
					i > l_db_count
				loop
					pos := l_map_table.item (i)
					if pos > 0 then
						r_any := database_data.item (i)
						if r_any /= Void then
								-- Convert string type if backend requires it.
							if l_is_convert_string_type_required then
								tst := field_copy (pos, object,
									db_spec.convert_string_type (r_any,
									field_name (pos, object), r_any.generator))
							else
								tst := field_copy (pos, object, r_any)
							end
						else
							tst := field_clean (pos, object)
						end
					end
					i := i + 1
				end
			end
		end

	set_ht (table: like ht)
			-- Obtain bind variables table.
			-- Set `ht' with `table'.
		require
			table_exists: table /= Void
		do
			ht := table
		ensure
			ht = table
		end

	set_ht_order (table: like ht_order)
			--
		require
			table_not_void: table /= Void
		do
			ht_order := table
		ensure
			ht_order_set: ht_order = table
		end

feature -- Status report

	descriptor: INTEGER
			-- Cursor descriptor index

	descriptor_available: BOOLEAN
            -- Is a new cursor descriptor available?
        do
            Result := db_spec.descriptor_is_available
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




end -- class DATABASE_SELECTION


