note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: perform_select, search, retrieve
	Product: EiffelStore
	Database: All_Bases

class DB_SELECTION

inherit
	DB_STATUS_USE

	DB_EXEC_USE

	EXT_INTERNAL
		export
			{NONE} all
		end

	DB_EXPRESSION
		redefine
			is_executable
		end

	DB_CONSTANT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create an interface object to query active base.
		require
			database_set: is_database_set
		local
			l_imp: like implementation
		do
			create ht.make (name_table_size)
			create ht_order.make (name_table_size)
			ht_order.compare_objects
			l_imp := handle.database.db_selection
			l_imp.set_ht (ht)
			l_imp.set_ht_order (ht_order)
			implementation := l_imp
		end

feature -- Access

	last_parsed_query : detachable STRING
			-- Last parsed SQL query
		obsolete
			"Use `last_parsed_query_32' instead [2017-11-30]."
		do
			if attached implementation.last_parsed_query_32 as l_s then
				Result := l_s.as_string_8
			end
		end

	last_parsed_query_32 : detachable STRING_32
			-- Last parsed SQL query
		do
			Result := implementation.last_parsed_query_32
		end

	is_affected_row_count_supported: BOOLEAN
			-- Is `affected_row_count' supported?
		do
			Result := implementation.is_affected_row_count_supported
		end

	affected_row_count: INTEGER_32
			-- The number of rows changed, deleted, or inserted by the last statement
		do
			Result := implementation.affected_row_count
		end

feature -- Status report

	container: detachable LIST [DB_RESULT]
			-- Stored cursors.

	object: detachable ANY
			-- Eiffel object to be filled in by `cursor_to_object'

	cursor: detachable DB_RESULT
			-- Cursor pointing to last fetched query result

	is_exiting: BOOLEAN
			-- Is exit condition of `load_result' iteration loop met?
		do
			Result := not is_ok or else exhausted or else
					(attached stop_condition as l_stop_condition and then l_stop_condition.found)
		ensure
			Result implies
				(not is_ok or else exhausted or else
				(attached stop_condition as le_stop_condition and then le_stop_condition.found))
		end

	stop_condition: detachable ACTION
			-- Object providing an `execute' routine called
			-- after each `load_result' iteration step

	is_allocatable: BOOLEAN
			-- Can `Current' be added to other concurrently opened selections?
		do
			Result := implementation.descriptor_available
		end

	is_executable: BOOLEAN
			-- <Precursor>
		do
			Result := attached last_query_32 as l_s and then
						not l_s.is_empty and then
						is_connected and then
						is_ok
		end

	after: BOOLEAN
			-- Is the `container' after?
		require
			container_exists: container /= Void
		do
			if attached container as l_container then
				Result := l_container.after
			end
		end

	error_m: STRING
			-- Error message.
		Obsolete
			"Please use `{DB_CONTROL}.error_message' [2017-11-30]."
		do
			Result := error_message
		end

	error_c: INTEGER
			-- Error code.
		Obsolete
			"Please use `{DB_CONTROL}.error_code' [2017-11-30]."
		do
			Result := error_code
		end

