indexing
	description: "Cpp client function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR	

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; interface_name: STRING; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate function.
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.empty
		local
			ccom_func_name: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create ccom_feature_writer.make
			create c_header_files.make
			create visitor

			func_desc := a_descriptor

			-- Set function name used in ccom
			if a_descriptor.coclass_eiffel_names.has (a_component_descriptor.name) then
				ccom_func_name := external_feature_name (a_descriptor.coclass_eiffel_names.item (a_component_descriptor.name))
			else
				ccom_func_name := external_feature_name (a_descriptor.interface_eiffel_name)
			end
			ccom_feature_writer.set_name (ccom_func_name)
			ccom_feature_writer.set_comment (func_desc.description)

			-- Argument for ccom feature
			set_client_result_type_and_signature

			ccom_feature_writer.set_body (feature_body (interface_name))

			if ccom_feature_writer.result_type = Void then
				ccom_feature_writer.set_result_type (clone ("void"))
			end
		ensure
			non_void_feature_writer: ccom_feature_writer /= Void
			non_void_feature_name: ccom_feature_writer.name /= Void
			valid_feature_name: not ccom_feature_writer.name.empty
			non_void_feature_result_type: ccom_feature_writer.result_type /= Void
			valid_feature_result_type: not ccom_feature_writer.result_type.empty
			non_void_feature_comment: ccom_feature_writer.comment /= Void
			valid_feature_comment: not ccom_feature_writer.comment.empty
			non_void_header_files: c_header_files /= Void
			function_descriptor_set: func_desc /= Void
		end


