indexing
	description: "Implemented `IEnumAssemblyr' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_ENUMERATOR

inherit
	IENUM_ASSEMBLY_INTERFACE

	ECOM_STUB

	IENUM_STUB [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE]


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
			"C++ [new ecom_eiffel_compiler::IEnumAssembly_impl_stub %"ecom_eiffel_compiler_IEnumAssembly_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- class ASSEMBLY_ENUMERATOR
