indexing
	description: "Generic class derivation"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	GENERIC_DERIVATION

create
	make

feature {NONE} -- Initialization

	make (derivation_count: INTEGER) is
		indexing
			description: "Initialize `generic_types' with `derivation_count' elements."
		require
			valid_count: derivation_count > 0
		do
			create generic_types.make (0, derivation_count)
		ensure
			non_void_generic_types: generic_types /= Void
		end

feature -- Access

	generic_types: ARRAY [SIGNATURE_TYPE]
		indexing
			description: "Generic types"
		end
	
feature -- Basic Operations

	add_derivation_type (a_type: SIGNATURE_TYPE) is
		indexing
			description: "Add `a_type' to `generic_types'. "
		require
			non_void_type: a_type /= Void
		do
			generic_types.put (a_type, generic_types.count)
		ensure
			derivation_added: generic_types.count = old generic_types.count + 1
		end

invariant
	non_void_generic_types: generic_types /= Void

end -- class GENERIC_DERIVATION
