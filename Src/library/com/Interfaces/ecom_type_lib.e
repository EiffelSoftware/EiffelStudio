indexing
	description: "ITypeLib wrapper"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_LIB

inherit
	ECOM_INTERFACE
		redefine
			dispose
		end
	
	ECOM_TYPE_KIND
		export
			{NONE} all
		end

creation
	make_from_pointer,
	make_from_name

feature {NONE} -- Initialization

	make_from_name (file_name: FILE_NAME) is
			-- Load type library with `file_name'	
		require
			file_name /= Void
		local 
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (file_name)
			initializer := ccom_create_c_type_lib_from_name (wide_string.item)
			interface := ccom_item (initializer)
		ensure
			interface_exist: initializer /= default_pointer and then
					interface /= default_pointer
		end

feature -- Access

	find_name (a_name: STRING; count: INTEGER): ECOM_TYPE_LIB_FIND_NAME_RESULT is
			-- Finds occurences of type description in type library.
			-- `a_name' is name to search for
			-- `count' indicates number of instances to look for
		local
			wide_string: ECOM_WIDE_STRING
		do
			!!wide_string.make_from_string (a_name)
			Result := ccom_find_name (initializer, wide_string.item, count)
		ensure
			Result /= Void
		end

	documentation (an_index: INTEGER): ECOM_DOCUMENTATION is
			-- Documentation of library, 
			-- if `an_index' is equal to -1,
			-- or type description, if `an_index' is equal 
			-- to index of type description
		do
			Result := ccom_get_documentation (initializer, an_index)
		ensure
			Result /= Void
		end

	library_attributes: ECOM_TLIB_ATTR is
			-- Library's attributes
			-- Should be released with `release_tlib_attr'
		do
			if not are_attributes_valid then
				type_attr_pointer := ccom_get_lib_attr (initializer)
				create library_attributes_impl.make_by_pointer (type_attr_pointer)
				are_attributes_valid := True
			end
			Result := library_attributes_impl
		ensure
			Result /= Void and then Result.exists
		end

	type_comp: ECOM_TYPE_COMP is
			-- ITypeComp interface
		do
			!!Result.make_from_pointer (ccom_get_type_comp (initializer))
		ensure
			Result /= Void 
		end

	type_info (an_index: INTEGER): ECOM_TYPE_INFO is
			-- Type description in library at `an_index'
		require
			valid_index: an_index >= 0 and an_index < type_info_count
		do
			!!Result.make_from_pointer (ccom_get_type_info (initializer, an_index))
		ensure
			Result /= Void 
		end

	type_info_count: INTEGER is
			-- Number of type descriptions in type library
		do
			Result := ccom_get_type_info_count (initializer)
		end

	type_info_of_guid (a_guid: ECOM_GUID): ECOM_TYPE_INFO is
			-- ITypeInfo interface
		require
			a_guid /= Void and then a_guid.exists
		do
			!!Result.make_from_pointer (ccom_get_type_info_of_guid (initializer, a_guid.item))
		ensure
			Result /= Void 
		end

	type_info_type (an_index: INTEGER): INTEGER is
			-- Type of type description
			-- See ECOM_TYPE_KIND for return values
		require
			valid_index: an_index >= 0 and an_index < type_info_count
		do
			Result := ccom_get_type_info_type (initializer, an_index)
		ensure
			is_valid_type_kind (Result)
		end

feature -- Status report

	is_name (a_name: STRING): BOOLEAN is
			-- Is name described in library?
		local
			wide_string: ECOM_WIDE_STRING
		do
			!!wide_string.make_from_string (a_name)
			Result := ccom_is_name (initializer, wide_string.item)
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_c_type_lib_from_pointer (a_pointer)
		end

	release_interface is
			-- Delete structure
		do
			ccom_delete_c_type_lib (initializer);
		end

	library_attributes_impl: ECOM_TLIB_ATTR
			-- Library' attributes

	are_attributes_valid: BOOLEAN
			-- Is TLIBATTR structure initialized?

	release_tlib_attr is
			-- Releases TLIBATTR structure
		do
			if are_attributes_valid then
				ccom_release_tlib_attr (initializer, type_attr_pointer)
			end
		end

	dispose is
			-- Release also TLIBATTR structure
		do
			release_tlib_attr
			Precursor
		end

	type_attr_pointer: POINTER
			-- Pointer to TYPEATTR structure

feature {NONE} -- Externals

	ccom_create_c_type_lib_from_pointer (a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IType_Lib %"E_ITypeLib.h%"](ITypeLib *)"
		end

	ccom_create_c_type_lib_from_name (a_name: POINTER): POINTER is
		external
			"C++ [new E_IType_Lib %"E_ITypeLib.h%"](OLECHAR *)"
		end

	ccom_delete_c_type_lib (cpp_obj: POINTER) is
		external
			"C++ [delete E_IType_Lib %"E_ITypeLib.h%"]()"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"]:(ITypeLib *)"
		end

	ccom_find_name (a_ptr: POINTER; a_name: POINTER; count: INTEGER): ECOM_TYPE_LIB_FIND_NAME_RESULT is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](WCHAR *, EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_get_documentation (a_ptr: POINTER; a_index: INTEGER): ECOM_DOCUMENTATION is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_get_lib_attr (a_ptr: POINTER): POINTER is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](): EIF_POINTER"
		end

	ccom_get_type_comp (a_ptr: POINTER): POINTER is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](): EIF_POINTER"
		end

	ccom_get_type_info (a_ptr: POINTER; index: INTEGER): POINTER is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](EIF_INTEGER): EIF_POINTER"
		end

	ccom_get_type_info_count(a_ptr: POINTER): INTEGER is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](): EIF_INTEGER"
		end

	ccom_get_type_info_of_guid (a_ptr: POINTER; guid: POINTER): POINTER is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_get_type_info_type (a_ptr: POINTER; index: INTEGER): INTEGER is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](EIF_INTEGER): EIF_INTEGER"
		end

	ccom_is_name (a_ptr: POINTER; a_name: POINTER): BOOLEAN is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](WCHAR *): EIF_BOOLEAN"
		end

	ccom_release_tlib_attr (a_ptr: POINTER; a_tlib_attr: POINTER) is
		external
			"C++ [E_IType_Lib %"E_ITypeLib.h%"](TLIBATTR *)"
		end


end -- class ECOM_TYPE_LIB

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

