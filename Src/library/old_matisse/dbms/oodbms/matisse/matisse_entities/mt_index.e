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

