indexing

	description: "COM ITypeInfo interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_TYPE_INFO

inherit
	EOLE_UNKNOWN
		export
			{NONE} create_ole_interface_ptr
		redefine
			interface_identifier,
			interface_identifier_list,
			is_initializable_from_eiffel
		end

	EOLE_METHOD_FLAGS
	
	EOLE_TYPE_KIND

	EOLE_IMPL_TYPE_FLAGS

creation
	make
		
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_type_info
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (Iid_type_info)
		end

	is_initializable_from_eiffel: BOOLEAN is
			-- Does interface support Callbacks?
		once
			Result := False
		end

	containing_type_lib: EOLE_TYPE_LIB
			-- Containing type library
			-- Use `get_containing_library' to initialize.
			
	index_in_containing_type_lib: INTEGER
			-- Index in containing type library
			-- Use `get_containing_library' to initialize.

	type_attr: EOLE_TYPE_ATTR is
			-- Type attributes
			-- Use `get_type_attr' to initialize.
		once
			!! Result
		end
			
	func_desc: EOLE_FUNC_DESC is
			-- Function description
			-- Use `get_func_desc' to initialize.
		once
			!! Result
		end
			
	var_desc: EOLE_VAR_DESC is
			-- Variable/member data description
			-- Use `get_var_desc' to initialize.
		once
			!! Result
		end
		
	is_com_class: BOOLEAN is
			-- Is described type a COM class?
		local
			get_type_attr_called: BOOLEAN
		do
			get_type_attr_called := type_attr.is_attached
			if not get_type_attr_called then
				get_type_attr
			end
			Result := type_attr.type_kind = Tkind_coclass
			if not get_type_attr_called then
				release_type_attr
			end
		end
		
feature -- Message Transmission

	address_of_member (member_id, invoke_ind: INTEGER): POINTER is
			-- Addresses of static functions or variables
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_typeinfo_address_of_member (ole_interface_ptr, member_id, invoke_ind)
		end

	create_instance (punk_outer: POINTER; riid: STRING): POINTER is
			-- Create new instance of type that describes component object class.
			-- `rrid' indicates which interface is requested.
		require
			valid_interface: is_valid_interface
			is_com_class: is_com_class
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (riid)
			Result := ole2_typeinfo_create_instance (ole_interface_ptr, punk_outer, wel_string.item)
		end

	get_containing_type_lib is
			-- set `containing_type_lib' to Containing type library
			-- and `index_in_containing_type_lib' to index of type
			-- description within that type library.
		require
			valid_interface: is_valid_interface
		local	
			ptr: POINTER
		do
			index_in_containing_type_lib := ole2_typeinfo_get_containing_typelib (ole_interface_ptr, $ptr)
			if ptr /= default_pointer then
				!! containing_type_lib.make
				containing_type_lib.attach_ole_interface_ptr (ptr)
			end
		end

	get_dll_entry (mem_id, invoke_kind: INTEGER): EOLE_DLL_ENTRY is
			-- Description or specification for entry point of
			-- function with member identifier `mem_id' and member
			-- kind `invoke_kind'.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_typeinfo_get_dll_entry (ole_interface_ptr, mem_id, invoke_kind)
		end

	get_documentation (index: INTEGER): EOLE_DOCUMENTATION is
			-- Type Info documentation string, complete Help file name and path at `index' 
		require
			valid_interface: is_valid_interface
		local
			ptr_1, ptr_2, ptr_3: POINTER
			name, doc_string, help_file: EOLE_BSTR
		do
			!! Result
			ole2_typeinfo_get_documentation (ole_interface_ptr, index, $ptr_1, $ptr_2, $ptr_3)
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

	get_func_desc (index: INTEGER) is
			-- Set `func_desc' with description of function at `index'
		require
			valid_interface: is_valid_interface
		do
			func_desc.attach (ole2_typeinfo_get_func_desc (ole_interface_ptr, index))
		end

	get_ids_of_names (names: ARRAY [STRING]): ARRAY [INTEGER] is
			-- Map between member names and member IDs, 
			-- and parameter names and parameter IDs.
		require
			valid_interface: is_valid_interface
			valid_names: names /= Void
		local
			i, count: INTEGER;
			wel_string: WEL_STRING
		do
			ole2_auto_erase_names
			from
				i := names.lower
			until
				i > names.upper
			loop
				!! wel_string.make (names.item (i))
				ole2_auto_add_name (wel_string.item)
				i := i + 1
			end
			ole2_typeinfo_map_names (ole_interface_ptr)
			count := names.upper - names.lower + 1
			!! Result.make (1, count)
			from
				i := 0
			until
				i >= count
			loop
				Result.put (ole2_auto_get_name_id (i), i + 1)
				i := i + 1
			end
		ensure
			good_mapping: names.count = Result.count
		end

	get_impl_type_flags (index: INTEGER): INTEGER is
			-- IMPLTYPEFLAGS for a base or implemented interface
			-- See class EOLE_IMPL_TYPE_FLAGS for Result values.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_typeinfo_get_impl_type_flags (ole_interface_ptr, index)
		ensure
			valid_impl_type_flags: is_valid_impltypeflag (Result)
		end

	get_mops (member_id: INTEGER): EOLE_BSTR is
			-- Marshaling information
		require
			valid_interface: is_valid_interface
		local
			ptr: POINTER
		do
			ptr := ole2_typeinfo_get_mops (ole_interface_ptr, member_id)
			if ptr /= default_pointer then
				!! Result.make_from_ptr (ptr)
			end
		end

	get_names (member_id: INTEGER): ARRAY [STRING] is
			-- Retrieve variable (or name of property or method
			-- and its parameters) that correspond to `member_id'
		require
			valid_interface: is_valid_interface
		local
			i, count: INTEGER;
			str: STRING
		do
			count := ole2_typeinfo_get_names_and_count (ole_interface_ptr, member_id)
			!! Result.make (1, count)
			from
				i := 0
			until
				i >= count
			loop
				!! str.make (0)
				str.from_c (ole2_typeinfo_get_name (ole_interface_ptr, i))
				Result.put (str, i + 1)
				i := i + 1
			end
		end

	get_ref_type_info (type_ref_handle: INTEGER): EOLE_TYPE_INFO is
			-- Referenced type descriptions (if any)
		require
			valid_interface: is_valid_interface
		local
			ptypeinfo: POINTER
		do
			ptypeinfo := ole2_typeinfo_get_ref_type_info (ole_interface_ptr, type_ref_handle)
			if ptypeinfo /= default_pointer then
				!! Result.make
				Result.attach_ole_interface_ptr (ptypeinfo)
			end
		end

	get_ref_type_of_impl_type (index: INTEGER): INTEGER is
			-- Implemented type handle at `index'
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_typeinfo_get_ref_type_of_impl_type (ole_interface_ptr, index)
		end

	get_type_attr is
			-- Set `type_attr' with attributes of type description
		require
			valid_interface: is_valid_interface
		do
			type_attr.attach (ole2_typeinfo_get_type_attr (ole_interface_ptr))
		end

	get_type_comp: EOLE_TYPE_COMP is
			-- ITypeComp interface for type description
		require
			valid_interface: is_valid_interface
		do
			!! Result.make
			Result.attach_ole_interface_ptr (ole2_typeinfo_get_type_comp (ole_interface_ptr))
		end

	get_var_desc (var_index: INTEGER) is
			-- Set `var_desc' with description of variable at `var_index'.
		require
			valid_interface: is_valid_interface
		local
			ptr: POINTER
		do
			ptr := ole2_typeinfo_get_var_desc (ole_interface_ptr, var_index)
			if ptr /= default_pointer then
				var_desc.attach (ptr)
			end
		end

	invoke (dispid, flag: INTEGER; params: EOLE_DISPPARAMS; res: EOLE_VARIANT; exception: EOLE_EXCEPINFO) is
			-- Invoke method, or access property of object defined by `dispid'.
			-- See class EOLE_METHODFLAGS for `flag' value.
		require
			valid_interface: is_valid_interface
			valid_method_flag: is_valid_method_flag (flag)
			valid_params: params /= Void and then params.ole_ptr /= default_pointer
			valid_res: res /= Void and then res.ole_ptr /= default_pointer
			valid_exception: exception /= Void and then exception.ole_ptr /= default_pointer
		do
			ole2_typeinfo_invoke (ole_interface_ptr, dispid, flag, params.ole_ptr, res.ole_ptr, exception.ole_ptr)
		end

	release_func_desc is
			-- Release `fd'.
		require
			valid_interface: is_valid_interface
			valid_func_desc: func_desc /= Void and then func_desc.ole_ptr /= default_pointer
		do
			ole2_typeinfo_release_func_desc (ole_interface_ptr, func_desc.ole_ptr)
			func_desc.detach
		end

	release_type_attr is
			-- Release `ta'.
		require
			valid_interface: is_valid_interface
			valid_typeattr: type_attr /= Void and then type_attr.ole_ptr /= default_pointer
		do
			ole2_typeinfo_release_type_attr (ole_interface_ptr, type_attr.ole_ptr)
			type_attr.detach			
		end

	release_var_desc is
			-- Release `vd'.
		require
			valid_interface: is_valid_interface
			valid_var_desc: var_desc /= Void and then var_desc.ole_ptr /= default_pointer
		do
			ole2_typeinfo_release_var_desc (ole_interface_ptr, var_desc.ole_ptr)
			var_desc.detach
		end

feature {NONE} -- Externals

	ole2_create_disp_type_info (idata: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_create_disp_type_info"
		end

	ole2_typeinfo_address_of_member (this: POINTER; member_id, invoke_ind: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_address_of_member"
		end

	ole2_typeinfo_create_instance (this, punk_outer, clsid: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_create_instance"
		end

	ole2_typeinfo_get_containing_typelib (this, ptypelib: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_tinfo_get_containing_typelib"
		end

	ole2_typeinfo_get_dll_entry (this: POINTER; mem_id, invoke_ind: INTEGER): EOLE_DLL_ENTRY is
		external
			"C"
		alias
			"eole2_tinfo_get_dll_entry"
		end

	ole2_typeinfo_get_documentation (this: POINTER; member_id: INTEGER; name, doc_string, help_file: POINTER) is
		external
			"C"
		alias
			"eole2_tinfo_get_documentation"
		end

	ole2_typeinfo_get_func_desc (this: POINTER; index: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_get_func_desc"
		end

	ole2_auto_erase_names is
		external
			"C"
		alias
			"eole2_auto_erase_names"
		end

	ole2_auto_add_name (str: POINTER) is
		external
			"C"
		alias
			"eole2_auto_add_name"
		end

	ole2_typeinfo_map_names (this: POINTER) is
		external
			"C"
		alias
			"eole2_tinfo_map_names"
		end

	ole2_auto_get_name_id (i: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_auto_get_name_id"
		end

	ole2_typeinfo_get_impl_type_flags (this: POINTER; index: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_tinfo_get_impl_type_flags"
		end

	ole2_typeinfo_get_mops (this: POINTER; mem_id: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_get_mops"
		end

	ole2_typeinfo_get_names_and_count (this: POINTER; mem_id: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_tinfo_get_names_and_count"
		end

	ole2_typeinfo_get_name (this: POINTER; i: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_get_name"
		end

	ole2_typeinfo_get_ref_type_info (this: POINTER; type_ref_handle: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_get_ref_type_info"
		end

	ole2_typeinfo_get_ref_type_of_impl_type (this: POINTER; index: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_tinfo_get_ref_type_of_impl_type"
		end

	ole2_typeinfo_get_type_attr (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_get_type_attr"
		end

	ole2_typeinfo_get_type_comp (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_get_type_comp"
		end

	ole2_typeinfo_get_var_desc (this: POINTER; var_index: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_tinfo_get_var_desc"
		end

	ole2_typeinfo_invoke (this: POINTER; dispid, flags: INTEGER; params, res, exception: POINTER) is
		external
			"C"
		alias
			"eole2_tinfo_invoke"
		end

	ole2_typeinfo_release_func_desc (this, fd: POINTER) is
		external
			"C"
		alias
			"eole2_tinfo_release_func_desc"
		end

	ole2_typeinfo_release_type_attr (this, ta: POINTER) is
		external
			"C"
		alias
			"eole2_tinfo_release_type_attr"
		end

	ole2_typeinfo_release_var_desc (this, vd: POINTER) is
		external
			"C"
		alias
			"eole2_tinfo_release_var_desc"
		end
	
end -- class EOLE_TYPE_INFO

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

