indexing

	description: "EXCEPINFO structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_EXCEPINFO

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
	
feature -- Element change

	allocate: POINTER is
			-- Create associated C++ structure.
		do
			Result := ole2_excepinfo_allocate
		end

	reset is
			-- Clear associated C++ structure.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_excepinfo_reset (ole_ptr)
		end

	set_error_code (code: INTEGER) is
			-- Set `error_code' with `code'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_excepinfo_set_error_code (ole_ptr, code)
		end

	set_error_source (app_name: STRING) is
			-- Set `error_source' with `app_name'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_error_source: app_name /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (app_name)
			ole2_excepinfo_set_error_source (ole_ptr, wel_string.item)
		end

	set_error_description (readable_string: STRING) is
			-- Set `error_description' with `readable_string'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_readable_string: readable_string /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (readable_string)
			ole2_excepinfo_set_error_description (ole_ptr, wel_string.item)
		end

	set_help_file (help_file_full_name: FILE_NAME) is
			-- Set `help_file' with `help_file_full_name'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_help_file_name: help_file_full_name /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (help_file_full_name)
			ole2_excepinfo_set_help_file (ole_ptr, wel_string.item)
		end

	set_ole_error_code (ole_error: INTEGER) is
			-- Set `ole_error_code' with `ole_error'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_excepinfo_set_ole_error_code (ole_ptr, ole_error)
		end
			
feature -- Access

	error_code: INTEGER is
			-- Error code identifying error 
			-- Error codes should be greater than 1000.
			-- Either this attribute or `ole_error_code' attribute is
			-- significant (the other is equal to 0).
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_excepinfo_get_error_code (ole_ptr)
		end

	error_source: STRING is
			-- Textual, human-readable name of source of exception
			-- Typically, application name
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result.make (0)
			Result.from_c (ole2_excepinfo_get_error_source (ole_ptr))
		end

	error_description: STRING is
			-- Textual, human-readable description of error intended for customer
		require
			valid_c_structure: ole_ptr /= default_pointer
		local
			str: EOLE_BSTR
		do
			!! Result.make (0)
			!! str.make_from_ptr (ole2_excepinfo_get_error_description (ole_ptr))
			Result := str.to_string
		end

	help_file: STRING is
			-- Fully qualified drive, path, and file name of Help file 
			-- with more information about error
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result.make (0)
			Result.from_c (ole2_excepinfo_get_help_file (ole_ptr))
		end

	ole_error_code: INTEGER is
			-- Return value describing error
			-- Either this attribute or `error_code' attribute is
			-- significant (the other is equal to 0).
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_excepinfo_get_ole_error_code (ole_ptr)
		end

feature {NONE} -- Externals

	ole2_excepinfo_allocate: POINTER is
		external
			"C"
		alias
			"eole2_excepinfo_allocate"
		end

	ole2_excepinfo_reset (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_excepinfo_reset"
		end

	ole2_excepinfo_get_error_code (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_excepinfo_get_error_code"
		end

	ole2_excepinfo_get_error_source (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_excepinfo_get_error_source"
		end

	ole2_excepinfo_get_error_description (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_excepinfo_get_error_description"
		end

	ole2_excepinfo_get_help_file (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_excepinfo_get_help_file"
		end

	ole2_excepinfo_get_ole_error_code (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_excepinfo_get_ole_error_code"
		end

	ole2_excepinfo_set_error_code (ptr: POINTER; code: INTEGER) is
		external
			"C"
		alias
			"eole2_excepinfo_set_error_code"
		end

	ole2_excepinfo_set_error_source (ptr, str: POINTER) is
		external
			"C"
		alias
			"eole2_excepinfo_set_error_source"
		end

	ole2_excepinfo_set_error_description (ptr, str: POINTER) is
		external
			"C"
		alias
			"eole2_excepinfo_set_error_description"
		end

	ole2_excepinfo_set_help_file (ptr, str: POINTER) is
		external
			"C"
		alias
			"eole2_excepinfo_set_help_file"
		end

	ole2_excepinfo_set_ole_error_code (ptr: POINTER; code: INTEGER) is
		external
			"C"
		alias
			"eole2_excepinfo_set_ole_error_code"
		end
	
end -- class EOLE_EXCEPINFO

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
