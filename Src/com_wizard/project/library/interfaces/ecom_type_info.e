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
	make_from_pointer

feature -- Access

	address_of_member (memid: INTEGER; invkind: INTEGER): POINTER is
			-- Address of static function or variable defined by
			-- `memid' and `invkind'
		require
			valid_invke_kind: is_valid_invoke_kind (invkind)
		do
			Result := ccom_address_of_member (initializer, memid, invkind)
		end

	new_instance (outer: POINTER; a_refiid: ECOM_GUID): POINTER is
			-- New instance of coclass
		require
			com_class: is_com_class
			can_create: is_typeflag_fcancreate (type_attr.flags)
		do
			Result := ccom_create_instance (initializer, outer, a_refiid.item)
		end

	containing_type_lib: ECOM_TYPE_LIB is
			-- Containing type library
		do
			if not is_type_lib_valid then
				get_containing_type_lib
			end
			Result := containing_type_lib_impl
		ensure
			non_void_containing_library: Result /= Void
		end

	index_in_type_lib: INTEGER is
			-- Index in containing type library
		do
			if not is_type_lib_valid then
				get_containing_type_lib
			end
			Result := index_in_type_lib_impl
		end

	dll_entry (memid: INTEGER; invkind: INTEGER): ECOM_DLL_ENTRY is
			-- Description of entry point for function in DLL
		require
			is_valid_invoke_kind (invkind)
		do
			Result := ccom_get_dll_entry (initializer, memid, invkind)
		ensure
			non_void_dll_entry: Result /= Void
		end

	documentation (memid: INTEGER): ECOM_DOCUMENTATION is
			-- Documentation for type description
		do
			Result := ccom_get_documentation (initializer, memid)
		ensure
			non_void_documentation: Result /= Void
		end

	func_desc (a_index: INTEGER): ECOM_FUNC_DESC is
			-- FUNCDESC structure containing information about specified function
		require
			valid_index: a_index >= 0 and a_index < type_attr.count_func
		local
			tmp_pointer: POINTER
		do
			if func_descs = Void then
				create {ARRAYED_LIST [ECOM_FUNC_DESC]} func_descs.make (20)
			end
			tmp_pointer := ccom_get_func_desc (initializer, a_index)
			create Result.make_from_pointer (tmp_pointer)
			Result.set_parent (Current)
			func_descs.extend (Result)
		ensure
			non_void_description: Result /= Void
			valid_description: Result.is_parent_valid
		end

	ids_of_names (some_names: ARRAY[STRING]): ARRAY[INTEGER] is
			-- Mapping between member names and member IDs,
			-- and parameter names and parameter IDs.
		local
			i: INTEGER
			any: ANY
			a_p: ARRAY [POINTER]
			wide_string: ECOM_WIDE_STRING
		do
			create a_p.make (some_names.lower, some_names.count)
			from
				i := some_names.lower
			until
				i > some_names.upper
			loop
				create wide_string.make_from_string (some_names.item (i))
				a_p.put (wide_string.item, i)
				i := i + 1
			end
			any := a_p.to_c
			Result := ccom_get_ids_of_names (initializer, $any, some_names.count)
		ensure
			non_void_ids: Result /= Void
		end

	impl_type_flag (a_index: INTEGER): INTEGER is
			-- See ECOM_IMPL_TYPE_FLAGS for return values.
		do
			Result := ccom_get_impl_type_flags (initializer, a_index)
		ensure
			valid_flag: is_valid_impltypeflag (Result)
		end

	mops (memid: INTEGER): STRING is
			-- Marshaling information
		do
			Result := ccom_get_mops (initializer, memid)
		ensure
			non_void_mops: Result /= Void
		end

	names (id: INTEGER; max_names: INTEGER): ARRAY[STRING] is
			-- Variable name or method name and its parameters
			-- that correspond to specified `id'.
			-- `max_names' maximal number of names to be returned
		do
			Result := ccom_get_names (initializer, id, max_names)
		end

	type_info (a_handle: INTEGER): ECOM_TYPE_INFO is
			-- ITypeInfo interface refernced by `a_handle'
			-- which is returned by `ref_type_of_impl_type'
		do
			create Result.make_from_pointer (ccom_get_ref_type_info (initializer, a_handle))
		end

	ref_type_of_impl_type (a_index: INTEGER): INTEGER is
			-- handle of inmplemented interface type, which can be passed to 
			-- `type_info'
			-- Valid range is 0 to `count_implemented_types' of `type_attr'
		require
			valid_index: a_index >= -1 and then a_index <= type_attr.count_implemented_types
		do
			Result := ccom_get_ref_type_of_impl_type (initializer, a_index)
		end

	type_attr: ECOM_TYPE_ATTR is
			-- TYPEATTR structure
		local
			tmp_pointer: POINTER
		do
			if not is_type_attr_set then
				tmp_pointer := ccom_get_type_attr (initializer)
				create type_attr_impl.make_from_pointer (tmp_pointer)
				is_type_attr_set := True
			end
			Result := type_attr_impl
		ensure
			non_void_attributes: Result /= Void
			valid_attributes: Result.exists
		end

	type_comp: ECOM_TYPE_COMP is
			-- ITypeComp inteface
		do
			create Result.make_from_pointer (ccom_get_type_comp (initializer))
		ensure
			non_void_interface: type_comp /= Void
		end

	var_desc (a_index: INTEGER): ECOM_VAR_DESC is
			-- VARDESC structure
		require
			valid_index: a_index >= 0 and a_index < type_attr.count_variables
		local
			tmp_pointer: POINTER
		do
			if var_descs = Void then
				create {ARRAYED_LIST [ECOM_VAR_DESC]} var_descs.make (20)
			end
			tmp_pointer := ccom_get_var_desc (initializer, a_index)
			create Result.make_from_pointer (tmp_pointer)
			Result.set_parent (Current)
			var_descs.extend (Result)
		ensure
			non_void_description: Result /= Void
			valid_description: Result.is_parent_valid
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

	get_containing_type_lib is
			-- Retrieve containing type library and index
			-- of type description within type library
		do
			ccom_get_containing_type_lib (initializer)
			create containing_type_lib_impl.make_from_pointer (ccom_containing_type_lib (initializer))
			index_in_type_lib_impl := ccom_index_type_lib (initializer)
			is_type_lib_valid := True
		end

