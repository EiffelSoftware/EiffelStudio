indexing
	description: "[
		Error when Ace file refers to an assembly which is not
		generated.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	VD61

inherit
	LACE_ERROR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly) is
			-- Create VD61 error using data from `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		do
			assembly := an_assembly
		ensure
			assembly_set: assembly = an_assembly
		end

feature {NONE} -- Properties

	assembly: ASSEMBLY_I
			-- Assembly which refer to `referred_assembly' which is unknown.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Assembly cluster name: ")
			st.add_string (assembly.cluster_name)
			st.add_new_line
			st.add_string ("Assembly details: %"")
			assembly.format (st)
			st.add_string ("%"")
			st.add_new_line
		end

invariant
	assembly_not_void: assembly /= Void

end -- class VD61