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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

