indexing
	description: "COM generic interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_GENERIC_INTERFACE

inherit
	ECOM_WRAPPER
		redefine 
			make_from_pointer
		end

create
	make_from_pointer,
	make_from_other

feature -- Initialization

	make_from_pointer (other_pointer: POINTER) is
			-- Create interface from other interface pointer.
		local
			retried: BOOLEAN
		do
			if not retried then
				initializer := create_wrapper (other_pointer)
				item := ccom_item (initializer)
				ok := True
			end
		rescue
			ok := False
			retried := True
			retry
		end

	make_from_other (other: ECOM_GENERIC_INTERFACE) is
			-- Create interface from other interface.
		do
			make_from_pointer (other.item)
		end

feature -- Access

	ok: BOOLEAN
			-- Does creation rutine succeeded?

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


invariant
	invariant_clause: -- Your invariant here

end -- class ECOM_GENERIC_INTERFACE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

