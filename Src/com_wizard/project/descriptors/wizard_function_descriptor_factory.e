indexing
	description: "Factory of Function descriptors"
	status: "See notice at end of class"
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

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_func_desc: ECOM_FUNC_DESC): WIZARD_FUNCTION_DESCRIPTOR is
			-- Initialize
		require
			valid_type_info: a_type_info /= Void
			valid_func_desc: a_func_desc /= Void
		local
			tmp_names: ARRAY[STRING]
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
			tmp_lib_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			a_count: INTEGER
		do
			member_id := a_func_desc.member_id
			description := a_type_info.documentation (member_id).doc_string
			a_count  := a_func_desc.total_param_count
			func_kind := a_func_desc.func_kind

			check
				virtual_or_dispatch: func_kind = Func_purevirtual or
					--	func_kind = Func_virtual or
						func_kind = Func_dispatch
			end

			vtbl_offset := a_func_desc.vtbl_offset
			invoke_kind := a_func_desc.invoke_kind
			call_conv := a_func_desc.call_conv
			return_type := data_type_descriptor_factory.create_data_type_descriptor (a_type_info,
				a_func_desc.return_type.type_desc, system_descriptor)
			tmp_names := a_type_info.names (member_id, a_count + 1)
			name := clone (tmp_names.item (1))
			if name = Void or else name.empty then
				tmp_type_lib := a_type_info.containing_type_lib
				tmp_guid := tmp_type_lib.library_attributes.guid
				tmp_lib_descriptor := system_descriptor.library_descriptor (tmp_guid)
				create name.make (100)
				name.append ("func_")
				name.append (tmp_lib_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
				name.append ("_")
				name.append_integer (member_id)
			end
			if is_propertyput (invoke_kind) then
				name.prepend ("set_")
			elseif is_propertyputref (invoke_kind) then
				name.prepend ("set_ref_")
			end
			eiffel_name := name_for_feature_with_keyword_check (name)
			if is_forbidden_c_word (name) then
				name.prepend ("a_")
			end
			arguments := create_arguments (tmp_names, a_count, a_func_desc.parameters, 
					a_type_info)
			argument_count := a_count
			create Result.make (Current)
		ensure
			valid_name: name /= Void and then not name.empty
			valid_arguments: arguments /= Void and then arguments.count = a_func_desc.total_param_count
			valid_reurn_type: return_type /= Void
		end

	create_arguments (some_names: ARRAY[STRING]; count: INTEGER;
				parameters: ARRAY[ECOM_ELEM_DESC]; 
				a_type_info: ECOM_TYPE_INFO):LINKED_LIST[WIZARD_PARAM_DESCRIPTOR] is
			-- Create arguments
		require
			non_void_names: some_names /= Void 
			valid_parameters: parameters /= Void and then parameters.count = count
			valid_type_info: a_type_info /= Void
		local
			i: INTEGER
			a_param_descriptor: WIZARD_PARAM_DESCRIPTOR
			arg_name: STRING
		do
			if some_names.count < count + 1 then
				some_names.resize (1, count + 1)
			end
			create Result.make
			from
				i := 2
			variant
				count - i + 2
			until
				i > count + 1
			loop
				arg_name := clone (some_names.item (i))
				if arg_name = Void or else arg_name.empty then
					create arg_name.make (100)
					arg_name.append ("arg_")
					arg_name.append_integer (i - 1)
				end
				arg_name := name_for_feature_with_keyword_check (arg_name)
				a_param_descriptor := parameter_descriptor_factory.create_descriptor (arg_name, a_type_info,
						parameters.item (i - 1), system_descriptor)
				Result.force (a_param_descriptor)
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
		end

feature {NONE} -- Implementation

	name: STRING
			-- Function name

	eiffel_name: STRING
			-- Eiffel name

	description: STRING
			-- Help String

	member_id: INTEGER
			-- Member ID of function

	argument_count: INTEGER
			-- Number of function arguments

	arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
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


end -- class WIZARD_FUNCTION_DESCRIPTOR_FACTORY

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

