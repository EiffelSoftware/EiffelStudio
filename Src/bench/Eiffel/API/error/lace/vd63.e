indexing
	description: "Error when assembly is not found."
	date: "$Date$"
	revision: "$Revision$"

class
	VD63

inherit
	LACE_ERROR
	
create
	make

feature {NONE} -- Initialization

	make (an_assembly, a_path: STRING) is
			-- Initialize new VD63 error instance.
		require
			an_assembly_not_void: an_assembly /= Void
			an_assembly_not_empty: not an_assembly.is_empty
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			assembly := an_assembly
			path := a_path
		ensure
			assembly_set: assembly = an_assembly
			path_set: path = a_path
		end
		
feature -- Access

	assembly: STRING
			-- Name of missing assembly.
			
	path: STRING
			-- Path of missing assembly.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Print out error message.
		do
			st.add_string ("Assembly `")
			st.add_string (assembly)
			st.add_string ("' could not be loaded from disk.")
			st.add_new_line
			st.add_string ("Assembly path: ")
			st.add_string (path)
			st.add_new_line
		end

invariant
	assembly_valid: assembly /= Void and then not assembly.is_empty
	path_valid: path /= Void and then not path.is_empty

end