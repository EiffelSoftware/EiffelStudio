indexing
	description: "Implemented `IEnumIncludePaths' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	INCLUDE_PATHS_ENUMERATOR

inherit
	IENUM_INCLUDE_PATHS_INTERFACE

	ECOM_STUB

	IENUM_STUB [STRING]

create 
	make

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: like Current): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEnumImportedAssemblies_impl_stub %"ecom_eiffel_compiler_IEnumImportedAssemblies_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- class INCLUDE_PATHS_ENUMERATOR
