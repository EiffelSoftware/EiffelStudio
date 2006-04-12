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

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

creation
	make,
	make_from_name

feature {NONE} -- Initialization

	make_from_name (a_name: STRING) is
			-- Load type library with `file_name'.
		require
			non_void_file_name: a_name /= Void
			valid_file_name: not a_name.is_empty
		local
			l_string: WEL_STRING
			l_pointer: POINTER
		do
			create l_string.make (a_name)
			create last_result.make_from_integer (c_load_type_lib (l_string.item, $l_pointer))
			if last_result.succeeded then
				item := l_pointer
			end
		end

feature -- Status Report

	initialized: BOOLEAN is
			-- Was instance successfully initialized?
		do
			Result := item /= Default_pointer
		end

	disposed: BOOLEAN
			-- Was structure released?

feature -- Access

	find_name (a_name: STRING; a_count: INTEGER): ECOM_TYPE_LIB_FIND_NAME_RESULT is
			-- Finds occurences of type description `a_name' in type library.
			-- `count' indicates number of instances to look for.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			initialized: initialized
			not_disposed: not disposed
		local
			l_string: WEL_STRING
			l_type_infos, l_ids: MANAGED_POINTER
			l_type_info: ECOM_TYPE_INFO
			i: INTEGER
		do
			create l_string.make (a_name)
			create l_type_infos.make (a_count * Pointer_bytes)
			create l_ids.make (a_count * Integer_bytes)
			create last_result.make_from_integer (c_find_name (item, l_string.item, l_type_infos.item, l_ids.item, $a_count))
			if last_result.succeeded then
				create Result.make (a_count)
				from
					i := 1
				until
					i > a_count
				loop
					create l_type_info.make (l_type_infos.read_pointer ((i - 1) * Pointer_bytes))
					Result.put_type_info (l_type_info, i)
					Result.put_member_ids (l_ids.read_integer_32 ((i - 1) * Integer_bytes), i)
					i := i + 1
				end
			end
		end

	documentation (a_index: INTEGER): ECOM_DOCUMENTATION is
			-- Documentation of library if `a_index' is equal to -1,
			-- or type description, if `a_index' is equal
			-- to index of type description
		require
			valid_index: a_index >= -1 and a_index < type_info_count
			not_disposed: not disposed
		local
			l_name_pointer, l_doc_pointer, l_help_pointer: POINTER
			l_name, l_doc, l_help: STRING
			l_context: NATURAL_32
		do
			create last_result.make_from_integer (c_get_documentation (item, a_index, $l_name_pointer, $l_doc_pointer, $l_context, $l_help_pointer))
			if last_result.succeeded then
				if l_name_pointer /= default_pointer then
					l_name := (create {ECOM_BSTR}.make (l_name_pointer)).string
				end
				if l_doc_pointer /= default_pointer then
					l_doc := (create {ECOM_BSTR}.make (l_doc_pointer)).string
				end
				if l_help_pointer /= default_pointer then
					l_help := (create {ECOM_BSTR}.make (l_help_pointer)).string
				end
				create Result.make (l_name, l_doc, l_context, l_help)
			end
		ensure
			non_void_documentation: not disposed implies Result /= Void
		end

	library_attributes: ECOM_TLIB_ATTR is
			-- Library's attributes
		require
			not_disposed: not disposed
		local
			l_pointer: POINTER
		do
			if library_attributes_impl = Void then
				create last_result.make_from_integer (c_get_lib_attr (item, $l_pointer))
				if last_result.succeeded then
					create library_attributes_impl.make_from_pointer (l_pointer)
				end
			end
			Result := library_attributes_impl
		ensure
			non_void_attributes: not disposed implies Result /= Void
			valid_attributes: not disposed implies Result.exists
		end

	type_info (a_index: INTEGER): ECOM_TYPE_INFO is
			-- Type description in library at `a_index'
		require
			valid_index: a_index >= 0 and a_index < type_info_count
			not_disposed: not disposed
		local
			l_pointer: POINTER
		do
			create last_result.make_from_integer (c_get_type_info (item, a_index, $l_pointer))
			if last_result.succeeded then
				create Result.make (l_pointer)
			end
		ensure
			non_void_type_info: Result /= Void
		end

	type_info_count: INTEGER is
			-- Number of type descriptions in type library
		require
			not_disposed: not disposed
		do
			Result := c_get_type_info_count (item)
		ensure
			valid_count: not disposed implies Result >= 0
		end

	type_info_of_guid (a_guid: ECOM_GUID): ECOM_TYPE_INFO is
			-- ITypeInfo interface
		require
			non_void_guid: a_guid /= Void
			valid_guid: a_guid.exists
			not_disposed: not disposed
		local
			l_pointer: POINTER
		do
			create last_result.make_from_integer (c_get_type_info_of_guid (item, a_guid.item, $l_pointer))
			if last_result.succeeded then
				create Result.make (l_pointer)
			end
		ensure
			non_void_type_info: not disposed implies Result /= Void
		end

	type_info_type (a_index: INTEGER): INTEGER is
			-- Type of type description
			-- See ECOM_TYPE_KIND for return values
		require
			valid_index: a_index >= 0 and a_index < type_info_count
			not_disposed: not disposed
		do
			create last_result.make_from_integer (c_get_type_info_type (item, a_index, $Result))
		ensure
			valid_type: not disposed implies is_valid_type_kind (Result)
		end

