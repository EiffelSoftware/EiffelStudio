indexing
	description: "COM VARDESC structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_VAR_DESC

inherit
	ECOM_STRUCTURE
		redefine
			dispose
		end

	ECOM_VAR_FLAGS
		undefine
			copy, is_equal
		end

	ECOM_VAR_KIND
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

	member_id: INTEGER is
			-- Member identifier
		do
			Result := ccom_vardesc_memid (item)
		end

	instance_offset: INTEGER is
			-- Offset of this variable within instance
			-- `varkind' must be `Var_perinstance'.
		require
			valid_var_kind: var_kind = Var_perinstance
		do
			Result := ccom_vardesc_offset (item)
		end

	constant_variant: ECOM_VARIANT is
			-- Value of the constant
			-- `varkind' must be `Var_const'.
		require
			valid_var_kind: var_kind = Var_const
		do
			!! Result.make_from_pointer (ccom_vardesc_const_variant (item))
		end

	elem_desc: ECOM_ELEM_DESC is
			-- Corresponding ELEMDESC structure
		do
			!! Result.make_from_pointer (ccom_vardesc_elemdesc (item))
		end

	var_flags: INTEGER is
			-- Flags
			-- See ECOM_VAR_FLAGS for returnvalue
		do
			Result := ccom_vardesc_var_flags (item)
		ensure
			valid_varflags: is_valid_varflag (Result)
		end

	var_kind: INTEGER is
			-- Kind of variable
			-- See ECOM_VAR_KIND for return value
		do
			Result := ccom_vardesc_var_kind (item)
		ensure
			valid_result: is_valid_var_kind (Result)
		end

feature -- Status report

	parent: ECOM_TYPE_INFO
			-- ITypeInfo inteface that returned structure

	is_parent_valid: BOOLEAN
			-- Is `parent' attribute valid?

feature -- Status setting

	set_parent (a_parent: ECOM_TYPE_INFO) is
			-- Set `parent attribute.
		do
			parent := a_parent
			is_parent_valid := true
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARDESC structure
		do
			Result := c_size_of_var_desc
		end

feature {NONE} -- Implementation

	dispose is
			-- `item' is freed by ECOM_TYPE_INFO.
		do
		end

feature {NONE} -- Externals

	c_size_of_var_desc: INTEGER is
		external 
			"C [macro %"E_vardesc.h%"]"
		alias
			"sizeof(VARDESC)"
		end

	ccom_vardesc_memid (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_vardesc_offset (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_vardesc_const_variant (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_vardesc_elemdesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_vardesc_var_flags (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_vardesc_var_kind (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_vardesc.h%"](EIF_POINTER): EIF_INTEGER"
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
end -- class ECOM_VAR_DESC

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

