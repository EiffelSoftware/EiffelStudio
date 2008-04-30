indexing
	description: "Factory of Function descriptors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FUNCTION_DESCRIPTOR_FACTORY

inherit
	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_FORBIDDEN_NAMES
		export
			{NONE} all
		end

	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end

	ECOM_CALL_CONV
		export
			{NONE} all
		end

	ECOM_FUNC_FLAGS
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	ANY

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_func_desc: ECOM_FUNC_DESC): WIZARD_FUNCTION_DESCRIPTOR is
			-- Initialize
		require
			valid_type_info: a_type_info /= Void
			valid_func_desc: a_func_desc /= Void
		local
			l_names: ARRAY[STRING]
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
			l_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			l_count: INTEGER
			l_name: STRING
		do
			member_id := a_func_desc.member_id
			description := a_type_info.documentation (member_id).doc_string
			l_count  := a_func_desc.total_param_count
			func_kind := a_func_desc.func_kind

			check
				virtual_or_dispatch: func_kind = Func_purevirtual or func_kind = Func_dispatch
			end

			vtbl_offset := a_func_desc.vtbl_offset
			invoke_kind := a_func_desc.invoke_kind
			call_conv := a_func_desc.call_conv
			return_type := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, a_func_desc.return_type.type_desc, system_descriptor)
			l_names := a_type_info.names (member_id, l_count + 1)
			create name.make (256)
			if is_propertyput (invoke_kind) then
				name.append ("set_")
			elseif is_propertyputref (invoke_kind) then
				name.append ("set_ref_")
			end
			l_name := l_names.item (1)
			if l_name = Void or else l_name.is_empty then
				l_type_lib := a_type_info.containing_type_lib
				l_guid := l_type_lib.library_attributes.guid
				l_descriptor := system_descriptor.library_descriptor (l_guid)
				create l_name.make (100)
				l_name.append ("func_")
				l_name.append (l_descriptor.name)
				l_name.append ("_")
				l_name.append_integer (a_type_info.index_in_type_lib + 1)
				l_name.append ("_")
				l_name.append_integer (member_id)
			else
				from_iunknown_or_idispatch := is_unknown_dispatch_function (a_type_info)
			end
			name.append (l_name)
			eiffel_name := name_for_feature_with_keyword_check (name)
			if not from_iunknown_or_idispatch and is_forbidden_c_word (name) then
				name.prepend ("a_")
			end
			arguments := create_arguments (l_names, l_count, a_func_desc.parameters, a_type_info)
			argument_count := l_count
			create Result.make (Current)
		ensure
			valid_name: name /= Void and then not name.is_empty
			valid_arguments: arguments /= Void and then arguments.count = a_func_desc.total_param_count
			valid_reurn_type: return_type /= Void
		end

	create_arguments (some_names: ARRAY[STRING]; count: INTEGER; parameters: ARRAY [ECOM_ELEM_DESC]; a_type_info: ECOM_TYPE_INFO): LIST [WIZARD_PARAM_DESCRIPTOR] is
			-- Create arguments
		require
			non_void_names: some_names /= Void
			valid_parameters: parameters /= Void and then parameters.count = count
			valid_type_info: a_type_info /= Void
		local
			i: INTEGER
			l_descriptor: WIZARD_PARAM_DESCRIPTOR
			l_arg: STRING
		do
			if some_names.count < count + 1 then
				some_names.conservative_resize (1, count + 1)
			end
			create {ARRAYED_LIST [WIZARD_PARAM_DESCRIPTOR]} Result.make (count)
			from
				i := 2
			variant
				count - i + 2
			until
				i > count + 1
			loop
				l_arg := some_names.item (i)
				if l_arg = Void or else l_arg.is_empty then
					create l_arg.make (7)
					l_arg.append ("arg_")
					l_arg.append_integer (i - 1)
				end
				l_arg := name_for_feature_with_keyword_check (l_arg)
				l_descriptor := parameter_descriptor_factory.create_descriptor (l_arg, a_type_info,
						parameters.item (i - 1), system_descriptor)
				Result.force (l_descriptor)
				i := i + 1
			end
		ensure
			valid_arguments: Result /= Void and then Result.count = count
		end

	initialize_descriptor (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Initialize descriptor fields
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_description (description)
			a_descriptor.set_member_id (member_id)
			a_descriptor.set_argument_count (argument_count)
			a_descriptor.set_arguments (arguments)
			a_descriptor.set_vtbl_offset (vtbl_offset)
			a_descriptor.set_func_kind (func_kind)
			a_descriptor.set_invoke_kind (invoke_kind)
			a_descriptor.set_call_conv (call_conv)
			a_descriptor.set_return_type (return_type)
			a_descriptor.set_interface_eiffel_name (eiffel_name)
			a_descriptor.set_from_iunknown_or_idispatch (from_iunknown_or_idispatch)
		end

feature {NONE} -- Implementation

	is_unknown_dispatch_function (a_info: ECOM_TYPE_INFO): BOOLEAN is
			-- Is function with type info `a_info' and func desc `a_func_desc' from IUnknown or IDispatch?
		require
			non_void_info: a_info /= Void
		local
			l_names: ARRAY [STRING]
			l_name: STRING
		do
			Result := vtbl_offset <= 2 * size_of_pointer
			if not Result then
				if a_info.type_attr.type_kind = Tkind_dispatch then
					Result := vtbl_offset <= 6 * size_of_pointer
				else
					-- No other way than checking function name because vtable interface
					-- might inherit from IDispatch.
					l_names := a_info.names (member_id, 1)
					if l_names /= Void then
						l_name := l_names.item (1)
						if l_name /= Void then
							Result := l_name.is_equal (Invoke) or
										l_name.is_equal (Get_ids_of_names) or
										l_name.is_equal (Get_type_info) or
										l_name.is_equal (Get_type_info_count)
						end
					end
				end
			end
		end

	name: STRING
			-- Function name

	eiffel_name: STRING
			-- Eiffel name

	from_iunknown_or_idispatch: BOOLEAN
			-- Is function from IUnknown or IDispatch?

	description: STRING
			-- Help String

	member_id: INTEGER
			-- Member ID of function

	argument_count: INTEGER
			-- Number of function arguments

	arguments: LIST [WIZARD_PARAM_DESCRIPTOR]
			-- Function parameters

	vtbl_offset: INTEGER
			-- Offset in Vtable

	func_kind: INTEGER
			-- Specifies, whether function virtual or dispatch

	invoke_kind: INTEGER
			-- Invokation kind
			-- See class ECOM_INVOKE_KIND for return values

	call_conv: INTEGER
			-- Function's calling convention

	return_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Function return type

feature {NONE} -- External

	size_of_pointer: INTEGER is
			-- Size of pointer
		external
			"C [macro <eif_eiffel.h>]: EIF_INTEGER"
		alias
			"sizeof (int*)"
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
end -- class WIZARD_FUNCTION_DESCRIPTOR_FACTORY


