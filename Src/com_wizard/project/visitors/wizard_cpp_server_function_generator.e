indexing
	description: "Cpp server function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_SERVER_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_FUNCTION_GENERATOR

feature -- Basic operations

	generate (a_coclass_name: STRING; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			--Generate C server feature
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_coclass: a_coclass_name /= Void
			valid_coclass_name: not a_coclass_name.empty
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			tmp_signature, tmp_string: STRING
		do
			func_desc := a_descriptor
			coclass_name := a_coclass_name

			create ccom_feature_writer.make
			create c_header_files.make

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment (func_desc.description)

			-- Set return type.
			if func_desc.return_type /= Void then
				create visitor
				visitor.visit (func_desc.return_type)

				if is_hresult (visitor.vt_type) then
					ccom_feature_writer.set_result_type (Std_method_imp)
				else
					tmp_string := clone (Std_method_imp)
					tmp_string.append (Underscore)
					tmp_string.append (Open_parenthesis)
					tmp_string.append (visitor.c_type)
					tmp_string.append (Close_parenthesis)
					ccom_feature_writer.set_result_type (tmp_string)
				end
			end

			-- Set signature.
			ccom_feature_writer.set_signature (signature)

			-- Set body.
			ccom_feature_writer.set_body (body)

		ensure
			function_descriptor_set: func_desc /= Void
			non_void_writer: ccom_feature_writer /= Void
			valid_writer: ccom_feature_writer.can_generate
		end

feature {NONE} -- Access

	coclass_name: STRING
			-- Coclass name

feature {NONE} -- Implementation

	is_function: BOOLEAN
			-- Is feature a function?

	body: STRING is
			-- Feature body
		local
			tmp_string, cecil_call, arguments, variables, return_value, free_object, protect_object: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_data_type_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			Result := clone (Ecatch)

			if func_desc.argument_count > 0 then
				arguments := clone (Space_open_parenthesis)
				arguments.append (Eif_access)
				arguments.append (Space_open_parenthesis)
				arguments.append (Eiffel_object)
				arguments.append (Close_parenthesis)

				create cecil_call.make (0)
				create variables.make (0)				
				create return_value.make (0)
				create free_object.make (0)

				from
					func_desc.arguments.start
				until
					func_desc.arguments.after
				loop
					create visitor

					if is_paramflag_fretval (func_desc.arguments.item.flags) then
						pointed_data_type_descriptor ?= func_desc.arguments.item.type

						if pointed_data_type_descriptor /= Void then
							visitor.visit (pointed_data_type_descriptor.pointed_data_type_descriptor)
						else
							visitor.visit (func_desc.arguments.item.type)
						end
						is_function := True
						return_value.append (return_value_set_up (func_desc.arguments.item.name, func_desc.arguments.item.type))
						return_value.append (New_line_tab)

						cecil_call.append (cecil_function_set_up (visitor))

						if not visitor.is_basic_type and not (not visitor.is_pointed and is_boolean (visitor.vt_type)) then
							protect_object := clone (Eif_object)
							protect_object.append (Space)
							protect_object.append (Tmp_clause)
							protect_object.append (func_desc.arguments.item.name)
							protect_object.append (Space_equal_space)
							protect_object.append (Eif_protect)
							protect_object.append (Space_open_parenthesis)
							protect_object.append (Return_value_name)
							protect_object.append (Close_parenthesis)
							protect_object.append (Semicolon)
							protect_object.append (New_line_tab)
						end
					else
						visitor.visit (func_desc.arguments.item.type)

						if is_paramflag_fout (func_desc.arguments.item.flags) then
							
							if not visitor.is_pointed then
								tmp_string := clone (visitor.c_type)
								tmp_string.append (visitor.c_post_type)
								tmp_string.append (Struct_selection_operator)
								tmp_string.append (message_output.Not_pointer_type)
				 				message_output.add_warning (Current, tmp_string)
							end	
							variables.append (out_variable_set_up (func_desc.arguments.item.name, visitor))
							variables.append (New_line_tab)
							return_value.append (out_value_set_up (func_desc.arguments.item.name, visitor))
							return_value.append (New_line_tab)

							arguments.append (Comma_space)
							arguments.append (Eif_access)
							arguments.append (Space_open_parenthesis)
							arguments.append (Tmp_clause)
							arguments.append (func_desc.arguments.item.name)
							arguments.append (Close_parenthesis)
						else
							variables.append (in_variable_set_up (func_desc.arguments.item.name, visitor))
							variables.append (New_line_tab)
							if visitor.is_basic_type  then
								arguments.append (Comma_space)
								arguments.append (Open_parenthesis)
								arguments.append (visitor.cecil_type)
								arguments.append (Close_parenthesis)
								arguments.append (Tmp_clause)
								arguments.append (func_desc.arguments.item.name)
							elseif not visitor.is_pointed and then is_boolean (visitor.vt_type) then
								arguments.append (Comma_space)
								arguments.append (Open_parenthesis)
								arguments.append (Eif_boolean)
								arguments.append (Close_parenthesis)
								arguments.append (Tmp_clause)
								arguments.append (func_desc.arguments.item.name)
							else
								arguments.append (Comma)
								arguments.append (Eif_access)
								arguments.append (Space_open_parenthesis)
								arguments.append (Tmp_clause)
								arguments.append (func_desc.arguments.item.name)
								arguments.append (Close_parenthesis)
							end
							if not visitor.is_basic_type and not (not visitor.is_pointed and is_boolean (visitor.vt_type)) then
								free_object.append (Eif_wean)
								free_object.append (Space_open_parenthesis)
								free_object.append (Tmp_clause)
								free_object.append (func_desc.arguments.item.name)
								free_object.append (Close_parenthesis)
								free_object.append (Semicolon)
								free_object.append (New_line_tab)
							end
						end
					end

					func_desc.arguments.forth
				end
			else
				Result.append (empty_argument_body)
			end

			if func_desc.argument_count > 0 then
				if cecil_call.empty then
					cecil_call.append (cecil_procedure_set_up)
				end

				arguments.append (Close_parenthesis)
				arguments.append (Semicolon)

				Result.append (New_line_tab)
				Result.append (variables)
				Result.append (New_line_tab)
				Result.append (cecil_call)
				Result.append (arguments)
				Result.append (New_line_tab)

				if protect_object /= Void then
					Result.append (protect_object)
					Result.append (New_line_tab)
				end

				Result.append (return_value)
				Result.append (free_object)
			end
			Result.append (New_line_tab)
			Result.append (End_ecatch)
			Result.append (Return)
			Result.append (Space)
			Result.append (S_ok)
			Result.append (Semicolon)
		end

	in_variable_set_up (arg_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set in variable
		require
			non_void_visitor: visitor /= Void
			non_void_arg_name: arg_name /= Void
			valid_arg_name: not arg_name.empty
		do
			create Result.make (0)
			if visitor.is_basic_type then
				Result.append (visitor.cecil_type)
				Result.append (Space)
				Result.append (Tmp_clause)
				Result.append (arg_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)
				Result.append (visitor.cecil_type)
				Result.append (Close_parenthesis)

				Result.append (arg_name)
			elseif is_boolean (visitor.vt_type) and not visitor.is_pointed then
				Result.append (Eif_boolean)
				Result.append (Space)
				Result.append (Tmp_clause)
				Result.append (arg_name)
				Result.append (Space_equal_space)
				Result.append (Ce_mapper)
				Result.append (Dot)
				Result.append (visitor.ce_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (arg_name)
				Result.append (Close_parenthesis)
			else
				Result.append (Eif_object)
				Result.append (Space)
				Result.append (Tmp_clause)
				Result.append (arg_name)
				Result.append (Semicolon)
				Result.append (New_line_tab)

				Result.append (Tmp_clause)
				Result.append (arg_name)
				Result.append (Space_equal_space)

				Result.append (Eif_protect)
				Result.append (Space_open_parenthesis)

				if visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append (Ce_mapper)
				end

				Result.append (Dot)
				Result.append (visitor.ce_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (arg_name)

				if visitor.writable then
					Result.append (Comma_space)
					Result.append (Null)
				end
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
			end
			Result.append (Semicolon)
		end

	out_variable_set_up (arg_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set inout variable
		require
			non_void_visitor: visitor /= Void
			non_void_string: arg_name /= Void
			valid_arg_name: not arg_name.empty
		do
			create Result.make (0)

			Result.append (Eif_object)
			Result.append (Space)
			Result.append (Tmp_clause)
			Result.append (arg_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Tmp_clause)
			Result.append (arg_name)
			Result.append (Space_equal_space)
			Result.append (Eif_protect)
			Result.append (Space_open_parenthesis)
			if visitor.need_generate_ce then
				Result.append (Generated_ce_mapper)
			else
				Result.append (Ce_mapper)
			end

			Result.append (Dot)
			Result.append (visitor.ce_function_name)
			Result.append (Space_open_parenthesis)

			if is_unsigned_long (visitor.vt_type) then
				Result.append (Open_parenthesis)
				Result.append ("long *")
				Result.append (Close_parenthesis)
			elseif is_unsigned_short (visitor.vt_type) then
				Result.append (Open_parenthesis)
				Result.append ("short *")
				Result.append (Close_parenthesis)	
			elseif is_character (visitor.vt_type) then
				Result.append (Open_parenthesis)
				Result.append (Eif_character)
				Result.append (Asterisk)
				Result.append (Close_parenthesis)
			end

			Result.append (arg_name)

			if visitor.writable then
				Result.append (Comma_space)
				Result.append (Null)
			end
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		end

	out_value_set_up (arg_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to return out value
		require
			non_void_visitor: visitor /= Void
			non_void_name: arg_name /= Void
			valid_arg_name: not arg_name.empty
		do
			create Result.make (0)

			if not visitor.is_array_basic_type and not visitor.is_structure_pointer then
				if visitor.need_generate_ec then
					Result.append (Generated_ec_mapper)
				else
					Result.append (Ec_mapper)
				end
				Result.append (Dot)
				Result.append (visitor.ec_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Eif_wean)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_clause)
				Result.append (arg_name)
				Result.append (Close_parenthesis)
				Result.append (Comma_space)

				if is_unsigned_long (visitor.vt_type) then
					Result.append (Open_parenthesis)
					Result.append ("long *")
					Result.append (Close_parenthesis)
				elseif is_unsigned_short (visitor.vt_type) then
					Result.append (Open_parenthesis)
					Result.append ("short *")
					Result.append (Close_parenthesis)	
				elseif is_unsigned_char (visitor.vt_type) then
					Result.append (Open_parenthesis)
					Result.append ("char *")
					Result.append (Close_parenthesis)
				end

				Result.append (arg_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)

			end
		end

	return_value_set_up ( arg_name: STRING; type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR): STRING is
			-- Code to return value
		require
			non_void_name: arg_name /= Void
			valid_arg_name: not arg_name.empty
			non_void_descriptor: type_descriptor /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_type_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			create visitor

			pointed_type_descriptor ?= type_descriptor
			if pointed_type_descriptor /= Void then
				visitor.visit (pointed_type_descriptor.pointed_data_type_descriptor)
			else
				visitor.visit (type_descriptor)
			end

			Result := clone (Asterisk)
			Result.append (arg_name)
			Result.append (Space_equal_space)

			if visitor.is_basic_type then
				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Return_value_name)
			else
				if visitor.need_generate_ec then
					Result.append (Generated_ec_mapper)
				else
					Result.append (Ec_mapper)
				end
				Result.append (Dot)
				Result.append (visitor.ec_function_name)
				Result.append (Space_open_parenthesis)

				if is_boolean (visitor.vt_type) and not visitor.is_pointed then
					Result.append (Return_value_name)
				else
					Result.append (Eif_wean)
					Result.append (Space_open_parenthesis)
					Result.append (Return_value_name)
					Result.append (Close_parenthesis)
				end
				if visitor.writable then
					Result.append (Comma_space)
					Result.append (Null)
				end
				Result.append (Close_parenthesis)
			end

			Result.append (Semicolon)
		end

	cecil_procedure_set_up: STRING is
			-- Cecil procedure call
		do
			-- EIF_PROCEDURE eiffel_procedure
			Result := clone (Eif_procedure)
			Result.append (Space)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eiffel_procedure = eif_procedure ("func_name", tid)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Space_equal_space)
			Result.append (Eif_procedure_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)

			if func_desc.coclass_eiffel_names.has (coclass_name) then
				Result.append (func_desc.coclass_eiffel_names.item (coclass_name))
			else
				Result.append (func_desc.interface_eiffel_name)
			end

			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eiffel_procedure (eif_access (eiffel_object),
			Result.append (Eiffel_procedure_variable_name)
		end

	cecil_function_set_up (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up eif_function call
		require
			non_void_visitor: visitor /= Void
		do
			create Result.make (0)
			if visitor.is_basic_type then
				if is_int (visitor.vt_type) or is_integer2 (visitor.vt_type) or is_integer4 (visitor.vt_type) or is_unsigned_int (visitor.vt_type)
						or is_unsigned_long (visitor.vt_type) or is_unsigned_short (visitor.vt_type) then
					Result := cecil_function_code (Eif_integer_function, Eif_integer_function_name)
					Result.append (New_line_tab)
					Result.append (Eif_integer)
				elseif is_character (visitor.vt_type) or is_unsigned_char (visitor.vt_type) then
					Result := cecil_function_code (Eif_character_function, Eif_character_function_name)	
					Result.append (New_line_tab)
					Result.append (Eif_character)
				elseif is_real4 (visitor.vt_type) then
					Result := cecil_function_code (Eif_real_function, Eif_real_function_name)
					Result.append (New_line_tab)
					Result.append (Eif_real)
				elseif is_real8 (visitor.vt_type) then
					Result := cecil_function_code (Eif_double_function, Eif_double_function_name)
					Result.append (New_line_tab)
					Result.append (Eif_double)
				end
			elseif is_boolean (visitor.vt_type) and not visitor.is_pointed then
				Result := cecil_function_code (Eif_boolean_function, Eif_boolean_function_name)
				Result.append (New_line_tab)
				Result.append (Eif_boolean)
			else
				Result := cecil_function_code (Eif_reference_function, Eif_reference_function_name)
				Result.append (New_line_tab)
				Result.append (Eif_reference)
			end
			Result.append (Space)
			Result.append (Return_value_name)
			Result.append (Space_equal_space)
			Result.append (Eiffel_function_variable_name)
		end

	cecil_function_code (function_type, function_name: STRING): STRING is
			-- Cecil code
		require
			non_void_type: function_type /= Void
			non_void_name: function_name /= Void
			not_empty: not function_type.empty and then not function_name.empty
		do
			Result := Clone (function_type)
			Result.append (Space)
			Result.append (Eiffel_function_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Eiffel_function_variable_name)
			Result.append (Space_equal_space)
			Result.append (function_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)

			if func_desc.coclass_eiffel_names.has (coclass_name) then
				Result.append (func_desc.coclass_eiffel_names.item (coclass_name))
			else
				Result.append (func_desc.interface_eiffel_name)
			end

			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		end

	empty_argument_body: STRING is
			-- Eiffel procedure call body
		do
			Result := clone (Eif_procedure)
			Result.append (Space)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)


			Result.append (Eiffel_procedure_variable_name)
			Result.append (Space_equal_space)
			Result.append (Eif_procedure_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			if func_desc.coclass_eiffel_names.has (coclass_name) then
				Result.append (func_desc.coclass_eiffel_names.item (coclass_name))
			else
				Result.append (func_desc.interface_eiffel_name)
			end

			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		end

	signature: STRING is
			-- Set server signature
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (0)
			if not func_desc.arguments.empty then
				from
					func_desc.arguments.start
				until
					func_desc.arguments.off
				loop
					create visitor
					visitor.visit (func_desc.arguments.item.type)

					Result.append (Beginning_comment_paramflag)

					if is_paramflag_fretval (func_desc.arguments.item.flags) then
						Result.append (Out_keyword)
						Result.append (Comma_space)
						Result.append (Retval)
					elseif is_paramflag_fout (func_desc.arguments.item.flags) then
						if is_paramflag_fin (func_desc.arguments.item.flags) then
							Result.append (Inout)
						else
							Result.append (Out_keyword)
						end
					else
						Result.append (In)
					end
					Result.append (End_comment_paramflag)

					Result.append (visitor.c_type)
					Result.append (Space)

					if visitor.is_array_basic_type or visitor.is_array_type then
						Result.append (Asterisk)
					end

					Result.append (func_desc.arguments.item.name)

					Result.append (Comma)
					func_desc.arguments.forth
				end

				if Result.item (Result.count).is_equal (',') then
					Result.remove (Result.count)
				end
			else
				Result.append (Void_c_keyword)					
			end
		end

end -- class WIZARD_CPP_SERVER_FUNCTION_GENERATOR
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