feature -- Status setting

	set_container (one_container: attached like container)
			-- Make results of selection query persist in container.
		require
			container_exists: one_container /= Void
		do
			container := one_container
			one_container.start
		ensure
			container_set: container = one_container
		end

	unset_container
			-- Do not store in `container' results of selection.
		require
			container_exists: container /= Void
		do
			container := Void
		ensure
			container_is_void: container = Void
		end

	object_convert (ref: ANY)
			-- Set `object' with `reference', reference to an Eiffel
			-- object to be filled in with `cursor' field values.
			-- Use this before `load_result' for performance.
		require
			reference_exists: ref /= Void
		do
			if not attached object as l_object or else dynamic_type (ref) /= dynamic_type (l_object) then
				update_map_table := True
			end
			object := ref
		ensure
			object_set: object = ref
		end

	no_object_convert
			-- Do not transform `cursor' into an Eiffel object
			-- while reading in selection results.
		do
			object := Void
		ensure
			object = Void
		end

	cursor_to_object
			-- Assign `object' attributes with `cursor' field values.
		require
			cursor_exists: cursor /= Void
			object_exists: object /= Void
		do
			if attached cursor as l_cursor and attached object as l_object then
				if l_cursor.map_table_to_create or else update_map_table then
						-- This case must only happen when `object_convert' has been
						-- called after `load_result': each cursor's map table should be
						-- modified to fit to new object. (Cedric)
					l_cursor.update_map_table (l_object)
				end
				if is_ok then
					implementation.cursor_to_object (l_object, l_cursor)
				end
			end
		end

	start
			-- Set `cursor' on first element of `container'.
		require
			container_exists: container /= Void
		do
			if attached container as l_container then
				l_container.start
				if not l_container.off then
					cursor := l_container.item
				end
			end
		ensure then
			container_attached: attached container as l_container
			container_on_first: not l_container.is_empty implies l_container.isfirst
			cursor_updated: not l_container.is_empty implies cursor = l_container.item
		end

	forth
			-- Move `cursor' to next element of `container'.
		require
			container_exists: container /= Void
		do
			if attached container as l_container then
				l_container.forth
				if not l_container.after then
					cursor := l_container.item
				end
			end
		ensure then
			container_attached: (attached container as le_container) and (attached old container as le_old_container)
			container_index_moved:  le_container.index = le_old_container.index + 1
			cursor_updated: not after implies cursor = le_container.item
		end

	reset_cursor (c: DB_RESULT)
			-- Reset `cursor' with `c'.
		require
			arguments_exists: c /= Void
			connected: is_connected
		do
			cursor := c
			c.set_descriptor (active_selection_number)
		ensure
			cursor_reset: cursor = c
		end

	set_action (action: ACTION)
			-- Set `stop_condition' with `action'.
		require
			action_exists: action /= Void
		do
			stop_condition := action
		ensure
			stop_condition_set: stop_condition = action
		end

	unset_action
			-- Reset `stop_condition' to Void.
		do
			stop_condition := Void
		ensure
			stop_condition_void: stop_condition = Void
		end

feature -- Basic operations

	load_result
			-- Iterate through selection results,
			-- load `container' if requested and call action routine
			-- for each iteration step until `exit_condition' is met.
		require
			connected: is_connected
			is_ok: is_ok
		local
			l_container: like container
			l_cursor: like cursor
			l_object: like object
			l_stop_condition: like stop_condition
		do
			from
				l_cursor := cursor
				if l_cursor = Void then
					create l_cursor.make
					cursor := l_cursor
				else
					l_cursor.update_metadata
				end
				l_cursor.set_descriptor (active_selection_number)
				if handle.status.found then
					l_cursor.fill_in
					l_object := object
					if l_object /= Void then
							-- Map table will be cloned if there is
							-- more than 1 row. (Cedric)
						l_cursor.update_map_table (l_object)
						update_map_table := False
					end
				else
						-- We need to reset the cursor to avoid reusing last data.
						-- TEST_PROCEDURE will fail when executing more than one tests in a single thread.
					l_cursor.reset
				end
				l_stop_condition := stop_condition
				if l_stop_condition /= Void then
					l_stop_condition.start
				end
				l_container := container
			until
				is_exiting
			loop
				if l_container /= Void then
					l_container.extend (l_cursor)
					l_cursor := l_cursor.deep_twin
					cursor := l_cursor
				end
				l_stop_condition := stop_condition
				if l_stop_condition /= Void then
					l_stop_condition.execute
				end
				next
				if not is_exiting then
					l_cursor.fill_in
				end
			end
		ensure
			cursor_not_void: cursor /= Void
			exit_condition_met: is_exiting
		end

	query (s: READABLE_STRING_GENERAL)
			-- Select stored objects using `s' and make
			-- them retrievable using `load_result'.
		require
			-- s is a SQL statement starting with a selection keyword
			connected: is_connected
			argument_exists: s /= Void
			argument_is_not_empty: not s.is_empty
			is_ok: is_ok
		local
			l_last_query_32: STRING_32
		do
			l_last_query_32 := s.as_string_32
			last_query_32 := l_last_query_32
			implementation.query (l_last_query_32)
			if is_tracing and then not is_ok then
				trace_message (error_message_32)
			end
		ensure
			last_query_changed: attached last_query_32 as l_s and then l_s.same_string_general (s)
		end

	next
			-- Move to next element matching the query.
		require
			connected: is_connected
		do
			implementation.next
		end

	terminate
			-- Clear database cursor.
		require
			connected: is_connected
		do
			implementation.terminate
		ensure
			is_allocatable: is_allocatable
		end

	wipe_out
			-- Clear selection results.
		local
			l_container: like container
		do
			l_container := container
			if l_container /= Void then
				l_container.wipe_out
			end
			cursor := Void
			object := Void

			if ht /= Void then
				ht.wipe_out
			end
		ensure
			container_is_empty: attached container as le_container implies le_container.is_empty
			object_model_void: object = Void
			cursor_void: cursor = Void
		end

	execute_query
			-- Execute `query' with `last_query'.
		do
			if attached last_query_32 as l_query then
				query (l_query)
			end
		end

feature {NONE} -- Implementation

	implementation: DATABASE_SELECTION [DATABASE]
		-- Handle reference to specific database implementation

feature {NONE} -- Status report

	active_selection_number: INTEGER
			-- Rank of `Current' among concurrently open selections
		do
			Result := implementation.descriptor
		end

	update_map_table: BOOLEAN;
			-- Does `map_table' need to be updated?

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DB_SELECTION
