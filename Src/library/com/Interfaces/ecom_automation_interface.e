indexing
	description: "Automation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_AUTOMATION_INTERFACE

inherit
	ECOM_QUERIABLE

creation
	make_from_pointer,
	make_from_other

feature -- Initialization

	make_from_pointer (other_pointer: POINTER) is
			-- Create interface from other interface pointer
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
			"C++ [new E_automation_interface %"E_automation_interface.h%"](IDispatch *)"
		end

	ccom_delete_wrapper (cpp_obj: POINTER) is
		external
			"C++  [delete E_automation_interface %"E_automation_interface.h%"]()"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_automation_interface %"E_automation_interface.h%"]():EIF_POINTER"
		end
end -- class ECOM_AUTOMATION_INTERFACE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

