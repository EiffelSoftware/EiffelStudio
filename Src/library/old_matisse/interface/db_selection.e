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
			!! ht.make (name_table_size)
			implementation := handle.database.db_selection_i
			implementation.set_ht (ht)
		end

feature -- Status report

	container: LINKED_LIST [DB_RESULT]
			-- Stored cursors

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

	exhausted: BOOLEAN is
			-- Is there any more resulting row?
		do
			Result := handle.status.found
		end

	is_allocatable: BOOLEAN is
			-- Can `Current' be added to other concurrently opened selections?
		do
			Result := implementation.descriptor_available	
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
		require
			reference_exists: reference /= Void
		do
			if object = Void or else
				dynamic_type (reference) /= dynamic_type (object) then
				update_map_table := true
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
			if update_map_table then
				cursor.update_map_table (object)
				update_map_table := False
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
			cursor := container.item
		ensure then
			container_index_moved: container.index = old container.index + 1
			cursor_updated: cursor = container.item
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

feature -- Basic operations

    load_result is
            -- Iterate through selection results,
            -- load `container' if requested and call action routine
            -- for each iteration step until `exit_condition' is met.
        require
            connected: is_connected
            is_ok: is_ok 
		local
			i : INTEGER
        do
            from
                if cursor = Void then
                    !! cursor.make 
                    cursor.set_descriptor (active_selection_number) 
                end
                if not handle.status.found then
                cursor.fill_in 
                end
                if stop_condition /= Void then
                    stop_condition.start
                end 
            until
                is_exiting
            loop
                if container /= Void then
                    container.extend(cursor)
                    !! cursor.make
                    cursor.set_descriptor (active_selection_number)
                end
                if stop_condition /= Void then
                    stop_condition.execute
                end
                next
                cursor.fill_in
            end
            implementation.terminate
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
			argument_is_not_empty: not s.empty
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
			container_is_empty: container /= Void implies container.empty
			object_model_void: object = Void
			cursor_void: cursor = Void
		end

	execute_query is
			-- Execute `query' with `last_query'.
		do
			query (last_query)
		end

feature {NONE} -- Implementation

	implementation: DB_SELECTION_I
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

	--last_cursor_in_container: 
	--	container /= Void and then not container.empty 
	--							implies container.has (cursor)

end -- class DB_SELECTION


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

