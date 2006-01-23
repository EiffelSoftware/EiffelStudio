indexing
	description: "Implemented `IEnumUnknown' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IENUM_UNKNOWN_IMPL_STUB

inherit
	IENUM_UNKNOWN_INTERFACE
	
	IENUM_IMPL [ECOM_INTERFACE]

	ECOM_STUB

create
	make
	
feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IENUM_UNKNOWN_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IEnumUnknown_impl_stub %"ecom_control_library_ienumunknown_impl_stub_s.h%"](EIF_OBJECT)"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IENUM_UNKNOWN_IMPL_STUB

