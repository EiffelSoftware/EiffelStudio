indexing
	description: "ITypeLib wrapper"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_LIB

inherit
	ECOM_WRAPPER
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

	make_from_name (file_name: STRING) is
			-- Load type library with `file_name'.
		require
			non_void_file_name: file_name /= Void
			valid_file_name: not file_name.is_empty
		local 
			l_wide_string: ECOM_WIDE_STRING
		do
			create l_wide_string.make_from_string (file_name)
			initializer := ccom_create_c_type_lib_from_name (l_wide_string.item)
			item := ccom_item (initializer)
		ensure
			interface_exist: initializer /= default_pointer and then exists
		end

feature -- Access

	find_name (a_name: STRING; count: INTEGER): ECOM_TYPE_LIB_FIND_NAME_RESULT is
			-- Finds occurences of type description `a_name' in type library.
			-- `count' indicates number of instances to look for.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_wide_string: ECOM_WIDE_STRING
		do
			if not disposed then
				create l_wide_string.make_from_string (a_name)
				Result := ccom_find_name (initializer, l_wide_string.item, count)
			end
		end

	documentation (a_index: INTEGER): ECOM_DOCUMENTATION is
			-- Documentation of library if `a_index' is equal to -1,
			-- or type description, if `a_index' is equal 
			-- to index of type description
		require
			valid_index: a_index >= -1 and a_index < type_info_count
		do
			if not disposed then
				Result := ccom_get_documentation (initializer, a_index)
			end
		ensure
			non_void_documentation: not disposed implies Result /= Void
		end

	library_attributes: ECOM_TLIB_ATTR is
			-- Library's attributes
		do
			if not disposed then
				if not are_attributes_valid then
					type_attr_pointer := ccom_get_lib_attr (initializer)
					create library_attributes_impl.make_from_pointer (type_attr_pointer)
					are_attributes_valid := True
				end
				Result := library_attributes_impl
			end
		ensure
			non_void_attributes: not disposed implies Result /= Void
			valid_attributes: not disposed implies Result.exists
		end

	type_comp: ECOM_TYPE_COMP is
			-- ITypeComp interface
		do
			if not disposed then
				create Result.make_from_pointer (ccom_get_type_comp (initializer))
			end
		ensure
			non_void_type_comp_interface: not disposed implies Result /= Void 
		end

	type_info (a_index: INTEGER): ECOM_TYPE_INFO is
			-- Type description in library at `a_index'
		require
			valid_index: a_index >= 0 and a_index < type_info_count
		do
			if not disposed then
				create Result.make_from_pointer (ccom_get_type_info (initializer, a_index))
			end
		ensure
			non_void_type_info: not disposed implies Result /= Void 
			valid_type_info: not disposed implies Result.exists
		end

	type_info_count: INTEGER is
			-- Number of type descriptions in type library
		do
			if not disposed then
				Result := ccom_get_type_info_count (initializer)
			end
		ensure
			valid_count: not disposed implies Result >= 0
		end

	type_info_of_guid (a_guid: ECOM_GUID): ECOM_TYPE_INFO is
			-- ITypeInfo interface
		require
			non_void_guid: a_guid /= Void
			valid_guid: a_guid.exists
		do
			if not disposed then
				create Result.make_from_pointer (ccom_get_type_info_of_guid (initializer, a_guid.item))
			end
		ensure
			non_void_type_info: not disposed implies Result /= Void 
		end

	type_info_type (a_index: INTEGER): INTEGER is
			-- Type of type description
			-- See ECOM_TYPE_KIND for return values
		require
			valid_index: a_index >= 0 and a_index < type_info_count
		do
			if not disposed then
				Result := ccom_get_type_info_type (initializer, a_index)
			end
		ensure
			valid_type: not disposed implies is_valid_type_kind (Result)
		end

feature -- Status report

	is_name (a_name: STRING): BOOLEAN is
			-- Is name described in library?
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_wide_string: ECOM_WIDE_STRING
		do
			if not disposed then
				create l_wide_string.make_from_string (a_name)
				Result := ccom_is_name (initializer, l_wide_string.item)
			end
		end

feature -- Basic Operations

	release is
			-- Release underlying ITypeLib interface pointer thereby releasing lock on file.
			-- Do not call anything else on this instance after calling `release'.
		do
			dispose
		end
		
feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Initialize wrapper according to `a_pointer'.
		do
			Result := ccom_create_c_type_lib_from_pointer (a_pointer)
		end

	delete_wrapper is
			-- Delete structure.
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
			if not disposed then
				release_tlib_attr
				Precursor
			end
			disposed := True
		end

	type_attr_pointer: POINTER
			-- Pointer to TYPEATTR structure

	disposed: BOOLEAN
			-- Was structure released?

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
end -- class ECOM_TYPE_LIB

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

