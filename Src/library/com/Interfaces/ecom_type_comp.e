indexing
	description: "Encapsulation of standard implementation of ITypeComp interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_COMP

inherit
	ECOM_WRAPPER

	ECOM_INVOKE_KIND

creation
	make_from_pointer

feature -- Basic operations

	bind (a_name: STRING; flags: INTEGER): ECOM_BIND_RESULT is
			-- Maps `name' to member of type.
			-- See class ECOM_INVOKE_KIND for `flags' values.
		require
			valid_flags: is_valid_invoke_kind (flags) or flags = 0
		do
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create interface.
		do
			Result := ccom_create_c_type_comp_from_pointer (a_pointer)
		end

	delete_wrapper is
			-- Delete structure.
		do
			ccom_delete_c_type_comp (initializer);
		end

feature {NONE} -- Externals

	ccom_create_c_type_comp_from_pointer (a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IType_Comp %"E_ITypeComp.h%"](ITypeComp *)"
		end

	ccom_delete_c_type_comp (cpp_obj: POINTER) is
		external
			"C++ [delete E_IType_Comp %"E_ITypeComp.h%"]()"
		end

end -- class ECOM_TYPE_COMP

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