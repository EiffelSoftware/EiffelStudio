indexing

	description: "COM ITypeLib interface"
	note: "The type library must exist and be retrieved with%
			%`load_type_lib' before any other operation"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_TYPE_LIB

inherit
	EOLE_UNKNOWN

creation
	make
	
feature -- Element change

	load_type_lib (filename: FILE_NAME) is
			-- Load type library `filename'.
		require
			valid_filename: filename /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (filename)
			attach_ole_interface_ptr (ole2_typelib_load_type_lib (wel_string.item))
		end

feature -- Message Transmission

	find_name (name: EOLE_BSTR; count: INTEGER): EOLE_TYPE_LIB_RESULT is
			-- Try to find `count' occurences of type descriptions 
			-- containing `name' in type library.
		require
			valid_interface: ole_interface_ptr /= default_pointer
			valid_name: name /= Void and then name.ole_ptr /= default_pointer
			valid_count: count > 0
		local
			i: INTEGER
		do
			!! Result.make (ole2_typelib_find_name (ole_interface_ptr, name.ole_ptr, count))
			from
			until
				i = Result.count
			loop
				i := i + 1
				Result.type_info.put (ole2_typelib_get_result_type_info (i), i)
				Result.member_ids.put (ole2_typelib_get_result_member_ids (i),i)
			end
		end
		
	get_type_info_count: INTEGER is
			-- Number of type descriptions in type library
			-- Not meant to be redefined; redefine `on_get_type_info_count' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			Result := ole2_typelib_get_typeinfo_count (ole_interface_ptr)
		end

	get_type_info (index: INTEGER): EOLE_TYPE_INFO is
			-- Type description in the library at `index' 
			-- Not meant to be redefined; redefine `on_get_type_info' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		local
			ptypeinfo: POINTER
		do
			ptypeinfo := ole2_typelib_get_type_info (ole_interface_ptr, index);
			if ptypeinfo /= default_pointer then
				!! Result.make
				Result.attach_ole_interface_ptr (ptypeinfo)
			end
		end

	get_documentation (index: INTEGER): EOLE_DOCUMENTATION is
			-- Library's documentation string, complete Help file name and path at `index' 
			-- Not meant to be redefined; redefine `on_get_documentation' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		local
			ptr_1, ptr_2, ptr_3: POINTER
			name, doc_string, help_file: EOLE_BSTR
		do
			!! Result
			ole2_typelib_get_documentation (ole_interface_ptr, index, $ptr_1, $ptr_2, $ptr_3)
			name.make_from_ptr (ptr_1)
			doc_string.make_from_ptr (ptr_2)
			help_file.make_from_ptr (ptr_3)
			Result.set_name (name)
			Result.set_doc_string (doc_string)
			Result.set_help_file (help_file)
		end
		
feature {NONE} -- Externals

	ole2_typelib_get_result_type_info (i: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_typelib_get_result_type_info"
		end
		
	ole2_typelib_get_result_member_ids (i: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_typelib_get_result_member_ids"
		end
	
	ole2_typelib_find_name (ptr, bstr_ptr: POINTER; cnt: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_typelib_find_name"
		end
	
	ole2_typelib_get_typeinfo_count (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_typelib_get_type_info_count"
		end

	ole2_typelib_get_type_info (this: POINTER; index: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_typelib_get_type_info"
		end

	ole2_typelib_get_documentation (this: POINTER; index: INTEGER; name, doc_string, help_file: POINTER) is
		external
			"C"
		alias
			"eole2_typelib_get_documentation"
		end

	ole2_typelib_load_type_lib (filename: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_typelib_load_type_lib"
		end
	
end -- class EOLE_TYPE_LIB

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
