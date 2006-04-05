indexing
	description: "COM FUNCDESC structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_FUNC_DESC

inherit
	ECOM_STRUCTURE
		redefine
			dispose
		end

	ECOM_FUNC_KIND
		undefine
			copy, is_equal
		end

	ECOM_INVOKE_KIND
		undefine
			copy, is_equal
		end

	ECOM_CALL_CONV
		undefine
			copy, is_equal
		end

	ECOM_FUNC_FLAGS
		undefine
			copy, is_equal
		end

creation
	make, make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	member_id: INTEGER is
			-- Function member ID
		do
			Result := ccom_funcdesc_memberid (item)
		end

	valid_scodes_count: INTEGER is
			-- Count of permitted return values
		do
			Result := ccom_funcdesc_scode_count (item)
		end

	valid_scodes: ARRAY [INTEGER] is
			-- Valid Scodes
		local 
			i, temp: INTEGER
		do
			!! Result.make (1, valid_scodes_count)
			from
				i := 1
			until
				i > valid_scodes_count
			loop
				temp := ccom_funcdesc_scode_i (item, i - 1)
				Result.put (temp, i)
				i := i + 1
			end
		end

	total_param_count: INTEGER is
			-- Count of total number of parameters
		do
			Result := ccom_funcdesc_param_count (item)
		end

	optional_param_count: INTEGER is
			-- Count of optional parameters
			-- Value of "0" specifies that no optional 
			-- arguments is supported
			-- Value of "-1" specifies that method's last 
			-- parameter is pointer to safe array of variants. 
			-- Any number indicates that last n parameters 
			-- of function are variants and do not need to 
			-- be specified by caller explicitly.
		do
			Result := ccom_funcdesc_opt_param_count (item)
		end

	parameters: ARRAY [ECOM_ELEM_DESC] is
			-- Parameters
		local
			i: INTEGER
			elem: ECOM_ELEM_DESC
		do
			!! Result.make (1, total_param_count)
			from
				i := 1
			until
				i > total_param_count
			loop
				!! elem.make_from_pointer (ccom_funcdesc_parameter_i (item, i -1))
				Result.put (elem, i)
				i := i + 1
			end
		end

	func_kind: INTEGER is
			-- Kind of function 
			-- See class ECOM_FUNC_KIND for return values
		do
			Result := ccom_funcdesc_funckind (item)
		ensure
			is_valid_func_kind (Result)
		end

	invoke_kind: INTEGER is
			-- Invokation kind
			-- See class ECOM_INVOKE_KIND for return values
		do
			Result := ccom_funcdesc_invokekind (item)
		ensure
			is_valid_invoke_kind (Result)
		end

	call_conv: INTEGER is
			-- Function's calling convention
		do
			Result := ccom_funcdesc_callconv (item)
		ensure
			is_valid_callconv (Result)
		end

	vtbl_offset: INTEGER is
			-- Offset in VTBL when `func_kind' is Func_virtual
		require
--			valid_func_kind: func_kind = Func_virtual or func_kind = Func_purevirtual
		do
			Result := ccom_funcdesc_vtbl_offset (item)
		end

	return_type: ECOM_ELEM_DESC is
			-- Return type
		do
			!! Result.make_from_pointer (ccom_funcdesc_return_type (item))
		end

	func_flags: INTEGER IS
			-- Associated flags
			-- See class ECOM_FUNC_FLAGS for return values
		do
			Result := ccom_funcdesc_func_flags (item)
		ensure
			is_valid_funcflag (Result)
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
			-- Size of 	FUNCDESCEX structure
		do
			Result := c_size_of_func_desc
		end

feature {NONE} -- Implementation

	dispose is
			-- `item' is freed by ECOM_TYPE_INFO.
		do
		end

feature {NONE} -- Externals

	c_size_of_func_desc: INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		alias
			"sizeof(FUNCDESC)"
		end

	ccom_funcdesc_memberid (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_funckind (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_invokekind (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_callconv (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_param_count (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_opt_param_count (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_vtbl_offset (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_scode_count (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_scode_i (a_ptr: POINTER; i: INTEGER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_parameter_i (a_ptr: POINTER; i: INTEGER): POINTER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_return_type (a_ptr: POINTER): POINTER is
		external 
			"C [macro %"E_funcdesc.h%"]"
		end

	ccom_funcdesc_func_flags (a_ptr: POINTER): INTEGER is
		external 
			"C [macro %"E_funcdesc.h%"]"
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
end -- class ECOM_FUNC_DESC

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

