indexing
	description: "Generator of dispinterface functions for client."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_DISPATCH_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR

	WIZARD_SHARED_GENERATION_ENVIRONMENT

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Basic operations

	generate (interface_name, guid: STRING; lcid: INTEGER; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
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
			ccom_func_name := external_feature_name (a_descriptor.name)

			ccom_feature_writer.set_name (ccom_func_name)
			ccom_feature_writer.set_comment (func_desc.description)

			create result_type_visitor
			result_type_visitor.visit (a_descriptor.return_type)
			ccom_feature_writer.set_result_type (result_type_visitor.c_type)

			-- Set arguments and precondition for eiffel code
			if func_desc.argument_count > 0 then
				-- Argument for ccom feature
				set_signature
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
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			tmp_string: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create tmp_string.make (0)
			arguments := func_desc.arguments
			if arguments /= Void and not arguments.empty then
				from
					arguments.start
				until
					arguments.off
				loop
					create visitor
					visitor.visit (arguments.item.type)

					if is_paramflag_fout (arguments.item.flags) then
						tmp_string.append (Beginning_comment_paramflag)
						if is_paramflag_fin (arguments.item.flags) then
							tmp_string.append ("in, ")
						end
						tmp_string.append ("out")
						tmp_string.append (End_comment_paramflag)

						if visitor.is_basic_type then
							add_warning (Current, Not_pointer_type)

						elseif visitor.is_array_basic_type or 
								visitor.is_interface_pointer or visitor.is_structure_pointer then
							tmp_string.append (visitor.c_type)
							tmp_string.append (Space)
							tmp_string.append (arguments.item.name)
							tmp_string.append (visitor.c_post_type)

						elseif visitor.is_interface or visitor.is_structure then
							tmp_string.append (Eif_pointer)
							tmp_string.append (Space)
							tmp_string.append (arguments.item.name)

						else
							tmp_string.append (Eif_object)
							tmp_string.append (Space)
							tmp_string.append (arguments.item.name)

						end
						if not (visitor.c_header_file = Void or else visitor.c_header_file.empty) then
							c_header_files.extend (visitor.c_header_file)
						end
						tmp_string.append (Comma_space)

					else
						tmp_string.append (Beginning_comment_paramflag)
						tmp_string.append ("in")
						tmp_string.append (End_comment_paramflag)
						if visitor.is_basic_type then
							tmp_string.append (visitor.cecil_type)

						elseif visitor.is_array_basic_type or 
								visitor.is_interface_pointer or visitor.is_structure_pointer then
							tmp_string.append (visitor.c_type)
							tmp_string.append (visitor.c_post_type)
	
						elseif visitor.is_interface or visitor.is_structure then
							tmp_string.append (Eif_pointer)

						else
							tmp_string.append (Eif_object)
						end

						tmp_string.append (Space)
						tmp_string.append (arguments.item.name)
						tmp_string.append (visitor.c_post_type)

						if not (visitor.c_header_file = Void or else visitor.c_header_file.empty) then
							c_header_files.extend (visitor.c_header_file)
						end

						tmp_string.append (Comma_space)

					end
					visitor := Void
					arguments.forth
				end

				if tmp_string.count > 0  then
					tmp_string.remove (tmp_string.count)
					tmp_string.remove (tmp_string.count)
				end
			end
			ccom_feature_writer.set_signature (tmp_string)
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
		do
			create free_arguments.make
			create return_value.make (0)

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
			Result.append (initialize_excepinfo)
			Result.append (New_line_tab)
			Result.append ("unsigned int nArgErr")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- Set up arguments
			if func_desc.argument_count > 0 then
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
					create visitor
					visitor.visit (arguments.item.type)

					if is_paramflag_fout (arguments.item.flags) then
						out_variable := True  
						Result.append (out_parameter_set_up (arguments.item.name, counter, visitor))
						return_value.append (out_return_value_set_up (arguments.item.name, counter,  visitor))

					else
						Result.append (in_parameter_set_up (arguments.item.name, counter, visitor))
					end

					visitor := Void

					arguments.forth
					counter := counter - 1			
				end
			end

			Result.append (New_line_tab)
			Result.append ("args.rgvarg")
			Result.append (Space_equal_space)
			Result.append (Arguments_name)
			Result.append (Semicolon)

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

			if not free_arguments.empty then
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
			valid_name: not name.empty
			valid_position: position >= 0
		local
			tmp_string: STRING
			type: INTEGER
		do
			type := visitor.vt_type

			Result := clone (New_line_tab)
			if visitor.need_generate_ce then
				Result.append (Generated_ce_mapper)
			else
				Result.append (Ce_mapper)
			end
			Result.append (Dot)
			Result.append (visitor.ce_function_name)
			Result.append (Space_open_parenthesis)

			if visitor.is_basic_type or not is_byref (type) then
				add_warning (Current, Not_pointer_type)
			elseif visitor.is_enumeration then
				add_warning (Current, Invalid_use_of_enumeration)
			else
				if visitor.is_basic_type_ref then
					Result.append (out_value_set_up (position, vartype_namer.variant_field_name (type)))
					Result.append (Comma_space)
					Result.append (name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
				elseif is_boolean (type) then
					Result.append (out_value_set_up (position, vartype_namer.variant_field_name (type)))
					Result.append (Comma_space)
					Result.append (name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
				else
					Result.append (out_value_set_up (position, vartype_namer.variant_field_name (type)))
					Result.append (Comma_space)
					Result.append (name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
				end	
			end
		end

	out_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "out" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.empty
		local
			tmp_string: STRING
			type: INTEGER
		do
			type := visitor.vt_type

			Result := clone (New_line_tab)
			Result.append (argument_type_set_up (position, type))

			Result.append (visitor.c_type)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (name)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Tmp_clause)
			Result.append (name)
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
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			tmp_string := clone (Tmp_clause)
			tmp_string.append (name)

			Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (type), tmp_string, visitor))	

		end

	in_parameter_set_up (name: STRING; position: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "in" parameter.
		require
			non_void_visitor: visitor /= Void
			non_void_name: name /= Void
			valid_name: not name.empty
		local
			tmp_value: STRING
			type: INTEGER
		do
			type := visitor.vt_type

			Result := clone (New_line_tab)
			Result.append (argument_type_set_up (position, type))

			if visitor.is_basic_type or visitor.is_enumeration then
				create tmp_value.make (0)
				if is_boolean (type) then
					tmp_value.append (Open_parenthesis)
					tmp_value.append (visitor.c_type)
					tmp_value.append (Close_parenthesis)
					tmp_value.append (Ce_mapper)
					tmp_value.append (Dot)
					tmp_value.append (visitor.ec_function_name)
					tmp_value.append (Space_open_parenthesis)
					tmp_value.append (name)
					tmp_value.append (Close_parenthesis)
				else
					tmp_value.append (name)
				end
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (type), tmp_value, visitor))
				
			elseif visitor.is_basic_type_ref then

				tmp_value := clone (Tmp_clause)
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

				Result.append (Ec_mapper)
				Result.append (Dot)
				Result.append (visitor.ec_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space_open_parenthesis)
				Result.append (name)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (type), tmp_value, visitor))

			else
				if is_byref (type) then
					tmp_value := clone (Tmp_clause)
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

					Result.append (Ec_mapper)
					Result.append (Dot)
					Result.append (visitor.ec_function_name)
					Result.append (Space_open_parenthesis)
					Result.append (Eif_access)
					Result.append (Space_open_parenthesis)
					Result.append (name)
					Result.append (Close_parenthesis)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab)
				else
					tmp_value := clone (Ec_mapper)
					tmp_value.append (Dot)
					tmp_value.append (visitor.ec_function_name)
					tmp_value.append (Space_open_parenthesis)
					tmp_value.append (Eif_access)
					tmp_value.append (Space_open_parenthesis)
					tmp_value.append (name)
					tmp_value.append (Close_parenthesis)
					tmp_value.append (Close_parenthesis)
				end

				Result.append (argument_value_set_up (position,  vartype_namer.variant_field_name (type), tmp_value, visitor))
			end
		end
		
	out_value_set_up (position: INTEGER; attribute_name: STRING): STRING is
			-- Set up code for argument variable
		require
			valid_position: position >= 0
			non_void_attribute_name: attribute_name /= Void
			valid_name: not attribute_name.empty
		do
			Result := clone (Arguments_name)

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
			Result := clone (Arguments_variable_name)
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
			valid_argument_type: not Result.empty
		end

	argument_value_set_up (position: INTEGER; attribute_name, value: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set parameter value for dispatch function call
		require
			non_void_visitor: visitor /= Void
			non_void_name: attribute_name /= Void
			valid_name: not attribute_name.empty
			non_void_value: value /= Void
			valid_value: not value.empty
		do
			Result := out_value_set_up (position, attribute_name)
			Result.append (Space_equal_space)
			Result.append (Open_parenthesis)
			Result.append (visitor.c_type)
			Result.append (Close_parenthesis)
			Result.append (value)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		ensure
			non_void_argument_value: Result /= Void
			valid_argument_value: not Result.empty
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
