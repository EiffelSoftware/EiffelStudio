indexing
	description: "Error when trying to load a file that is not an assembly."
	date: "$Date$"
	revision: "$Revision$"

class
	VD65

inherit
	LACE_ERROR

create
	make

feature {NONE} -- Initialization

	make (an_assembly: STRING) is
			-- Initialize new VD63 error instance.
		require
			an_assembly_not_void: an_assembly /= Void
			an_assembly_not_empty: not an_assembly.is_empty
		do
			assembly := an_assembly
		ensure
			assembly_set: assembly = an_assembly
		end
		
feature -- Access

	assembly: STRING
			-- Name of missing assembly.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Print out error message.
		do
			st.add_string ("Assembly `")
			st.add_string (assembly)
			st.add_string ("' could not be loaded from disk.")
			st.add_new_line
		end

invariant
	assembly_valid: assembly /= Void and then not assembly.is_empty

end -- class VD65
