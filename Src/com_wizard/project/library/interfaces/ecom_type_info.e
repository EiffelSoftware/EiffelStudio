indexing
	description: "ITypeInfo wrapper"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_INFO

inherit
	ECOM_WRAPPER

	ECOM_INVOKE_KIND

	ECOM_IMPL_TYPE_FLAGS

	ECOM_METHOD_FLAGS

	ECOM_TYPE_KIND

	ECOM_TYPE_FLAGS

creation
	make

feature -- Access

	last_result: ECOM_HRESULT
			-- Result from last call

	address_of_member (a_memid: INTEGER; invkind: INTEGER): POINTER is
			-- Address of static function or variable defined by
			-- `a_memid' and `invkind'
		require
			valid_invke_kind: is_valid_invoke_kind (invkind)
		do
			create last_result.make_from_integer (c_address_of_member (item, a_memid, invkind, $Result))
		end

	new_instance (outer: POINTER; a_refiid: ECOM_GUID): POINTER is
			-- New instance of coclass
		require
			com_class: is_com_class
			can_create: is_typeflag_fcancreate (type_attr.flags)
		do
			create last_result.make_from_integer (c_create_instance (item, outer, a_refiid.item, $Result))
		end

	containing_type_lib: ECOM_TYPE_LIB is
			-- Containing type library
		do
			if not is_type_lib_valid then
				retrieve_containing_type_lib
			end
			Result := containing_type_lib_impl
		ensure
			non_void_containing_library: Result /= Void
		end

	index_in_type_lib: INTEGER is
			-- Index in containing type library
		do
			if not is_type_lib_valid then
				retrieve_containing_type_lib
			end
			Result := index_in_type_lib_impl
		end

	dll_entry (a_memid: INTEGER; invkind: INTEGER): ECOM_DLL_ENTRY is
			-- Description of entry point for function in DLL
		require
			valid_kind: is_valid_invoke_kind (invkind)
		local
			l_name, l_entry_point: POINTER
			l_ordinal: INTEGER
			l_name_bstr, l_ep_bstr: ECOM_BSTR
		do
			create last_result.make_from_integer (c_get_dll_entry (item, a_memid, invkind, $l_name, $l_entry_point, $l_ordinal))
			if last_result.succeeded then
				create l_name_bstr.make (l_name)
				create l_ep_bstr.make (l_entry_point)
				create Result.make (l_name_bstr.string, l_ep_bstr.string, l_ordinal)
			end
		end

	documentation (a_memid: INTEGER): ECOM_DOCUMENTATION is
			-- Documentation for type description
		local
			l_name, l_doc, l_file: POINTER
			l_context: NATURAL_32
			l_name_bstr: ECOM_BSTR
			l_doc_text, l_file_text: STRING
		do
			create last_result.make_from_integer (c_get_documentation (item, a_memid, $l_name, $l_doc, $l_context, $l_file))
			if last_result.succeeded then
				create l_name_bstr.make (l_name)
				if l_doc /= default_pointer then
					l_doc_text := (create {ECOM_BSTR}.make (l_doc)).string
				end
				if l_file /= default_pointer then
					l_file_text := (create {ECOM_BSTR}.make (l_file)).string
				end
				create Result.make (l_name_bstr.string, l_doc_text, l_context, l_file_text)
			else
				create Result.make ("", "", 0, "")
			end
		ensure
			non_void_documentation: Result /= Void
		end

	func_desc (a_index: INTEGER): ECOM_FUNC_DESC is
			-- FUNCDESC structure containing information about specified function
		require
			valid_index: a_index >= 0 and a_index < type_attr.count_func
		local
			l_pointer: POINTER
		do
			create last_result.make_from_integer (c_get_func_desc (item, a_index, $l_pointer))
			if last_result.succeeded then
				create Result.make_from_pointer (l_pointer)
				Result.set_parent (Current)
			end
		ensure
			valid_description: Result /= Void implies Result.is_parent_valid
		end

	ids_of_names (a_names: ARRAY [STRING]): ARRAY [INTEGER] is
			-- Mapping between member names and member IDs,
			-- and parameter names and parameter IDs.
		local
			l_array: WEL_STRING_ARRAY
			i, l_count: INTEGER
			l_ids: MANAGED_POINTER
			l_pointer: POINTER
		do
			create l_array.make (a_names)
			l_count := a_names.count
			l_pointer := l_pointer.memory_alloc (l_count * Integer_32_bytes)
			create last_result.make_from_integer (c_get_ids_of_names (item, l_array.item.item, l_count, $l_pointer))
			if last_result.succeeded then
				create l_ids.share_from_pointer (l_pointer, l_count)
				from
					i := 1
					create Result.make (1, l_count)
				until
					i > l_count
				loop
					Result.put (l_ids.read_integer_32 ((i - 1) * Integer_32_bytes), i)
					i := i + 1
				end
				l_pointer.memory_free
			end
		end

	impl_type_flag (a_index: INTEGER): INTEGER is
			-- See ECOM_IMPL_TYPE_FLAGS for return values.
		do
			create last_result.make_from_integer (c_get_impl_type_flags (item, a_index, $Result))
		ensure
			valid_flag: is_valid_impltypeflag (Result)
		end

	mops (a_memid: INTEGER): STRING is
			-- Marshaling information
		local
			l_bstr: ECOM_BSTR
			l_pointer: POINTER
		do
			create last_result.make_from_integer (c_get_mops (item, a_memid, $l_pointer))
			if last_result.succeeded then
				create l_bstr.make (l_pointer)
				Result := l_bstr.string
			end
		ensure

		end

	names (a_memid: INTEGER; a_max_names: INTEGER): ARRAY [STRING] is
			-- Variable name or method name and its parameters
			-- that correspond to specified `id'.
			-- `max_names' maximal number of names to be returned
		local
			l_names: MANAGED_POINTER
			i, l_count: INTEGER
			l_bstr: ECOM_BSTR
		do
			create l_names.make (a_max_names * Pointer_bytes)
			create last_result.make_from_integer (c_get_names (item, a_memid, l_names.item, a_max_names, $l_count))
			if last_result.succeeded then
				from
					i := 1
					create Result.make (1, l_count)
				until
					i > l_count
				loop
					create l_bstr.make (l_names.read_pointer ((i - 1) * Pointer_bytes))
					Result.put (l_bstr.string, i)
					i := i + 1
				end
			end
		end

	type_info (a_handle: NATURAL_32): ECOM_TYPE_INFO is
			-- ITypeInfo interface refernced by `a_handle'
			-- which is returned by `ref_type_of_impl_type'
		local
			l_pointer: POINTER
		do
			create last_result.make_from_integer (c_get_ref_type_info (item, a_handle, $l_pointer))
			if last_result.succeeded then
				create Result.make (l_pointer)
			end
		end

	ref_type_of_impl_type (a_index: INTEGER): NATURAL_32 is
			-- handle of inmplemented interface type, which can be passed to
			-- `type_info'
			-- Valid range is 0 to `count_implemented_types' of `type_attr'
		require
			valid_index: a_index >= -1 and then a_index <= type_attr.count_implemented_types
		do
			create last_result.make_from_integer (c_get_ref_type_of_impl_type (item, a_index, $Result))
		end

	type_attr: ECOM_TYPE_ATTR is
			-- TYPEATTR structure
		local
			l_pointer: POINTER
		do
			if not is_type_attr_set then
				create last_result.make_from_integer (c_get_type_attr (item, $l_pointer))
				if last_result.succeeded then
					create type_attr_impl.make_from_pointer (l_pointer)
					is_type_attr_set := True
				end
			end
			Result := type_attr_impl
		end

	var_desc (a_index: INTEGER): ECOM_VAR_DESC is
			-- VARDESC structure
		require
			valid_index: a_index >= 0 and a_index < type_attr.count_variables
		local
			l_pointer: POINTER
		do
			create last_result.make_from_integer (c_get_var_desc (item, a_index, $l_pointer))
			if last_result.succeeded then
				create Result.make_from_pointer (l_pointer)
				Result.set_parent (Current)
			end
		ensure
			valid_description: Result /= Void implies Result.is_parent_valid
		end

