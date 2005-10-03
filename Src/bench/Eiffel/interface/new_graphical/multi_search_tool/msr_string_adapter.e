indexing
	description: "String adapter, gives a fast way to change a_string for the objects that refer current one."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_STRING_ADAPTER

create
	
	make
	
feature -- Initialization

	make (a_string: STRING) is
			-- Make with a_string
		require
			a_string /= Void
		do
			real_string := a_string	
		end
		
feature -- Element change

	set_real_string (a_string: STRING) is
			-- Set `real_string'
		require
			a_string /= Void
		do
			real_string := a_string
		end
		

feature -- Access

	real_string : STRING
		-- Real string adapted
		
invariant
	
	real_string_not_void: real_string /= Void

end
