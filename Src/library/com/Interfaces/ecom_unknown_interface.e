indexing
	description: "COM generic interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_UNKNOWN_INTERFACE

inherit
	ECOM_QUERIABLE

create
	make_from_pointer,
	make_from_other

feature -- Initialization

	make_from_pointer (other_pointer: POINTER) is
			-- Create interface from other interface pointer.
		do
			initializer := create_wrapper (other_pointer)
			item := ccom_item (initializer)
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create C++ wrapper
		do
			Result := ccom_create_wrapper (a_pointer)
		end

	delete_wrapper is
			-- Delete C++ wrapper
		do
			ccom_delete_wrapper (initializer)
		end

feature {NONE} -- External

	ccom_create_wrapper (a_interface_ptr: POINTER): POINTER is
		external
			"C++ [new E_generic_interface %"E_generic_interface.h%"](IUnknown *)"
		end

	ccom_delete_wrapper (cpp_obj: POINTER) is
		external
			"C++ [delete E_generic_interface %"E_generic_interface.h%"]()"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_generic_interface %"E_generic_interface.h%"](): EIF_POINTER"
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




end -- class ECOM_UNKNOWN_INTERFACE