feature -- Status report

	is_type_lib_valid: BOOLEAN
			-- Was containing type library accessed?

	is_com_class: BOOLEAN is
			-- Is described type COM class?
		do
			Result := type_attr.type_kind = Tkind_coclass
		end

feature -- Status setting

	retrieve_containing_type_lib is
			-- Retrieve containing type library and index
			-- of type description within type library
		local
			l_pointer: POINTER
		do
			create last_result.make_from_integer (c_get_containing_type_lib (item, $l_pointer, $index_in_type_lib_impl))
			if last_result.succeeded then
				create containing_type_lib_impl.make (l_pointer)
				is_type_lib_valid := True
			end
		end

feature -- Basic operations

	invoke (a_instance: POINTER; a_memid: INTEGER; a_flags: INTEGER;
				a_disp_params: ECOM_DISP_PARAMS; a_var_result: ECOM_VARIANT;
				a_excep_info: ECOM_EXCEP_INFO) is
			-- invoke method
			-- `a_instance' is returned by `new_instance'
		require
			valid_a_instance: a_instance /= default_pointer
			valid_flags: is_valid_method_flag (a_flags)
			attached_a_disp_params: a_disp_params /= Void
			attached_a_var_result: a_var_result /= Void
			attached_a_excep_info: a_excep_info /= Void
		local
			l_arg_err: INTEGER
		do
			create last_result.make_from_integer (c_invoke (item, a_instance, a_memid, a_flags, l_arg_err, a_disp_params.item, a_var_result.item, a_excep_info.item))
		end