feature {NONE} -- Implementation

	feature_body (interface_name: STRING): STRING is
			-- Ccom client feature body
		require
			non_void_interface_name: interface_name /= Void 
			valid_interface_name: not interface_name.empty
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			out_value, signature, free_memory, variables, return_value: STRING
			tmp_safearray: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR
			pointer_var: LINKED_LIST[STRING]
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
			tmp_name: STRING
		do
			Result := check_interface_pointer (interface_name)
			create return_value.make (0)

			if func_desc.argument_count > 0 then
				create pointer_var.make


				-- Create call function argument list
				arguments := func_desc.arguments
	
				out_value := clone (New_line_tab)
				signature := clone (Open_parenthesis)
				free_memory := clone (New_line_tab)
				variables := clone (New_line_tab)

				from
					arguments.start
				until
					arguments.after
				loop
					create visitor
					visitor.visit (arguments.item.type)

					if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
						c_header_files.force (visitor.c_header_file)
					end
					if is_paramflag_fretval (arguments.item.flags) then

						return_value.append (New_line_tab)
						return_value.append (Return)

						if visitor.is_structure_pointer or visitor.is_interface_pointer then
							variables.append (retval_struct_pointer_set_up (visitor))
							
							signature.append (Space)
							signature.append (Return_value_name)
							signature.append (Comma)
							
							return_value.append (Space)
							return_value.append (Eif_wean)
							return_value.append (Space_open_parenthesis)
							return_value.append (C_result)
							return_value.append (Close_parenthesis)
							
						else
							pointed_descriptor ?= arguments.item.type
							if pointed_descriptor /= Void then
								create visitor
								visitor.visit (pointed_descriptor.pointed_data_type_descriptor)

								signature.append (Space)
								signature.append (Ampersand)
								signature.append (Return_value_name)
								signature.append (Comma)
							else
								signature.append (Space)
								signature.append (Return_value_name)
								signature.append (Comma)
							end

							variables.append (visitor.c_type)
							variables.append (Space)
							variables.append (Return_value_name)
							variables.append (visitor.c_post_type)
							variables.append (Space_equal_space)
							variables.append (Zero)
							variables.append (Semicolon)
							variables.append (New_line_tab)

							return_value.append (return_value_setup (visitor, Return_value_name))
						end
						return_value.append (Semicolon)
						return_value.append (New_line_tab)
	
					elseif is_paramflag_fout (arguments.item.flags) or is_paramflag_fin (arguments.item.flags) then  
						if 
							visitor.is_interface_pointer or
							visitor.is_structure_pointer or 
							visitor.is_array_basic_type or
							visitor.is_coclass_pointer
						then
							signature.append (arguments.item.name)

						elseif 
							visitor.is_interface or 
							visitor.is_coclass or 
							visitor.is_structure 
						then
							signature.append (Asterisk)
							signature.append (Open_parenthesis)
							signature.append (visitor.c_type)
							signature.append (Asterisk)
							signature.append (Close_parenthesis)
							signature.append (arguments.item.name)

						else
							variables.append (visitor.c_type)
							variables.append (Space)

							if visitor.is_array_type then
								variables.append (Asterisk)
							end

							variables.append (Tmp_clause)
							variables.append (arguments.item.name)

							if not visitor.is_array_type then
								variables.append (visitor.c_post_type)
							end
							variables.append (Space_equal_space)
							variables.append (Zero)
							variables.append (Semicolon)
							variables.append (New_line_tab)

							signature.append (Tmp_clause)
							signature.append (arguments.item.name)
	
							variables.append ( in_out_parameter_set_up (arguments.item.name, arguments.item.type, visitor))
							variables.append (New_line_tab)
							if is_paramflag_fout (arguments.item.flags) then
								out_value.append ( out_set_up (arguments.item.name, arguments.item.type.type, visitor))
							else
								tmp_name := clone (Tmp_clause)
								tmp_name.append (arguments.item.name)
								if is_safearray (arguments.item.type.type) then
									free_memory.append (free_safearray_set_up (tmp_name))

								elseif (arguments.item.type.type = Vt_bstr) then
									free_memory.append (free_bstr_set_up (tmp_name))
								end
							end
						end
						signature.append (Comma)
					end
					
					arguments.forth
					visitor := Void
				end -- loop
				
				-- Format signature
				if not signature.empty then
					signature.remove (signature.count)
				end
				signature.append (Close_parenthesis)
				signature.append (Semicolon)
				signature.append (New_line)			

				-- Set up body
				Result.append (variables)
				Result.append (New_line_tab)
				if  (func_desc.return_type.type = Vt_hresult) then
					Result.append (Hresult_variable_name)
					Result.append (Space_equal_space)
				elseif not (func_desc.return_type.type = Vt_void) then
					create visitor
					visitor.visit (func_desc.return_type)
					Result.append (visitor.c_type)
					Result.append (Space)
					Result.append (C_result)
					Result.append (Space_equal_space)

					return_value.append (New_line_tab)
					return_value.append (Return)
					return_value.append (return_value_setup (visitor, C_result))
					return_value.append (Semicolon)
					return_value.append (New_line_tab)
				end
				Result.append (Interface_variable_prepend)
				Result.append (interface_name)
				Result.append (Struct_selection_operator)
				Result.append (func_desc.name)
				Result.append (signature)
				if  (func_desc.return_type.type = Vt_hresult) then
					Result.append (examine_hresult (Hresult_variable_name))
				end
				Result.append (out_value)
				Result.append (free_memory)
				if not return_value.empty then
					Result.append (New_line)
					Result.append (return_value)
				end
			else
				Result.append (New_line_tab)
				if  (func_desc.return_type.type = Vt_hresult) then
					Result.append (Hresult_variable_name)
					Result.append (Space_equal_space)
				elseif not (func_desc.return_type.type = Vt_void) then
					create visitor
					visitor.visit (func_desc.return_type)
					Result.append (visitor.c_type)
					Result.append (Space)
					Result.append (C_result)
					Result.append (Space_equal_space)
					return_value.append (New_line_tab)
					return_value.append (Return)
					return_value.append (return_value_setup (visitor, C_result))
					return_value.append (Semicolon)
					return_value.append (New_line_tab)
				end
				Result.append (Interface_variable_prepend)
				Result.append (interface_name)
				Result.append (Struct_selection_operator)
				Result.append (func_desc.name)
				Result.append (Space_open_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				if  (func_desc.return_type.type = Vt_hresult) then
					Result.append (examine_hresult (Hresult_variable_name))
				end
				Result.append (tab)
				if not return_value.empty then
					Result.append (New_line)
					Result.append (return_value)
				end

			end
		ensure
			non_void_feature_body: Result /= Void
			valid_feature_body: not Result.empty	
		end  -- function

	free_safearray_set_up (a_name: STRING): STRING is
			-- Free SAFEARRY.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Tab)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append ("SafeArrayDestroy")
			Result.append (Space_open_parenthesis)
			Result.append (a_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (examine_hresult (Hresult_variable_name))
		ensure
			non_void_free: Result /= Void
			valid_free: not Result.empty
		end

	free_bstr_set_up (a_name: STRING): STRING is
			-- Free BSTR.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Tab)
			Result.append ("SysFreeString")
			Result.append (Space_open_parenthesis)
			Result.append (a_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
		ensure
			non_void_free: Result /= Void
			valid_free: not Result.empty
		end

	return_value_setup (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_name: STRING): STRING is
			-- Set up return value.
		require
			non_void_visitor: a_visitor /= Void
		do
			create Result.make (0)
			if a_visitor.is_basic_type then
				Result.append (Space_open_parenthesis)
				Result.append (a_visitor.cecil_type)
				Result.append (Close_parenthesis)
				Result.append (a_name)

			elseif a_visitor.is_enumeration then
				Result.append (Space_open_parenthesis)
				Result.append (Eif_integer)
				Result.append (Close_parenthesis)
				Result.append (a_name)

			else
				Result.append (Space_open_parenthesis)
				if (a_visitor.vt_type = Vt_bool) then
					Result.append (Eif_boolean)
				else
					Result.append (Eif_reference)
				end
				Result.append (Close_parenthesis)
				if a_visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append (Ce_mapper)
				end
				Result.append (Dot)
				Result.append (a_visitor.ce_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (a_name)

				if a_visitor.writable then
					Result.append (Comma_space)
					Result.append (Null)
				end
				Result.append (Close_parenthesis)	
			end
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end

	in_out_parameter_set_up (name: STRING; data_type: WIZARD_DATA_TYPE_DESCRIPTOR; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "in/out" parameter
			--	Arguments
			-- `name' - argument name.
			-- `type' - argument type, see ECOM_VAR_TYPE for values
		require
			non_void_name: name /= Void
			valid_name: not name.empty
			non_void_data_type: data_type /= Void
			non_void_visitor: visitor /= Void
		local
			tmp_string: STRING
			array_data_type: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR
		do
			create Result.make (0)
			if visitor.is_basic_type or visitor.is_enumeration then
				Result.append (Tmp_clause)
				Result.append (name)

				Result.append (Space_equal_space)

				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (name)
				Result.append (Semicolon)

			elseif (visitor.vt_type = Vt_bool) then
				Result.append (Tmp_clause)
				Result.append (name)

				Result.append (Space_equal_space)

				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Ec_mapper)
				Result.append (Dot)
				Result.append (visitor.ec_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)

			elseif 
				visitor.is_structure_pointer or 
				visitor.is_interface_pointer or 
				visitor.is_coclass_pointer 
			then
			else

				Result.append (Tmp_clause)
				Result.append (name)

				Result.append (Space_equal_space)

				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)

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
			end
		ensure
			non_void_inout_parameter: Result /= Void
		end

	out_set_up (name: STRING; type: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "out" parameter
			--	Arguments
			-- `name' - argument name.
			-- `type' - argument type, see ECOM_VAR_TYPE for values
		require
			non_void_name: name /= Void
			valid_name: not name.empty
			non_void_visitor: visitor /= Void
		local
			tmp_string: STRING
		do
			create Result.make (0)
			if visitor.is_basic_type  then

			elseif visitor.is_enumeration then

			elseif visitor.is_structure_pointer then

			else 
				if visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append (Ce_mapper)
				end
				Result.append (Dot)
				Result.append (visitor.ce_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Tmp_clause)
				Result.append (name)
				Result.append (Comma_space)
				Result.append (name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
			end
		ensure
			non_void_out_parameter: Result /= Void
		end

	out_return_value_set_up (name: STRING; type: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up "out" return value
			--	Arguments
			-- `name' - argument name.
			-- `type' - argument type, see ECOM_VAR_TYPE for values
		require
			non_void_name: name /= Void
			valid_name: not name.empty
			non_void_visitor: visitor /= Void
		local
			tmp_string: STRING
		do
			create Result.make (0)
			if visitor.is_basic_type and not is_ptr (visitor.vt_type) then
				message_output.add_warning (Current, message_output.Not_pointer_type)

			elseif visitor.is_enumeration then
				message_output.add_warning (Current, message_output.Invalid_use_of_enumeration)

			else 
				Result.append (Put_procedure_name)
				Result.append (Feature_clause)
				Result.append (Space_open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space_open_parenthesis)
				Result.append (name)
				Result.append (Close_parenthesis)
				Result.append (Comma)
				Result.append (Space_open_parenthesis)
				Result.append (Eif_reference)
				Result.append (Close_parenthesis)
				if visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append (Ce_mapper)
				end
				Result.append (Dot)
				Result.append (visitor.ce_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Tmp_clause)
				Result.append (name)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)

				-- Free resource
				Result.append (Free)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_clause)
				Result.append (Close_parenthesis)

			end
			Result.append (Semicolon)
			Result.append (New_line_tab)
		ensure
			non_void_out_parameter: Result /= Void
			valid_out_parameter: not Result.empty
		end

	retval_struct_pointer_set_up (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Create Eiffel object
		require
			non_void_visitor: visitor /= Void
		do
			create Result.make (0)
			Result.append (New_line_tab);

			-- TYPE_ID tid;

			Result.append (Type_id_variable)
			Result.append (tab)

			-- EIF_OBJECT result;

			Result.append (Eif_object)
			Result.append (Space)
			Result.append (C_result)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- EIF_PROCEDURE make;

			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append (Make_word)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- `visitor.c_type' a_ptr;
			--

			Result.append (visitor.c_type)
			Result.append (Space)
			Result.append (Return_value_name)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (New_line_tab)

			-- tid = eif_type_id ("`visitor.eiffel_type'");

			Result.append (Type_id_variable_name)
			Result.append (Space_equal_space)
			Result.append (Eif_type_id_function_name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Double_quote)
			Result.append (visitor.eiffel_type)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- make = eif_procedure ("make", tid);

			Result.append (Make_word)
			Result.append (Space_equal_space)
			Result.append (Eif_procedure_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			Result.append (Make_word)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- result = eif_create (tid);

			Result.append (C_result)
			Result.append (Space_equal_space)
			Result.append (Eif_create)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Type_id_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- make (eif_access (result));

			Result.append (Make_word)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (C_result)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- 'return_value_name' = eif_field (eif_access (result), "item", EIF_POINTER)

			Result.append (Return_value_name)
			Result.append (Space_equal_space)
			Result.append (Open_parenthesis)
			Result.append (visitor.c_type)
			Result.append (Close_parenthesis)
			Result.append (Eif_field)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (C_result)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			Result.append (Double_quote)
			Result.append (Item_clause)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Eif_pointer)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

		ensure
			non_void_retval: Result /= Void
			valid_retval: not Result.empty
		end

end -- class WIZARD_CPP_CLIENT_FUNCTION_GENERATOR

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
