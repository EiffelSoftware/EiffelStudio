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
		export
			{NONE} create_ole_interface_ptr
		redefine
			interface_identifier,
			interface_identifier_list,
			is_initializable_from_eiffel
		end

	EOLE_GUID

	EOLE_TYPE_KIND

creation
	make
	
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_type_lib
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_type_lib)
		end

	is_initializable_from_eiffel: BOOLEAN is
			-- Does interface support Callbacks?
		once
			Result := False
		end

feature -- Element change

	load_type_lib (filename: FILE_NAME) is
			-- Load type library `filename'.
		require
			valid_filename: filename /= Void
		local
			wel_string: WEL_STRING
			ptr: POINTER
		do
			!! wel_string.make (filename)
			ptr := ole2_typelib_load_type_lib (wel_string.item)
			if ptr /= default_pointer then
				attach_ole_interface_ptr (ptr)
			else
				detach_ole_interface_ptr
			end
		end

feature -- Message Transmission

	find_name (name: STRING; count: INTEGER): EOLE_TYPE_LIB_RESULT is
			-- Try to find `count' occurences of type descriptions 
			-- containing `name' in type library.
		require
			valid_interface: is_valid_interface
			valid_name: name /= Void and then name /= Void
			valid_count: count > 0
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (name)
			Result := ole2_typelib_find_name (ole_interface_ptr, wel_string.item, count)
		end
		
	get_type_info_count: INTEGER is
			-- Number of type descriptions in type library
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_typelib_get_typeinfo_count (ole_interface_ptr)
		end

	get_type_info (index: INTEGER): EOLE_TYPE_INFO is
			-- Type description in the library at `index' 
		require
			valid_interface: is_valid_interface
		local
			ptypeinfo: POINTER
		do
			ptypeinfo := ole2_typelib_get_type_info (ole_interface_ptr, index)
			if ptypeinfo /= default_pointer then
				!! Result.make
				Result.attach_ole_interface_ptr (ptypeinfo)
			end
		end

	get_type_info_of_guid (guid: STRING): EOLE_TYPE_INFO is
			-- Type description corresponding to GUID `guid'.
		require
			valid_interface: is_valid_interface
			valid_guid: is_valid_guid (guid)
		local
			ptypeinfo: POINTER
			wel_string: WEL_STRING
		do
			!! wel_string.make (guid)
			ptypeinfo := ole2_typelib_get_type_info_of_guid (ole_interface_ptr, wel_string.item)
			if ptypeinfo /= default_pointer then
				!! Result.make
				Result.attach_ole_interface_ptr (ptypeinfo)
			end
		end

	get_type_info_type (index: INTEGER): INTEGER is
			-- Type of type description with index `index'.
			-- See class EOLE_TYPE_KIND for Result value.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_typelib_get_type_info_type (ole_interface_ptr, index)
		ensure
			valid_type_kind: status.succeeded implies is_valid_type_kind (Result)
		end

	is_name (name: STRING; lcid: INTEGER): BOOLEAN is
			-- does `name' describe a type or member of library?
			-- `lcid' is the locale identifier of `name'.
		require
			valid_interface: is_valid_interface
		local
			wel_string: WEL_STRING
		do	
			!! wel_string.make (name)
			Result := ole2_typelib_is_name (ole_interface_ptr, wel_string.item, lcid)
		end

	get_type_comp: EOLE_TYPE_COMP is
			-- Retrieve associated ITypeComp.
		require
			valid_interface: is_valid_interface
		do
			!! Result.make
			Result.attach_ole_interface_ptr (ole2_typelib_get_type_comp (ole_interface_ptr))
		end
		
	get_lib_attr is
			-- Read type library attributes in `lib_attr'.
		require
			valid_interface: is_valid_interface
		do
			lib_attr.attach (ole2_typelib_get_lib_attr (ole_interface_ptr))
		end

	release_lib_attr is
			-- Release library attribute structure previously
			-- obtained with `get_lib_attr'
		require
			attributes_read: lib_attr /= Void and then lib_attr.ole_ptr /= default_pointer
		do
			ole2_typelib_release_lib_attr (ole_interface_ptr, lib_attr.ole_ptr)
			lib_attr.detach
		end

	get_documentation (index: INTEGER): EOLE_DOCUMENTATION is
			-- Library's documentation string, complete Help file name and path at `index' 
		require
			valid_interface: is_valid_interface
		local
			ptr_1, ptr_2, ptr_3: POINTER
			name, doc_string, help_file: EOLE_BSTR
		do
			!! Result
			ole2_typelib_get_documentation (ole_interface_ptr, index, $ptr_1, $ptr_2, $ptr_3)
			if status.succeeded then
				if ptr_1 /= default_pointer then
					!! name.make_from_ptr (ptr_1)
				end
				if ptr_2 /= default_pointer then
					!! doc_string.make_from_ptr (ptr_2)
				end
				if ptr_3 /= default_pointer then
					!! help_file.make_from_ptr (ptr_3)
				end
				Result.set_name (name)
				Result.set_doc_string (doc_string)
				Result.set_help_file (help_file)
			end
		end

feature -- Access

	lib_attr: EOLE_LIB_ATTR is
			-- Library attributes
		once
			!! Result
		end
		
feature {NONE} -- Externals
	
	ole2_typelib_find_name (ptr, bstr_ptr: POINTER; cnt: INTEGER): EOLE_TYPE_LIB_RESULT is
		external
			"C"
		alias
			"eole2_typelib_find_name"
		end
	
	ole2_typelib_is_name (ptr, name: POINTER; lcid: INTEGER): BOOLEAN is
		external
			"C"
		alias
			"eole2_typelib_is_name"
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

	ole2_typelib_get_type_info_of_guid (this: POINTER; guid: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_typelib_get_type_info_of_guid"
		end

	ole2_typelib_get_type_info_type (this: POINTER; index: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_typelib_get_type_info_type"
		end

	ole2_typelib_get_type_comp (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_typelib_get_type_comp"
		end
		
	ole2_typelib_get_lib_attr (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_typelib_get_lib_attr"
		end

	ole2_typelib_release_lib_attr (this: POINTER; libattr: POINTER) is
		external
			"C"
		alias
			"eole2_typelib_release_lib_attr"
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

