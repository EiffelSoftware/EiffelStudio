indexing
	description: "Implementation of DB_SELECTION";
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
			is_equal, out, copy, consistent, setup

		end

	DB_EXEC_USE
		undefine
			is_equal, out, copy, consistent, setup
		end 

	SQL_SCAN

	HANDLE_SPEC [G]
		undefine
			is_equal, out, copy, consistent, setup
		end

creation -- Creation procedure

	make

feature -- Access

	last_parsed_query : STRING
			-- Last parsed query

feature -- Basic operations

	query (s: STRING) is
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
				parsed := db_spec.parse (descriptor, ht, handle, s)	
			end
			if not parsed then
				parsed_s := parse (s)
				handle.status.set (db_spec.init_order (descriptor, parsed_s))
			end
			last_parsed_query := parsed_s
			if is_ok then
				handle.status.set (db_spec.start_order (descriptor))
			end
			if is_ok then
				handle.status.set (db_spec.result_order (descriptor))
			end
			next
		end

	next is			
			-- Move to next row matching execute clause.

		require else
			connected: is_connected
		do
			if is_ok then
				handle.status.set_found (db_spec.next_row (descriptor))
				if not handle.status.found then
					reset
				end
			end
		end


	terminate is
			-- Release cursor descriptor used with last query.
		require else
			connected: is_connected
			is_ok: is_ok
		do
			handle.status.set (db_spec.terminate_order (descriptor))
		ensure
			descriptor_is_available: descriptor_available
		end

	modify (s: STRING) is
			-- Do nothing.
		do
		end

feature -- Status setting

	cursor_to_object (object: ANY; cursor: DB_RESULT) is
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
--			database: G
		do
			database_data ?= cursor.data
			if database_data /= Void then
				from
					i := 1
--					create database
				until
					i > database_data.count or not is_ok
				loop
					r_any := database_data.item (i)
					pos := database_data.map_table.item (i)
					if r_any /= Void and pos > 0 then
						tst := field_copy (pos, object,
--								database.convert_string_type (r_any,
								db_spec.convert_string_type (r_any,
									  field_name (pos, object), r_any.generator))
					end
					i := i + 1
				end
			end
		end

	set_ht (table: HASH_TABLE [ANY, STRING]) is
			-- Obtain bind variables table.
			-- Set `ht' with `table'.
		require else
			table_exists: table /= Void
		do
			ht := table
		ensure then
			ht = table
		end

feature -- Status report

	descriptor: INTEGER
			-- Cursor descriptor index

	descriptor_available: BOOLEAN is
            -- Is a new cursor descriptor available?
        do
            Result := db_spec.descriptor_is_available
        end

feature -- Error handling

--	code_error: INTEGER is
--		do
--			handle.status.error_code
--		end

--	message_error: STRING is
--		do
--			handle.status.message_error
--		end

end -- class DATABASE_SELECTION

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