feature -- Basic operations

	invoke (an_instance: POINTER; memid: INTEGER; flags: INTEGER; 
				disp_params: ECOM_DISP_PARAMS; var_result: ECOM_VARIANT;
				excep_info: ECOM_EXCEP_INFO) is
			-- invoke method
			-- `an_instance' is returned by `new_instance'
		require
			an_instance /= default_pointer
			is_valid_method_flag (flags)
			disp_params /= Void
			var_result /= Void
			excep_info /= Void
		do
			ccom_invoke (initializer, an_instance, memid, flags, disp_params.item, var_result.item, excep_info.item)
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create interface
		do
			Result := ccom_create_c_type_info_from_pointer (a_pointer)
		end

	delete_wrapper is
			-- Delete structure
		do
			ccom_delete_c_type_info (initializer);
		end

	containing_type_lib_impl: ECOM_TYPE_LIB 
			-- Containing type library
	
	index_in_type_lib_impl: INTEGER 
			-- Index in containg type library

	type_attr_impl: ECOM_TYPE_ATTR
			-- TYPEATTR structure

	is_type_attr_set: BOOLEAN
			-- Is TYPEATTR structure initialized?

	func_descs: LIST [ECOM_FUNC_DESC]
			-- FUNCDESC structures

	var_descs: LIST [ECOM_VAR_DESC]
			-- VARDESC structures

feature {NONE} -- Externals

	ccom_create_c_type_info_from_pointer (a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IType_Info %"E_ITypeInfo.h%"](ITypeInfo *)"
		end

	ccom_delete_c_type_info (cpp_obj: POINTER) is
		external
			"C++ [delete E_IType_Info %"E_ITypeInfo.h%"]()"
		end

	ccom_get_containing_type_lib (cpp_obj: POINTER) is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"]()"
		end

	ccom_invoke(cpp_obj: POINTER; a_instance: POINTER;
			a_memid: INTEGER; a_flags: INTEGER; a_disp_params: POINTER;
			a_result: POINTER; a_excep_info: POINTER) is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_POINTER, EIF_INTEGER, %
				% EIF_INTEGER, EIF_POINTER, EIF_POINTER, EIF_POINTER)"
		end

	ccom_address_of_member (cpp_obj: POINTER; a_memid, an_invkind: INTEGER):POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER, EIF_INTEGER): EIF_POINTER"
		end

	ccom_create_instance (cpp_obj: POINTER; outer, a_refiid: POINTER):POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_POINTER, EIF_POINTER): EIF_POINTER"
		end

	ccom_containing_type_lib (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](): (ITypeLib *)"
		end

	ccom_index_type_lib (cpp_obj: POINTER): INTEGER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](): EIF_INTEGER"
		end

	ccom_get_dll_entry (cpp_obj: POINTER; a_memid, an_invkind: INTEGER): ECOM_DLL_ENTRY is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER, EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_get_documentation (cpp_obj: POINTER; a_memid: INTEGER): ECOM_DOCUMENTATION is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_get_func_desc (cpp_obj: POINTER; a_index: INTEGER): POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER): (FUNCDESC *)"
		end

	ccom_get_ids_of_names (cpp_obj: POINTER; some_names: POINTER; count: INTEGER): ARRAY[INTEGER] is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_POINTER, EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_get_impl_type_flags (cpp_obj: POINTER; a_index: INTEGER): INTEGER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER): EIF_INTEGER"
		end

	ccom_get_mops (cpp_obj: POINTER; memid: INTEGER): STRING is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER): EIF_REFERNCE"
		end

	ccom_get_names (cpp_obj: POINTER; memid: INTEGER; max_names: INTEGER): ARRAY[STRING] is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER, EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_get_ref_type_info (cpp_obj: POINTER; a_handle: INTEGER): POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER): (ITypeInfo *)"
		end

	ccom_get_ref_type_of_impl_type (cpp_obj: POINTER; a_index: INTEGER): INTEGER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER): EIF_INTEGER"
		end

	ccom_get_type_attr (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](): (TYPEATTR *)"
		end

	ccom_get_type_comp (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](): (ITypeComp *)"
		end

	ccom_get_var_desc  (cpp_obj: POINTER; a_index: INTEGER): POINTER is
		external
			"C++ [E_IType_Info %"E_ITypeInfo.h%"](EIF_INTEGER): (VARDESC *)"
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

