indexing
	description	: "[
		Warning when user selected to use ompitimized version of a precompiled library,
		but precompiled library has not been optimized.
		]"
	definition: "VIOP = Optimized Precompiled library has not be created"
	date: "$Date$"
	revision: "$Revision$"

class
	VIOP

inherit
	WARNING

create
	make

feature {NONE} -- Initialization
	
	make (a_path: STRING) is
			-- create warning with path to directory `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			precompiled_path := a_path.twin
		ensure
			precompiled_path_set: a_path.is_equal (precompiled_path)
		end
		

feature -- Properties

	code: STRING is "VIOP"
		-- Error code
		
	precompiled_path: STRING
		-- Path to precompiled library
		
	file_name: STRING is
			-- No associated file name
		do
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- No need for an error message.
		do
			st.add_string ("Precompiled Library: ")
			st.add_string (precompiled_path)
			st.add_new_line
		end

invariant
	non_void_precompiled_path: precompiled_path /= Void
	valid_precompiled_path: not precompiled_path.is_empty

end -- class VIOP
