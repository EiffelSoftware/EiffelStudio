indexing
	description: "Error when trying to intialize alternative specified assembly metadata cache path."
	date: "$Date$"
	revision: "$Revision$"

class
	VD67

inherit
	LACE_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_path: STRING) is
			-- Initialize new VD67 error instance.
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			path := a_path
		ensure
			path_set: path = a_path
		end
		
feature -- Access

	path: STRING
			-- Path to metadata cache.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Print out error message.
		do
			st.add_string ("Path `")
			st.add_string (path)
			st.add_string ("' could not be found on disk.")
			st.add_new_line
		end

invariant
	path_valid: path /= Void and then not path.is_empty

end -- class VD67
