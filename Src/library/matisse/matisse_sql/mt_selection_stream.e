indexing
	description: "Eiffel-MATISSE Binding";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_SELECTION_STREAM

inherit
	MT_STREAM
	
	MT_SQL_EXTERNAL
	
creation
	make

feature -- Initialization

	make (selection_id: INTEGER) is
			-- Open stream.
			-- sql_result is of type MtSQLResult
		do
			c_stream := c_open_selection_stream (selection_id)
		end

end -- class MT_SELECTION_STREAM