feature {NONE} -- Implementation

	memory_free is
			-- Free interface pointer
		do
			c_release (item)
			item := default_pointer
		end

	containing_type_lib_impl: ECOM_TYPE_LIB
			-- Containing type library

	index_in_type_lib_impl: INTEGER
			-- Index in containg type library

	type_attr_impl: ECOM_TYPE_ATTR
			-- TYPEATTR structure

	is_type_attr_set: BOOLEAN
			-- Is TYPEATTR structure initialized?

feature {NONE} -- Externals

	c_release (a_item: POINTER) is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->Release((ITypeInfo*)$a_item)"
		end

	c_address_of_member (a_item: POINTER; a_memid, a_invkind: INTEGER; a_address: TYPED_POINTER [POINTER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->AddressOfMember ((ITypeInfo*)$a_item, (MEMBERID)$a_memid, (INVOKEKIND)$a_invkind, ((void**)$a_address))"
		end

	c_create_instance (a_item: POINTER; a_punk, a_refiid: POINTER; a_address: TYPED_POINTER [POINTER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->CreateInstance ((ITypeInfo*)$a_item, (IUnknown*)$a_punk, (REFIID)$a_refiid, ((void**)$a_address))"
		end

	c_invoke (a_item, a_instance: POINTER; a_memid, a_flags, a_arg_err: INTEGER; a_disp_params, a_result, a_except_info: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->Invoke ((ITypeInfo*)$a_item, (void *)$a_instance, (MEMBERID)$a_memid, (unsigned short)$a_flags, (DISPPARAMS *)$a_disp_params, (VARIANT *)$a_result, (EXCEPINFO *)$a_except_info, (unsigned int*)&$a_arg_err)"
		end

	c_get_containing_type_lib (a_item: POINTER; a_type_lib: TYPED_POINTER [POINTER]; a_index: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetContainingTypeLib ((ITypeInfo*)$a_item, (ITypeLib**)$a_type_lib, (unsigned int *)$a_index)"
		end

	c_get_dll_entry (a_item: POINTER; a_memid, a_invkind: INTEGER; a_name, a_entry_point: POINTER; a_ordinal: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetDllEntry ((ITypeInfo*)$a_item, (MEMBERID)$a_memid, (INVOKEKIND)$a_invkind, (BSTR*)$a_name, (BSTR*)$a_entry_point, (unsigned short*)($a_ordinal))"
		end

	c_get_documentation (a_item: POINTER; a_memid: INTEGER; a_name, a_doc: POINTER; a_context: TYPED_POINTER [NATURAL_32]; a_file: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetDocumentation ((ITypeInfo*)$a_item, (MEMBERID)$a_memid, (BSTR*)$a_name, (BSTR*)$a_doc, (unsigned long*)$a_context, (BSTR*)$a_file)"
		end

	c_get_func_desc (a_item: POINTER; a_index: INTEGER; a_desc: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetFuncDesc ((ITypeInfo*)$a_item, (unsigned int)$a_index, (FUNCDESC**)$a_desc)"
		end

	c_get_ids_of_names (a_item: POINTER; a_names: POINTER; a_count: INTEGER; a_id: TYPED_POINTER [POINTER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetIDsOfNames ((ITypeInfo*)$a_item, (OLECHAR**)$a_names, (unsigned int)$a_count, (MEMBERID*)$a_id)"
		end

	c_get_impl_type_flags (a_item: POINTER; a_index: INTEGER; a_res: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetImplTypeFlags ((ITypeInfo*)$a_item, (unsigned int)$a_index, (int*)$a_res)"
		end

	c_get_mops (a_item: POINTER; a_memid: INTEGER; a_res: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetMops ((ITypeInfo*)$a_item, (MEMBERID)$a_memid, (BSTR*)$a_res)"
		end

	c_get_names (a_item: POINTER; a_memid: INTEGER; a_res: POINTER; a_max_names: INTEGER; a_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetNames ((ITypeInfo*)$a_item, (MEMBERID)$a_memid, (BSTR*)$a_res, (unsigned int)$a_max_names, (unsigned int*)$a_count)"
		end

	c_get_ref_type_info (a_item: POINTER; a_handle: NATURAL_32; a_res: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetRefTypeInfo ((ITypeInfo*)$a_item, (HREFTYPE)$a_handle, (ITypeInfo**)$a_res)"
		end

	c_get_ref_type_of_impl_type (a_item: POINTER; a_index: INTEGER; a_res: TYPED_POINTER [NATURAL_32]): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetRefTypeOfImplType ((ITypeInfo*)$a_item, (unsigned int)$a_index, (HREFTYPE*)$a_res)"
		end

	c_get_type_attr (a_item, a_res: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetTypeAttr ((ITypeInfo*)$a_item, (TYPEATTR**)$a_res)"
		end

	c_get_var_desc (a_item: POINTER; a_index: INTEGER; a_res: POINTER): INTEGER is
		external
			"C inline use <oaidl.h>"
		alias
			"((ITypeInfo*)$a_item)->lpVtbl->GetVarDesc ((ITypeInfo*)$a_item, (unsigned int)$a_index, (VARDESC**)$a_res)"
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
end -- class ECOM_TYPE_INFO

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

