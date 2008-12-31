note
	description: "COM TLIBATTR structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TLIB_ATTR

inherit
	ECOM_STRUCTURE

	ECOM_SYS_KIND
		undefine
			copy, is_equal
		end

	ECOM_LIB_FLAGS
		undefine
			copy, is_equal
		end

create
	make, make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	guid: ECOM_GUID
			-- Unique ID of the library
		do
			create Result.make_from_pointer (ccom_tlibattr_guid (item))
		end

	lcid: INTEGER
			-- Language/locale of the library.
		do
			Result := ccom_tlibattr_lcid (item)
		end

	SYS_kind: INTEGER
			-- Target hardware platform
			-- See class ECOM_SYS_KIND for possible return values.
		do
			Result := ccom_tlibattr_sys_kind (item)
		ensure
			is_valid_sys_kind (Result)
		end

	flags: INTEGER
			-- Library flags.
			-- See class ECOM_LIB_FLAGS for possible return values.
		do
			Result := ccom_tlibattr_tlib_flags (item)
		ensure
			is_valid_lib_flag (Result)
		end

	major_version_number: INTEGER
			-- Major version number
		do
			Result := ccom_tlibattr_major_vernum (item)
		end

	minor_version_number: INTEGER
			-- Minor version number
		do
			Result := ccom_tlibattr_minor_vernum (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of TLIBATTR structure
		do
			Result := c_size_of_tlib_attr 
		end

feature {NONE} -- Externals

	c_size_of_tlib_attr: INTEGER
		external 
			"C [macro %"E_tlib_attr.h%"]"
		alias
			"sizeof(TLIBATTR)"
		end

	ccom_tlibattr_guid (a_ptr: POINTER): POINTER
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_tlibattr_lcid (a_ptr: POINTER): INTEGER
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_sys_kind (a_ptr: POINTER): INTEGER
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_tlib_flags (a_ptr: POINTER): INTEGER
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_major_vernum (a_ptr: POINTER): INTEGER
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_minor_vernum (a_ptr: POINTER): INTEGER
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	
note
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
end -- class ECOM_TLIB_ATTR


