indexing
	description: "Generator of dispinterface functions for client."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

	WIZARD_DISPATCH_FUNCTION_HELPER

	WIZARD_SHARED_GENERATION_ENVIRONMENT

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; 
				interface_name, guid: STRING; lcid: INTEGER; 
				a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate function.
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_string: interface_name /= Void and guid /= Void
		local
			ccom_func_name: STRING
			result_type_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create ccom_feature_writer.make
			create c_header_files.make

	
			func_desc := a_descriptor

			-- Set function name used in ccom
			if a_descriptor.coclass_eiffel_names.has (a_component_descriptor.name) then
				ccom_func_name := external_feature_name (a_descriptor.coclass_eiffel_names.item (a_component_descriptor.name))
			else
				ccom_func_name := external_feature_name (a_descriptor.interface_eiffel_name)
			end
			ccom_feature_writer.set_name (ccom_func_name)

			ccom_feature_writer.set_comment (func_desc.description)

			result_type_visitor := a_descriptor.return_type.visitor

			if does_routine_have_result (a_descriptor) then
				set_return_type (result_type_visitor)
			else
				ccom_feature_writer.set_result_type ("void")
			end

			if func_desc.argument_count > 0 then
				set_signature
			end

			if (result_type_visitor.vt_type = Vt_variant) then
				result_type_visitor.set_ce_function_name ("ccom_ce_pointed_variant")
			end
			ccom_feature_writer.set_body (feature_body (interface_name, guid, lcid, result_type_visitor))
		ensure
			function_descriptor_set: func_desc /= Void
		end

feature {NONE} -- Access

	free_arguments: LINKED_LIST[STRING]

