indexing
	description: "Result structure of ECOM_TYPE_COMP.bind"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
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
			
	bind_ptr: ECOM_BIND_PTR;
			-- Bind structure
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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

