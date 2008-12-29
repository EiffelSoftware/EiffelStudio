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

	last_parsed_query : STRING
			-- Last parsed query

feature -- Basic operations

	query (s: STRING)
			-- Query database server using SQL `statement'.
		require
			argument_exists: s /= Void
			connected: is_connected
			prepare_execute: not immediate_execution
			descriptor_is_available: db_spec.descriptor_is_available
		local
			parsed_s: STRING
			parsed: BOOLEAN
		do
			descriptor := db_spec.new_descriptor
			if not db_spec.normal_parse then
				parsed := db_spec.parse (descriptor, ht, ht_order, handle, s)
			end
			if not parsed then
				parsed_s := parse (s)
				db_spec.init_order (descriptor, parsed_s)
			end
			last_parsed_query := parsed_s
			if is_ok then
				db_spec.start_order (descriptor)
			end
			if is_ok then
				db_spec.result_order (descriptor)
			end
			next
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
			is_ok: is_ok
		do
			db_spec.terminate_order (descriptor)
		ensure
			descriptor_is_available: descriptor_available
		end

	modify (s: STRING)
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
			r_any: ANY
			tst : BOOLEAN
			database_data: DATABASE_DATA [G]
		do
			database_data ?= cursor.data
			if database_data /= Void then
				from
					i := 1
				until
					i > database_data.count or not is_ok
				loop
					r_any := database_data.item (i)
					pos := database_data.map_table.item (i)
					if r_any /= Void and pos > 0 then
						tst := field_copy (pos, object,
							db_spec.convert_string_type (r_any,
							field_name (pos, object), r_any.generator))
					elseif pos > 0 then
						tst := field_clean (pos, object)
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




end -- class DATABASE_SELECTION