feature {NONE} -- Implementation

	set_signature is
			-- Set ccom client feature signature
		require
			non_void_feature_writer: ccom_feature_writer /= Void
		do
			ccom_feature_writer.set_signature (cecil_signature (func_desc))
		end

	feature_body (interface_name, guid: STRING; lcid: INTEGER; result_type_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Ccom client feature body for dispatch interface
		require
			non_void_string: interface_name /= Void and guid /= Void
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			return_value: STRING
			counter, flag: INTEGER
			visitor: WIZARD_DATA_TYPE_VISITOR
			out_variable: BOOLEAN
			a_type: INTEGER
		do
			create free_arguments.make
			create return_value.make (10000)

			Result := check_interface_pointer (interface_name)
			Result.append (New_line_tab)

			Result.append ("DISPID disp = (DISPID) ")
			Result.append_integer (func_desc.member_id)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append ("LCID lcid = (LCID) ")
			Result.append_integer (lcid)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Empty_dispparams)
			Result.append (New_line_tab)

			Result.append (Return_variant_variable)
			Result.append (New_line_tab)
			Result.append (New_line)

			Result.append (initialize_excepinfo)
			Result.append (New_line_tab)

			Result.append ("unsigned int nArgErr")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- Set up arguments
			if (func_desc.argument_count > 0) then
				Result.append ("args.cArgs")
				Result.append (Space_equal_space)
				Result.append_integer (func_desc.argument_count)
				Result.append (Semicolon)
				Result.append (New_line_tab)

				Result.append (Variantarg)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Arguments_name)
				Result.append (Semicolon)
				Result.append (New_line_tab)

				free_arguments.put_front (Arguments_name)

				Result.append (Arguments_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)
				Result.append (Variantarg)
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
				Result.append (Co_task_mem_alloc)
				Result.append (Space_open_parenthesis)
				Result.append_integer (func_desc.argument_count)
				Result.append (Asterisk)
				Result.append (Sizeof)
				Result.append (Space_open_parenthesis)
				Result.append (Variantarg)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)

				arguments := func_desc.arguments
				from
					arguments.start
					counter := func_desc.argument_count - 1
				until
					arguments.off or else counter = -1
				loop
					flag := arguments.item.flags
					visitor := arguments.item.type.visitor
					
					-- Since VARIANT is treated as VARIANT *,
					-- we need to check what it was originally,
					-- to find out whether if [in] or [in, out] parameter.
					if is_variant (arguments.item.type.type) then
						a_type := arguments.item.type.type
					else
						a_type := arguments.item.type.visitor.vt_type
					end
					
					if 
						is_byref (a_type) 
					then
						out_variable := True  
						if is_paramflag_fin (arguments.item.flags) then
							Result.append (inout_parameter_set_up (arguments.item.name, counter, visitor))
						else
							Result.append (out_parameter_set_up (arguments.item.name, counter, visitor))
						end
						if not visitor.is_array_basic_type and not visitor.is_structure_pointer and not
						 		visitor.is_interface_pointer and not visitor.is_coclass_pointer then
							return_value.append (out_return_value_set_up (arguments.item.name, counter,  visitor))
						end
					else
						Result.append (in_parameter_set_up (arguments.item.name, counter, visitor))
					end

					visitor := Void

					arguments.forth
					counter := counter - 1			
				end

				Result.append (New_line_tab)
				Result.append ("args.rgvarg")
				Result.append (Space_equal_space)
				Result.append (Arguments_name)
				Result.append (Semicolon)
			end

			Result.append (New_line)
			Result.append (New_line_tab)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Interface_variable_prepend)
			Result.append (interface_name)
			Result.append (Struct_selection_operator)
			Result.append (Invoke)
			Result.append (Space_open_parenthesis)
			Result.append ("disp, IID_NULL, lcid, DISPATCH_METHOD, &args, &")
			Result.append (Return_variant_variable_name)
			Result.append (Comma_space)
			Result.append (Excepinfo_variable_name)
			Result.append (Comma_space)
			Result.append ("&nArgErr);")
			Result.append (New_line_tab)

			-- if argument error
			Result.append (examine_parameter_error (Hresult_variable_name))
			Result.append (New_line)
			Result.append (examine_hresult_with_pointer (Hresult_variable_name, free_arguments))

			if out_variable then
				Result.append (New_line_tab)
				Result.append (return_value)
			end

			if not free_arguments.is_empty then
				from
					free_arguments.start
				until
					free_arguments.off
				loop
					Result.append (New_line_tab)
					Result.append (Co_task_mem_free)
					Result.append (Space_open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (C_void_pointer)
					Result.append (Close_parenthesis)
					Result.append (free_arguments.item)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					free_arguments.forth
				end
			end

			Result.append (New_line_tab)
			Result.append (retval_return_value_set_up (result_type_visitor))
		end

	out_return_value_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up return value for "out" parameter
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
			valid_position: position >= 0
		local
			type: INTEGER
		do
			type := visitor.vt_type
			create Result.make (1000)

			Result.append (New_line_tab)
			if not visitor.is_basic_type and not visitor.is_enumeration then
				if visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append (Ce_mapper)
				end
				Result.append (Dot)
				Result.append (visitor.ce_function_name)
			end
			Result.append (Space_open_parenthesis)

			if is_unsigned_long (type) then
				Result.append ("(long *)")
			elseif is_unsigned_int (type) then
				Result.append ("(int *)")
			elseif is_unsigned_short (type) then
				Result.append ("(short *)")
			elseif is_unsigned_char (type) then
				Result.append ("(char *)")
	--		elseif 
			else
				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
			end

			Result.append (out_value_set_up (position, vartype_namer.variant_field_name (visitor)))
			Result.append (Comma_space)
			Result.append (name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)

		end

	out_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "out" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			tmp_string: STRING
			type: INTEGER
		do
			type := visitor.vt_type
			
			create Result.make (10000)
			
			
			if 
				visitor.is_basic_type or 
				visitor.is_enumeration 
			then
				create tmp_string.make (200)
				tmp_string.append (name)
				Result.append (New_line_tab)
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), tmp_string, visitor))

			else
				Result.append (New_line_tab)
				Result.append (argument_type_set_up (position, type))

				if visitor.is_array_basic_type or visitor.is_structure_pointer or visitor.is_interface_pointer
						or visitor.is_coclass_pointer then
					Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), name, visitor))	
				else
					Result.append (visitor.c_type)
					Result.remove (Result.count)
					Result.append (Tmp_clause)
					Result.append (name)
					Result.append (Space_equal_space)
					Result.append (Zero)
					Result.append (Semicolon)
					Result.append (New_line_tab)

					create tmp_string.make (100)
					tmp_string.append (Ampersand)
					tmp_string.append (Tmp_clause)
					tmp_string.append (name)
					Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), tmp_string, visitor))	
				end
			end
		end

	inout_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "in" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			tmp_value: STRING
		do
			if is_error (visitor.vt_type) or is_hresult (visitor.vt_type) then
				create Result.make (500)
				Result.append (New_line_tab)
				Result.append (argument_type_set_up (position, visitor.vt_type))

				create tmp_value.make (500)
				tmp_value.append (Ec_mapper)
				tmp_value.append (Dot)
				tmp_value.append (visitor.ec_function_name)
				tmp_value.append (Space_open_parenthesis)
				tmp_value.append (Eif_access)
				tmp_value.append (Space_open_parenthesis)
				tmp_value.append (name)
				tmp_value.append (Close_parenthesis)
				tmp_value.append (Comma_space)
				tmp_value.append (Null)
				tmp_value.append (Close_parenthesis)
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), tmp_value, visitor))
			else
				Result := in_parameter_set_up (name, position, visitor)
			end
		end

	in_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "in" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			tmp_value: STRING
			type: INTEGER
		do
			type := visitor.vt_type

			create Result.make (10000)
			Result.append (New_line_tab)
			Result.append (argument_type_set_up (position, type))
			
			if visitor.is_basic_type or visitor.is_enumeration or
					is_hresult (visitor.vt_type) or is_error (visitor.vt_type) then
				create tmp_value.make (100)
				tmp_value.append (name)
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), tmp_value, visitor))

			elseif (type = Vt_bool) then

				create tmp_value.make (100)
				tmp_value.append (Ec_mapper)
				tmp_value.append (Dot)
				tmp_value.append (visitor.ec_function_name)
				tmp_value.append (Space_open_parenthesis)
				tmp_value.append (name)
				tmp_value.append (Close_parenthesis)

				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), tmp_value, visitor))
				
			elseif visitor.is_basic_type_ref then

				create tmp_value.make (100)
				tmp_value.append (Tmp_clause)
				tmp_value.append (name)
				free_arguments.put_front (tmp_value)

				Result.append (New_line_tab)
				Result.append (visitor.c_type)
				Result.append (Space)
				Result.append (tmp_value)
				Result.append (Semicolon)

				Result.append (New_line_tab)
				Result.append (tmp_value)
				Result.append (Space_equal_space)

				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Ec_mapper)
				Result.append (Dot)
				Result.append (visitor.ec_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space_open_parenthesis)
				Result.append (name)
				Result.append (Close_parenthesis)
				if visitor.writable then
					Result.append (Comma_space)
					Result.append (Null)
				end
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), tmp_value, visitor))

			elseif 
				visitor.is_array_basic_type or 
				visitor.is_structure_pointer or
				(is_variant (type) and visitor.is_structure)
			then
				Result.append (New_line_tab)
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), name, visitor))

			elseif
				visitor.is_interface_pointer or
				visitor.is_coclass_pointer
			then
				Result.append (New_line_tab)
				Result.append (add_ref_in_interface_pointer (name))
				Result.append (argument_value_set_up (position, vartype_namer.variant_field_name (visitor), name, visitor))

			elseif visitor.is_structure then
				Result.append (New_line_tab)
				if is_decimal (visitor.vt_type) then
					Result.append ("CURRENCY tmp_cy;")
					Result.append (New_line_tab)
					Result.append ("VarCyFromDec (")
					Result.append (name)
					Result.append (", &tmp_cy);")
					Result.append (New_line_tab)
					Result.append ("VarDecFromCy (tmp_cy, &(arguments[")
					Result.append_integer (position)
					Result.append ("].decVal));")
				else
					create tmp_value.make (100)
					tmp_value.append (Asterisk)
					tmp_value.append (name)
					Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), tmp_value, visitor))
				end
			else
				if is_byref (type) then
					create tmp_value.make (100)
					tmp_value.append (Tmp_clause)
					tmp_value.append (name)
					free_arguments.put_front (tmp_value)

					Result.append (New_line_tab)
					Result.append (visitor.c_type)
					Result.append (Space)
					Result.append (tmp_value)
					Result.append (Semicolon)

					Result.append (New_line_tab)
					Result.append (tmp_value)
					Result.append (Space_equal_space)

					if visitor.need_generate_ec then
						Result.append (Generated_ec_mapper)
					else
						Result.append (Ec_mapper)
					end

					Result.append (Dot)
					Result.append (visitor.ec_function_name)
					Result.append (Space_open_parenthesis)
					Result.append (Eif_access)
					Result.append (Space_open_parenthesis)
					Result.append (name)
					Result.append (Close_parenthesis)
					if visitor.writable then
						Result.append (Comma_space)
						Result.append (Null)
					end
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab)
				else
					create tmp_value.make (500)
					if visitor.need_generate_ec then
						tmp_value.append (Generated_ec_mapper)
					else
						tmp_value.append (Ec_mapper)
					end
					tmp_value.append (Dot)
					tmp_value.append (visitor.ec_function_name)
					tmp_value.append (Space_open_parenthesis)
					tmp_value.append (Eif_access)
					tmp_value.append (Space_open_parenthesis)
					tmp_value.append (name)
					tmp_value.append (Close_parenthesis)
					tmp_value.append (Close_parenthesis)
				end

				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (visitor), tmp_value, visitor))
			end
		end
		
	out_value_set_up (position: INTEGER; attribute_name: STRING): STRING is
			-- Set up code for argument variable
		require
			valid_position: position >= 0
			non_void_attribute_name: attribute_name /= Void
			valid_name: not attribute_name.is_empty
		do
			create Result.make (500)
			Result.append (Arguments_name)

			Result.append (Open_bracket)
			Result.append_integer (position)
			Result.append (Close_bracket)

			Result.append (Dot)
			Result.append (attribute_name)
		end
			
	argument_type_set_up (position, type: INTEGER): STRING is
			-- Code to set parameter type for dispatch function call
		require
			valid_position: position >= 0
		do
			create Result.make (500)
			Result.append (Arguments_variable_name)
			Result.append (Open_bracket)
			Result.append_integer (position)
			Result.append (Close_bracket)
			Result.append (Dot)
			Result.append ("vt")
			Result.append (Space_equal_space)
			Result.append_integer (type)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		ensure
			non_void_argument_type: Result /= Void
			valid_argument_type: not Result.is_empty
		end

	argument_value_set_up (position: INTEGER; attribute_name, value: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set parameter value for dispatch function call
		require
			non_void_visitor: visitor /= Void
			non_void_name: attribute_name /= Void
			valid_name: not attribute_name.is_empty
			non_void_value: value /= Void
			valid_value: not value.is_empty
		do
			Result := out_value_set_up (position, attribute_name)
			Result.append (Space_equal_space)
			Result.append (Open_parenthesis)

			if 
				(visitor.is_coclass_pointer or 
				visitor.is_interface_pointer)
			then
				if 
					is_unknown (visitor.vt_type)
				then
					Result.append (IUnknown)
				else
					Result.append (Idispatch)
				end

			elseif 
				(visitor.is_coclass_pointer_pointer or 
				visitor.is_interface_pointer_pointer) 
			then
				if is_unknown (visitor.vt_type) then
					Result.append (Iunknown)
				else
					Result.append (Idispatch)
				end
				Result.append (Asterisk)
			else
				if 
					is_variant (visitor.vt_type) and
					visitor.is_structure
				then
					Result.append ("VARIANT")
					Result.append (Space)
					Result.append (Asterisk)
				else
					Result.append (visitor.c_type)
				end
			end
			Result.append (Close_parenthesis)
			Result.append (value)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		ensure
			non_void_argument_value: Result /= Void
			valid_argument_value: not Result.is_empty
		end

end -- class WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR
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
