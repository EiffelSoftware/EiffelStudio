indexing
	description: "BINDPTR structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_BIND_PTR

inherit
	ECOM_STRUCTURE

creation
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	func_desc: ECOM_FUNC_DESC is
			-- FUNCDESC structure
		do
			create Result.make_from_pointer (ccom_bindptr_funcdesc (item))
		end

	var_desc: ECOM_VAR_DESC is
			-- VARDESC structure
		do
			create Result.make_from_pointer (ccom_bindptr_vardesc (item))
		end

	type_comp: ECOM_TYPE_COMP is
			-- ITypeComp interface
		do
			create Result.make_from_pointer (ccom_bindptr_itypecomp (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of BINDPTR structure
		do
			Result := c_size_of_bind_ptr
		end

feature {NONE} -- Externals

	c_size_of_bind_ptr: INTEGER is
		external 
			"C [macro %"E_bindptr.h%"]"
		alias
			"sizeof(BINDPTR)"
		end

	ccom_bindptr_funcdesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_bindptr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_bindptr_vardesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_bindptr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_bindptr_itypecomp (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_bindptr.h%"](EIF_POINTER): EIF_POINTER"
		end

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
end -- class ECOM_BIND_PTR

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