feature -- Access

	is_name (a_name: STRING): BOOLEAN is
			-- Is name described in library?
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			not_disposed: not disposed
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			create last_result.make_from_integer (c_is_name (item, l_string.item, $Result))
		end

	last_result: ECOM_HRESULT
			-- Result from last call

feature -- Basic Operations

	release is
			-- Release underlying ITypeLib interface pointer thereby releasing lock on file.
			-- Do not call anything else on this instance after calling `release'.
		do
			memory_free
		end

feature {NONE} -- Implementation

	library_attributes_impl: ECOM_TLIB_ATTR
			-- Library' attributes

	release_tlib_attr is
			-- Releases TLIBATTR structure
		do
			if library_attributes_impl /= Void then
				c_release_tlib_attr (item, type_attr_pointer)
			end
		end

	type_attr_pointer: POINTER
			-- Pointer to TYPEATTR structure

	memory_free is
			--
		do
			if not disposed then
				release_tlib_attr
				c_release (item)
				item := default_pointer
			end
			disposed := True
		end

feature {NONE} -- Externals

	c_release (a_item: POINTER) is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->Release((ITypeLib*)$a_item)"
		end

	c_load_type_lib (a_file_name, a_type_lib: POINTER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"LoadTypeLib ((const OLECHAR*)$a_file_name, (ITypeLib**)$a_type_lib)"
		end

	c_find_name (a_item, a_name, a_infos, a_ids: POINTER; a_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->FindName ((ITypeLib*)$a_item, (OLECHAR*)$a_name, 0, (ITypeInfo**)$a_infos, (MEMBERID*)$a_ids, (unsigned int*)$a_count)"
		end

	c_get_documentation (a_item: POINTER; a_index: INTEGER; a_name, a_doc: TYPED_POINTER [POINTER]; a_context: TYPED_POINTER [NATURAL_32]; a_help: TYPED_POINTER [POINTER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->GetDocumentation ((ITypeLib*)$a_item, (int)$a_index, (BSTR*)$a_name, (BSTR*)$a_doc, (unsigned long*)$a_context, (BSTR*)$a_help)"
		end

	c_get_lib_attr (a_item: POINTER; a_res: TYPED_POINTER [POINTER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->GetLibAttr ((ITypeLib*)$a_item, (TLIBATTR**)$a_res)"
		end

	c_get_type_info (a_item: POINTER; a_index: INTEGER; a_res: TYPED_POINTER [POINTER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->GetTypeInfo ((ITypeLib*)$a_item, (unsigned int)$a_index, (ITypeInfo**)$a_res)"
		end

	c_get_type_info_count(a_item: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->GetTypeInfoCount((ITypeLib*)$a_item)"
		end

	c_get_type_info_of_guid (a_item: POINTER; a_guid: POINTER; a_res: TYPED_POINTER [POINTER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->GetTypeInfoOfGuid((ITypeLib*)$a_item, (REFGUID)$a_guid, (ITypeInfo**)$a_res)"
		end

	c_get_type_info_type (a_item: POINTER; a_index: INTEGER; a_res: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->GetTypeInfoType((ITypeLib*)$a_item, (unsigned int)$a_index, (TYPEKIND*)$a_res)"
		end

	c_is_name (a_item: POINTER; a_name: POINTER; a_res: TYPED_POINTER [BOOLEAN]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->IsName((ITypeLib*)$a_item, (OLECHAR*)$a_name, 0, (BOOL*)$a_res)"
		end

	c_release_tlib_attr (a_item: POINTER; a_tlib_attr: POINTER) is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeLib*)$a_item)->lpVtbl->ReleaseTLibAttr((ITypeLib*)$a_item, (TLIBATTR*)$a_tlib_attr)"
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

