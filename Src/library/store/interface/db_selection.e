indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: perform_select, search, retrieve
	Product: EiffelStore
	Database: All_Bases

class DB_SELECTION

inherit
	DB_STATUS_USE
		export
			{ANY} is_ok, is_connected
		end

	DB_EXEC_USE

	EXT_INTERNAL
		export 
			{NONE} all
		end

	DB_EXPRESSION

	DB_CONSTANT
		export
			{NONE} all
		end

creation -- Creation procedure

	make

feature -- Initialization

	make is
			-- Create an interface objet to query active base.
		do
			create ht.make (name_table_size)
			implementation := handle.database.db_selection
			implementation.set_ht (ht)
		end

feature -- Access

	last_parsed_query : STRING is
			-- Last parsed SQL query
		do
			Result := implementation.last_parsed_query
		end

feature -- Status report

	container: LIST [DB_RESULT]
			-- Stored cursors.

	object: ANY
			-- Eiffel object to be filled in by `cursor_to_object'

	cursor: DB_RESULT
			-- Cursor pointing to last fetched query result

	is_exiting: BOOLEAN is
			-- Is exit condition of `load_result' iteration loop met?
		do
			Result := not is_ok or else exhausted or else
					(stop_condition /= Void and then stop_condition.found)
		ensure
			Result implies 
				(not is_ok or else exhausted or else
				(stop_condition /= Void and then stop_condition.found))
		end

	stop_condition: ACTION
			-- Object providing an `execute' routine called
			-- after each `load_result' iteration step

	is_allocatable: BOOLEAN is
			-- Can `Current' be added to other concurrently opened selections?
		do
			Result := implementation.descriptor_available	
		end

	after: BOOLEAN is
			-- Is the `container' after?
		require
			container_exists: container /= Void
		do
			Result := container.after
		end

	error_m: STRING is 
			-- Error message.
		Obsolete
			"Please use `{DB_CONTROL}.error_message'."
		do
			Result := error_message
		end

	error_c: INTEGER is
			-- Error code.
		Obsolete
			"Please use `{DB_CONTROL}.error_code'."
		do
			Result := error_code
		end

feature -- Status setting

	set_container (one_container: like container) is
			-- Make results of selection query persist in container.
		require
			container_exists: one_container /= Void
		do
			container := one_container
			container.start
		ensure
			container_set: container = one_container
		end

	unset_container is
			-- Do not store in `container' results of selection.
		require
			container_exists: container /= Void
		do
			container := Void
		ensure
			container_is_void: container = Void
		end

	object_convert (reference: ANY) is
			-- Set `object' with `reference', reference to an Eiffel 
			-- object to be filled in with `cursor' field values.
			-- Use this before `load_result' for performance.
		require
			reference_exists: reference /= Void
		do
			if object = Void or else
					dynamic_type (reference) /= dynamic_type (object) then
				update_map_table := True
			end
			object := reference
		ensure
			object_set: object = reference
		end

	no_object_convert is
			-- Do not transform `cursor' into an Eiffel object
			-- while reading in selection results.
		do
			object := Void
		ensure
			object = Void
		end

	cursor_to_object is
			-- Assign `object' attributes with `cursor' field values.
		require
			cursor_exists: cursor /= Void
			object_exists: object /= Void
		do
			if cursor.map_table_to_create or else update_map_table then
					-- This case must only happen when `object_convert' has been
					-- called after `load_result': each cursor's map table should be
					-- modified to fit to new object. (Cedric)
				cursor.update_map_table (object)
			end
			if is_ok then
				implementation.cursor_to_object (object, cursor)
			end
		end

	start is
			-- Set `cursor' on first element of `container'.
		require else
			container_exists: container /= Void
		do
			container.start
			cursor := container.item
		ensure then
			container_on_first: container.isfirst
			cursor_updated: cursor = container.item
		end

	forth is
			-- Move `cursor' to next element of `container'.
		require else
			container_exists: container /= Void
		do
			container.forth
			if not container.after then
				cursor := container.item
			end
		ensure then
			container_index_moved: container.index = old container.index + 1
			cursor_updated: not after implies cursor = container.item
		end

	reset_cursor (c: DB_RESULT) is
			-- Reset `cursor' with `c'.
		require
			arguments_exists: c /= Void
			connected: is_connected
		do
			cursor := c
			cursor.set_descriptor (active_selection_number)
		ensure
			cursor_reset: cursor = c
		end

	set_action (action: ACTION) is
			-- Set `stop_condition' with `action'.
		require
			action_exists: action /= Void
		do
			stop_condition := action
		ensure
			stop_condition_set: stop_condition = action
		end

	unset_action is
			-- Reset `stop_condition' to Void.
		do
			stop_condition := Void
		ensure
			stop_condition_void: stop_condition = Void
		end

feature -- Basic operations

	load_result is
			-- Iterate through selection results,
			-- load `container' if requested and call action routine
			-- for each iteration step until `exit_condition' is met.
		require
			connected: is_connected
			is_ok: is_ok
		do
			from
				if cursor = Void then
					create cursor.make
					cursor.set_descriptor (active_selection_number)
				else
					cursor.update_metadata
				end
				if handle.status.found then
					cursor.fill_in
					if object /= Void then
							-- Map table will be cloned if there is
							-- more than 1 row. (Cedric)
						cursor.update_map_table (object)
						update_map_table := False
					end
				end
				if stop_condition /= Void then
					stop_condition.start
				end
			until
				is_exiting
			loop
				if container /= Void then
					container.extend (cursor)
					cursor := deep_clone (cursor)
				end
				if stop_condition /= Void then
					stop_condition.execute
				end
				next
				if not is_exiting then
					cursor.fill_in
				end
			end
		ensure
			cursor_not_void: cursor /= Void
			exit_condition_met: is_exiting
		end

	query (s: STRING) is
			-- Select stored objects using `s' and make
			-- them retrievable using `load_result'.
		require
			-- s is a SQL statement starting with a selection keyword
			connected: is_connected
			argument_exists: s /= Void
			argument_is_not_empty: not s.is_empty
			is_ok: is_ok
			is_allocatable: is_allocatable
		do
			if s.count /= 0 then
				last_query := s
				implementation.query (s)
			end
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		ensure
			last_query_changed: last_query = s
		end

	next is
			-- Move to next element matching the query.
		require
			connected: is_connected
		do
			implementation.next
		end

	terminate is
			-- Clear database cursor.
		require
			connected: is_connected
		do
			implementation.terminate
		ensure
			is_allocatable: is_allocatable
		end

	wipe_out is
			-- Clear selection results.
		do
			if container /= Void then
				container.wipe_out
			end
			cursor := Void
			object := Void
			ht.clear_all
		ensure
			container_is_empty: container /= Void implies container.is_empty
			object_model_void: object = Void
			cursor_void: cursor = Void
		end

	execute_query is
			-- Execute `query' with `last_query'.
		do
			query (last_query)
		end

feature {NONE} -- Implementation

	implementation: DATABASE_SELECTION [DATABASE]
		-- Handle reference to specific database implementation

feature {NONE} -- Status report

	active_selection_number: INTEGER is
			-- Rank of `Current' among concurrently open selections
		do
			Result := implementation.descriptor
		end

	update_map_table: BOOLEAN
			-- Does `map_table' need to be updated?

invariant

	last_cursor_in_container: 
		container /= Void and then not container.is_empty 
								implies container.has (cursor)

end -- class DB_SELECTION


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

