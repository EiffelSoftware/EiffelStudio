indexing
	description: "TYPEDESC structure, contained within TYPEATTR structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_DESC

inherit
	ECOM_STRUCTURE

	ECOM_VAR_TYPE
		undefine
			copy, is_equal
		end

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

	var_type: INTEGER is
			-- Type
			-- See class ECOM_VAR_TYPE for Result values.
		do
			Result := c_typedesc_vartype (item)
		end

	type_desc: ECOM_TYPE_DESC is
			-- Nested TYPEDESC structure
			-- that specifies safearray element type
		require
			valid_type: is_ptr (var_type) or is_safearray (var_type)
		do
			!! Result.make_from_pointer (c_typedesc_typedesc (item))
		end

	array_desc: ECOM_ARRAY_DESC is
			-- Nested ARRAYDESC structure
		require
			valid_type: is_carray (var_type)
		local
			l_pointer: POINTER
		do
			l_pointer := c_typedesc_arraydesc (item)
			if l_pointer /= default_pointer then
				create Result.make_from_pointer (l_pointer)
			end
		end

	href_type: NATURAL_32 is
			-- Handle to type description
		require
			valid_type: is_user_defined (var_type)
		do
			Result := c_typedesc_href_type (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of TYPEDESC structure
		do
			Result := c_size_of_type_desc
		end

feature {NONE} -- Externals

	c_size_of_type_desc: INTEGER is
		external
			"C [macro %"windows.h%"]"
		alias
			"sizeof(TYPEDESC)"
		end

	c_typedesc_vartype (a_ptr: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"((TYPEDESC*)$a_ptr)->vt"
		end

	c_typedesc_typedesc (a_ptr: POINTER): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"((TYPEDESC*)$a_ptr)->lptdesc"
		end

	c_typedesc_arraydesc (a_ptr: POINTER): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"((TYPEDESC*)$a_ptr)->lpadesc"
		end

	c_typedesc_href_type (a_ptr: POINTER): NATURAL_32 is
		external
			"C inline use <windows.h>"
		alias
			"((TYPEDESC*)$a_ptr)->hreftype"
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
end -- class ECOM_TYPE_DESC

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

