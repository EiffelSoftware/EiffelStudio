class MT_INDEX

inherit 

	MT_STREAMABLE

	MT_INDEX_EXTERNAL

Creation 

	make

feature {NONE} -- Initilization

	make(arg_name : STRING) is
		-- Get index from name
		require
			arg_name_not_void : arg_name /= Void
			arg_name_not_empty : not arg_name.empty
		local
			c_index_name : ANY
		do	
			name := Clone(arg_name)
			c_index_name := name.to_c
			iid := c_get_index($c_index_name)
		end -- make

feature -- Status Report

	entries_count : INTEGER is 
		-- The number of entries in the index
		-- Not implemented
		do
		end -- entries_count

	size : INTEGER is
		-- The number of criteria
		-- Not implemented
		do
		end -- size

feature -- Access
	
	next_entry : MT_OBJECT is
		-- Next object in index
		do
			Result ?= next_object
		end -- next_entry

	criteria : ARRAY[MT_INDEX_CRITERION] is
		-- Criterions of current index
		-- Not implemented
		do
		end -- criteria

feature {NONE} -- Implementation

	name : STRING -- Name of Index

	iid : INTEGER -- Identifier in database
	
	stream : MT_INDEX_STREAM
		-- Stream of objects in Index

invariant
	
	consistent_criteria : criteria.count = size

end -- class MT_INDEX
