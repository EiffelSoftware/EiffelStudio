indexing

	description: "FUNCDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_FUNC_DESC

inherit
	EOLE_OBJECT_WITH_POINTER
	
	EOLE_CALL_CONV
	
	EOLE_FUNC_FLAGS

	EOLE_FUNC_KIND

	EOLE_INVOKE_KIND

feature -- Access

	member_id: INTEGER is
			-- Function member ID
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_member_id (ole_ptr)
		end

	valid_scodes_count: INTEGER is
			-- Count of permitted return values
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_valid_scodes_count (ole_ptr)
		end

	valid_scode (pos: INTEGER): INTEGER is
			-- Scode at `pos'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_valid_scode (ole_ptr, pos)
		end

	param_count: INTEGER is
			-- Number of total arguments
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_param_count (ole_ptr)
		end

	optional_param_count: INTEGER is
			-- Number of optional arguments
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_optional_param_count (ole_ptr)
		end

	parameter (pos: INTEGER): EOLE_ELEM_DESC is
			-- Argument at `pos'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_get_fd_parameter (ole_ptr, pos))
		end

	func_kind: INTEGER is
			-- Type of function
			-- See class EOLE_FUNCKIND for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_funckind (ole_ptr)
		ensure
			valid_funckind: is_valid_func_kind (Result)
		end

	invoke_kind: INTEGER is
			-- Invocation style
			-- See class EOLE_INVOKEKIND for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_invokekind (ole_ptr)
		ensure
			valid_invokekind: is_valid_invoke_kind (Result)
		end

	call_conv: INTEGER is
			-- Function's calling convention    
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_callconv (ole_ptr)
		ensure
			valid_calling_convention: is_valid_callconv (Result)
		end

	vtbl_offset: INTEGER is
			-- Offset in VTBL when `funckind' is Func_virtual
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_func_kind: func_kind = Func_virtual
		do
			Result := ole2_get_fd_vtbl_offset (ole_ptr)
		end

	return_type: EOLE_ELEM_DESC is
			-- Return type
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_get_fd_return_type (ole_ptr))
		end

	func_flags: INTEGER is
			-- Associated flags
			-- See class EOLE_FUNCFLAGS for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_get_fd_func_flags (ole_ptr)
		ensure
			valid_funcflag: is_valid_funcflag (Result)
		end

feature {NONE} -- Externals

	ole2_get_fd_member_id (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_member_id"
		end

	ole2_get_fd_valid_scodes_count (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_valid_scodes_count"
		end

	ole2_get_fd_valid_scode (this: POINTER; pos: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_valid_scode"
		end

	ole2_get_fd_param_count (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_param_count"
		end

	ole2_get_fd_optional_param_count (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_optional_param_count"
		end

	ole2_get_fd_parameter (this: POINTER; pos: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_get_fd_parameter"
		end

	ole2_get_fd_funckind (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_funckind"
		end

	ole2_get_fd_invokekind (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_invokekind"
		end

	ole2_get_fd_callconv (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_callconv"
		end

	ole2_get_fd_vtbl_offset (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_vtbl_offset"
		end

	ole2_get_fd_return_type (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_get_fd_return_type"
		end

	ole2_get_fd_func_flags (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_get_fd_func_flags"
		end
		
end -- class EOLE_FUNC_DESC

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

