indexing
	description: "Implemented `IEnumCluster' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_EXCLUDES_ENUMERATOR

inherit
	IENUM_CLUSTER_EXCLUDES_INTERFACE

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
			"C++ [new ecom_eiffel_compiler::IEnumClusterExcludes_impl_stub %"ecom_eiffel_compiler_IEnumClusterExcludes_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- class CLUSTER_EXCLUDES_ENUMERATOR
