indexing
	description: "[
		Error when an assembly refers to another assembly which is not
		listed in the Ace file.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	VD60

inherit
	LACE_ERROR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly; a_referred_assembly: like referred_assembly) is
			-- Create VD60 error using data from `an_assembly' and `a_referred_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
			a_referred_assembly_not_void: a_referred_assembly /= Void
		do
			assembly := an_assembly
			referred_assembly := a_referred_assembly
		ensure
			assembly_set: assembly = an_assembly
			referred_assembly_set: referred_assembly = a_referred_assembly
		end

feature {NONE} -- Properties

	assembly: ASSEMBLY_I
			-- Assembly which refer to `referred_assembly' which is unknown.

	referred_assembly: CONSUMED_ASSEMBLY
			-- Referred assembly from `assembly' that is unknown in system.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Assembly: ")
			st.add_string (assembly.cluster_name)
			st.add_new_line
			st.add_string ("Referred assembly: ")
			st.add_string (referred_assembly.out)
			st.add_new_line
		end

invariant
	assembly_not_void: assembly /= Void
	referred_assembly_not_void: referred_assembly /= Void

end -- class VD60
