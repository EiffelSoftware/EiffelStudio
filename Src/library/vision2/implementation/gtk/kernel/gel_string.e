indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GEL_STRING

inherit
	MEMORY
		redefine
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			a: ANY
			nb: INTEGER
			a_default_pointer: POINTER
		do
			nb := a_string.count
			item := a_default_pointer.memory_alloc (nb + 1)
			if item = default_pointer then
				--| FIXME Raise exception
			end
			a := a_string.to_c
			item.memory_copy ($a, nb + 1)
		end
		
feature -- Access
		
	item: POINTER
	
feature {NONE} -- Implementation

	dispose is
			-- 
		do
			item.memory_free
		end	

end -- class GEL_STRING
