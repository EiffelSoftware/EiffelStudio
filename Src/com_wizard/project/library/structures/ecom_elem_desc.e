indexing
	description: "COM ELEMDESC structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ELEM_DESC

inherit
	ECOM_STRUCTURE

creation
	make, make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	type_desc: ECOM_TYPE_DESC is
			-- TYPEDESC structure
		do
			!! Result.make_from_pointer (ccom_elemdesc_typedesc (item))
		end

	idl_desc: ECOM_IDL_DESC is
			-- IDLDESC structure
		do
			!! Result.make_from_pointer (ccom_elemdesc_idldesc (item))
		end

	param_desc: ECOM_PARAM_DESC is
			-- PARAMDESC structure
		do
			!! Result.make_from_pointer (ccom_elemdesc_paramdesc (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of ELEMDESC structure
		do
			Result := c_size_of_elem_desc
		end

feature {NONE} -- Externals

	c_size_of_elem_desc: INTEGER is
		external 
			"C [macro %"E_elemdesc.h%"]"
		alias
			"sizeof(ELEMDESC)"
		end

	ccom_elemdesc_typedesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_elemdesc.h%"]"
		end

	ccom_elemdesc_idldesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_elemdesc.h%"]"
		end

	ccom_elemdesc_paramdesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_elemdesc.h%"]"
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
end -- class ECOM_PARAM_DESC

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

