indexing
	description: "Result structure of ECOM_TYPE_COMP.bind";
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_BIND_RESULT
	
inherit
	ECOM_DESC_KIND
	
feature -- Access

	type_info: ECOM_TYPE_INFO is
			-- Pointer to type description that contains 
			-- item to which it is bound
		require
			valid_desc_kind: desc_kind = Desckind_vardesc or
								desc_kind = Desckind_funcdesc
		do
			create Result.make_from_pointer (tinfo)
		end
		
	desc_kind: INTEGER
			-- Descriptor kind.
			-- See class ECOM_DESC_KIND for possible values.
		
	var_desc: ECOM_VAR_DESC is
			-- Bound VARDESC structure
		require
			valid_desc_kind: desc_kind = Desckind_vardesc
			valid_bind_ptr: is_bind_ptr_valid
		do
			Result := bind_ptr.var_desc
		end
		
	func_desc: ECOM_FUNC_DESC is
			-- Bound FUNCDESC structure
		require
			valid_desc_kind: desc_kind = Desckind_funcdesc
			valid_bind_ptr: is_bind_ptr_valid
		do
			Result := bind_ptr.func_desc
		end
		
	type_comp: ECOM_TYPE_COMP is
			-- Bound ITypeComp
		require
			valid_desc_kind: desc_kind = Desckind_typecomp
			valid_bind_ptr: is_bind_ptr_valid
		do
			Result := bind_ptr.type_comp
		end
			
feature -- Element Change

	set_type_info (tinf: POINTER) is
			-- Set `tinfo' with `tinf'.
			-- Should not be called (used by C-side).
		do
			tinfo := tinf
		end
		
	set_desc_kind (kind: INTEGER) is
			-- Set `desc_kind' with `kind'.
			-- Should not be called (used by C-side).
		require
			valid_kind: is_valid_desc_kind (kind)
		do
			desc_kind := kind
		end

	set_bind_ptr (ptr: POINTER) is
			-- Set `bind_ptr' with `ptr'.
			-- Should not be called (used by C-side).
		do
			create bind_ptr.make_from_pointer (ptr)
		end
	
feature -- Status report

	is_bind_ptr_valid: BOOLEAN is
			-- Is `bind_ptr' valid?
		do
			Result := bind_ptr /= Void
		end
	
feature {NONE} -- Implementation

	tinfo: POINTER
			-- ITypeInfo interface pointer
			
	bind_ptr: ECOM_BIND_PTR
			-- Bind structure
		
end -- class ECOM_BIND_RESULT

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

