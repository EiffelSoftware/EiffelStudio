indexing
	description: "[
		Error when XML representation of a class that belongs to an assembly
		is missing from the Eiffel assembly cache.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	VD62

inherit
	LACE_ERROR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly; a_class: like external_class) is
			-- Create VD62 error using data from `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
			a_class_not_void: a_class /= Void
		do
			assembly := an_assembly
			external_class := a_class	
		ensure
			assembly_set: assembly = an_assembly
			external_class_set: external_class = a_class
		end

feature {NONE} -- Properties

	assembly: ASSEMBLY_I
			-- Assembly which refer to `referred_assembly' which is unknown.

	external_class: EXTERNAL_CLASS_I
			-- External class whose XML file representation is missing.

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
			st.add_string ("Missing file: ")
			st.add_string (external_class.file_name)
			st.add_new_line
		end

invariant
	assembly_not_void: assembly /= Void
	external_class_not_void: external_class /= Void

end -- class VD62
