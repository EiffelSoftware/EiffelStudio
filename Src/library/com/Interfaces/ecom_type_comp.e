indexing
	description: "Objects that ..."
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_COMP

inherit
	ECOM_INTERFACE

	ECOM_INVOKE_KIND

creation
	make_from_pointer


feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	bind (a_name: STRING; flags: INTEGER): ECOM_BIND_RESULT is
			-- Maps `name' to member of type
			-- See class ECOM_INVOKE_KIND foe `flags' values
		require
			valid_flags: is_valid_invoke_kind (flags) or flags = 0
		do
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_c_type_comp_from_pointer (a_pointer)
		end

	release_interface is
			-- Delete structure
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


invariant
	invariant_clause: -- Your invariant here

end -- class ECOM_TYPE_COMP
