indexing

	description: "METHODDATA structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_METHODDATA

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate,
			destroy
		end
	
	EOLE_METHOD_FLAGS
	
	EOLE_CALLCONV
	
feature -- Element change

	allocate: POINTER is
			-- Create associated C++ structure with
			-- an array of EOLE_PARAMDATA structure 
			-- of size `size'.
			-- `set_size' should be called first.
		do
			Result := ole2_methoddata_allocate (size)
		end

	set_size (siz: INTEGER) is
			-- Set `size' with `siz'
		do
			size := siz
		end
		
	destroy is
			-- Destroy associated C++ structure.
		do
			ole2_methoddata_destroy (ole_ptr)
		end
		
	set_method_name (s: STRING) is
			-- Set method name with `s'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_method_name: s /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (s)
			ole2_methoddata_set_method_name (ole_ptr, wel_string.item)
		ensure
			method_name_set: method_name.is_equal (s)
		end

	set_dispid (dspid: INTEGER) is
			-- Set Dispatch identifier with `dispid'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_methoddata_set_dispid (ole_ptr, dspid)
		ensure
			dispid_set: dispid = dspid
		end

	set_method_index (ind: INTEGER) is
			-- Set method index with `index'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_methoddata_set_method_index (ole_ptr, ind)
		ensure
			method_index_set: method_index = ind
		end

	set_calling_convention (convention: INTEGER) is
			-- Set calling convention with `convention'.
			-- See class EOLE_CALLCONV for `convention' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_calling_convention: is_valid_callconv (convention)
		do
			ole2_methoddata_set_calling_convention (ole_ptr, convention)
		ensure
			calling_convention_set: calling_convention = convention
		end

	set_method_flag (flag: INTEGER) is
			-- Set method flag with `flag'.
			-- See class EOLE_METHODFLAGS for `flag' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_method_flag: is_valid_method_flag (flag)
		do
			ole2_methoddata_set_method_flags (ole_ptr, flag)
		ensure
			method_flag_set: method_flag = flag
		end

	set_return_type (vartype: INTEGER) is
			-- Set return type with `vartype'.
			-- See class EOLE_VARTYPE for `vartype' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_methoddata_set_return_type (ole_ptr, vartype)
		ensure
			return_type_set: return_type = vartype
		end

	add_param_data (par_data: EOLE_PARAMDATA) is
			-- Add `param_data' at next available position.
		require
			valid_c_structure: ole_ptr /= default_pointer
			not_full: index <= size
		do
			ole2_methoddata_add_param_data (ole_ptr, par_data.ole_ptr, index)
			index := index + 1
		end

	put_param_data (ind: INTEGER; par_data: EOLE_PARAMDATA) is
			-- Put `param_data' at zero-based `ind'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_index: ind <= size
		do
			ole2_methoddata_put_param_data (ole_ptr, ind, par_data.ole_ptr)
		end	
		
feature -- Access

	param_data (ind: INTEGER): EOLE_PARAMDATA is
			-- Argument at zero-based `ind'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_methoddata_get_param_data (ole_ptr, ind))
		end

	method_name: STRING is
			-- Method name
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result.make (0)
			Result.from_c (ole2_methoddata_get_method_name (ole_ptr))
		end

	dispid: INTEGER is
			-- Dispatch identifier of method
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_methoddata_get_dispid (ole_ptr)
		end

	method_index: INTEGER is
			-- Method index
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_methoddata_get_method_index (ole_ptr)
		end

	calling_convention: INTEGER is
			-- Calling convention for method
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_methoddata_get_calling_convention (ole_ptr)
		ensure
			valid_calling_convention: is_valid_callconv (Result)
		end

	arg_count: INTEGER is
			-- Number of arguments
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_methoddata_get_arg_count (ole_ptr)
		end

	method_flag: INTEGER is
			-- Method flag
			-- See class EOLE_METHODFLAGS for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_methoddata_get_method_flags (ole_ptr)
		ensure
			valid_method_flag: is_valid_method_flag (Result)
		end

	return_type: INTEGER is
			-- Return type
			-- See class EOLE_VARTYPE for `Result' value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_methoddata_get_return_type (ole_ptr)
		end
	
	size: INTEGER
			-- Size of EOLE_PARAMDATA array
			
	index: INTEGER
			-- Index of first free place in array
			-- of EOLE_PARAMDATA
			
feature {NONE} -- Externals

	ole2_methoddata_allocate (siz: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_methoddata_allocate"
		end

	ole2_methoddata_destroy (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_methoddata_destroy"
		end
		
	ole2_methoddata_set_method_name (this, str: POINTER) is
		external
			"C"
		alias
			"eole2_methoddata_set_method_name"
		end

	ole2_methoddata_set_dispid (this: POINTER; dspid: INTEGER) is
		external
			"C"
		alias
			"eole2_methoddata_set_dispid"
		end

	ole2_methoddata_set_method_index (this: POINTER; ind: INTEGER) is
		external
			"C"
		alias
			"eole2_methoddata_set_method_index"
		end

	ole2_methoddata_set_calling_convention (this: POINTER; convention: INTEGER) is
		external
			"C"
		alias
			"eole2_methoddata_set_calling_convention"
		end

	ole2_methoddata_set_method_flags (this: POINTER; flags: INTEGER) is
		external
			"C"
		alias
			"eole2_methoddata_set_method_flags"
		end

	ole2_methoddata_set_return_type (this: POINTER; vartype: INTEGER) is
		external
			"C"
		alias
			"eole2_methoddata_set_return_type"
		end

	ole2_methoddata_add_param_data (this: POINTER; param_data_ptr: POINTER; ind: INTEGER) is
		external
			"C"
		alias
			"eole2_methoddata_add_param_data"
		end

	ole2_methoddata_put_param_data (this: POINTER; ind: INTEGER; param_data_ptr: POINTER) is
		external
			"C"
		alias
			"eole2_methoddata_put_param_data"
		end

	ole2_methoddata_get_param_data (this: POINTER; ind: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_methoddata_get_param_data"
		end

	ole2_methoddata_get_method_name (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_methoddata_get_method_name"
		end

	ole2_methoddata_get_dispid (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_methoddata_get_dispid"
		end

	ole2_methoddata_get_method_index (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_methoddata_get_method_index"
		end

	ole2_methoddata_get_calling_convention (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_methoddata_get_calling_convention"
		end

	ole2_methoddata_get_arg_count (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_methoddata_get_arg_count"
		end

	ole2_methoddata_get_method_flags (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_methoddata_get_method_flags"
		end

	ole2_methoddata_get_return_type (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_methoddata_get_return_type"
		end
	
end -- class EOLE_METHODDATA

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------