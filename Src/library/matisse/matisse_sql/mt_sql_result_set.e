indexing
	description: "Represent the result of an SQL statement";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_SQL_RESULT_SET

inherit
	MT_SQL_EXTERNAL
		export 
			{NONE} all
		end
		
creation
	make, make_from_selection

feature -- Initialization

	make (sel_id: INTEGER) is
		do
			selection_id := sel_id
			set_selection_name
		end

	make_from_selection (a_selection_name: STRING) is
			-- This initializes the SQL result from a valid named selection.
		local
			to_c: ANY
		do
			to_c := a_selection_name.to_c
			selection_id := c_sql_get_selection ($to_c)
			selection_name := clone (a_selection_name)
		end

feature -- Access

	item, object: MT_STORABLE is
			-- This function returns the current object available through the
			-- SQL result selection.
		require
			not_off: not off
		do
			Result := selection_stream.item
		end		

	selection_name: STRING

feature -- Cursor movement

	start is
			-- This procedure initializes the internal selection stream to access
			-- the objects available through the SQL result selection.
		do
			!! selection_stream.make (selection_id)
			selection_stream.start
		end

	
	forth is
			-- This procedure moves current cursor to the next object
			-- available through the SQL result selection.
		require
			not_off: not off
		do
			selection_stream.forth
		end
	
feature -- Status

	close is
			-- This procedure closes the SQL result selection if it is not named. 
			-- The closed SQL result selection cannot be used anymore.
		require
			started: started
		do
			selection_stream.close
			selection_stream := Void
			if selection_name.is_equal ("") then
				free_selection
			end
		end

	free_selection is
			-- This procedure frees a named selection result. When it has been
			-- called, you cannnot anymore access the selection with a new
			-- MT_SQL_RESULT_SET.
			-- A named selection can be created with the keyword INTO in a
			-- SELECT statement.
		require
			stream_closed: not started
		do
			c_sql_free_selection (selection_id)
		end

feature -- Status report

	off: BOOLEAN is
			-- Is there no current object?
		do
			Result := selection_stream = Void or else exhausted
		end

	exhausted: BOOLEAN is
			-- This function tests whether or not the end of the cursor
			-- has been reached.
		require
			started: started
		do
			Result := selection_stream.exhausted
		end

	started: BOOLEAN is
		do
			Result := selection_stream /= Void 
		end

feature -- Measurement

	count, instance_number: INTEGER is
			-- This function returns the number of objects contained in the
			-- SQL result selection.
		do
			Result := c_sql_get_instance_number (selection_id)
		end

feature {NONE}

	selection_id: INTEGER
		
	selection_stream: MT_SELECTION_STREAM

	set_selection_name is
			-- This procedure gets the name of the SQL result selection.
			-- If it is not named, an mepty string is set.
		local
			c_string: POINTER
		do
			!! selection_name.make (0)
			c_string := c_get_selection_name (selection_id)
			if c_string = default_pointer then
				selection_name := ""
			else
				selection_name.from_c (c_string)
			end
		end

invariant

	selection_name_not_void: selection_name /= Void

end -- class MT_SQL_RESULT_SET
