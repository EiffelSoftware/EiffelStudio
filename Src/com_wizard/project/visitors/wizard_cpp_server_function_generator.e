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

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			--Generate C server feature
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_coclass: a_component /= Void
		do
			func_desc := a_descriptor
			coclass_name := a_component.name

			create ccom_feature_writer.make
			create c_header_files.make

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment (func_desc.description)

			set_vtable_function_return_type
			ccom_feature_writer.set_signature (vtable_signature)
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

	is_return_hresult: BOOLEAN is
			-- Is function returning HRESULT?
		do
			Result := func_desc.return_type.visitor.vt_type = Vt_hresult
		end

	is_return_data: BOOLEAN is
			-- Is function returning data?
		do
			Result := not is_return_hresult and
					not (func_desc.return_type.visitor.vt_type = Vt_void or
					func_desc.return_type.visitor.vt_type = Vt_empty or
					func_desc.return_type.visitor.vt_type = Vt_null)
		end

	cecil_call: STRING
			-- 
	
	arguments: STRING 
			-- 
	
	variables: STRING
			-- 
	
	return_value: STRING
			-- 
	
	free_object: STRING
			-- 
	
	protect_object: STRING
			-- 

	return_type: STRING
			-- 
	
	body: STRING is
			-- Feature body
		do
			create Result.make (10000)
			if is_return_hresult then
				Result.append (Ecatch)
			end
			create cecil_call.make (1000)
			create return_value.make (1000)
			create free_object.make (1000)
			create variables.make (1000)
			
			if 
				func_desc.argument_count > 0 or
				is_return_data
			then
				generate_cecil_call_code
				
				Result.append (New_line_tab)
				Result.append (variables)
				Result.append (New_line_tab)
				Result.append (cecil_call)
				Result.append (New_line_tab)

				if protect_object /= Void then
					Result.append (protect_object)
					Result.append (New_line_tab)
				end

				Result.append (return_value)
				Result.append (free_object)			
			else
				Result.append (empty_argument_procedure_body)
			end

			Result.append (New_line_tab)

			if is_return_hresult then
				Result.append (End_ecatch)
				Result.append (Return)
				Result.append (Space)
				Result.append (S_ok)
				Result.append (Semicolon)
			elseif is_return_data then
				Result.append (Return)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (func_desc.return_type.visitor.c_type)
				Result.append (Close_parenthesis)

				if 
					func_desc.return_type.visitor.is_basic_type or 
					func_desc.return_type.visitor.is_enumeration 
				then
					Result.append (Tmp_variable_name)
					Result.append (Semicolon)
				else
					if func_desc.return_type.visitor.need_generate_ec then
						Result.append (Generated_ec_mapper)
					else
						Result.append (Ec_mapper)
					end
					Result.append (Dot)
					Result.append (func_desc.return_type.visitor.ec_function_name)
					Result.append (Space_open_parenthesis)
					Result.append (Tmp_variable_name)
					if func_desc.return_type.visitor.writable then
						Result.append (Comma_space)
						Result.append (Null)
					end
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
				end
			end
		end

	generate_cecil_call_code is
			-- Generate CECIL call code.
		require
			has_arguments_or_return_type: not func_desc.arguments.empty or is_return_data
		local
			cursor: CURSOR
		do
			create arguments.make (100)
			create cecil_call.make (1000)
			arguments.append (Space_open_parenthesis)
			arguments.append (Eif_access)
			arguments.append (Space_open_parenthesis)
			arguments.append (Eiffel_object)
			arguments.append (Close_parenthesis)

			if func_desc.argument_count > 0 then
				from
					func_desc.arguments.start
				until
					func_desc.arguments.after
				loop
					cursor := func_desc.arguments.cursor
					
					process_argument (func_desc.arguments.item)

					func_desc.arguments.go_to (cursor)
					func_desc.arguments.forth
				end
			end

			arguments.append (Close_parenthesis)
			arguments.append (Semicolon)

			if is_return_data then
				cecil_call.append (cecil_function_declaration (func_desc.return_type.visitor))
			end
			if cecil_call.empty then
				cecil_call.append (cecil_procedure_set_up)
				cecil_call.append (arguments)
			else
				cecil_call.append (cecil_function_call)
			end

		ensure
		end
		
	process_argument (an_argument: WIZARD_PARAM_DESCRIPTOR) is
			-- Process argument.
		require
			non_void_argument: an_argument /= Void
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_data_type_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if is_paramflag_fretval (an_argument.flags) then
				pointed_data_type_descriptor ?= an_argument.type

				if pointed_data_type_descriptor /= Void then
					visitor := pointed_data_type_descriptor.pointed_data_type_descriptor.visitor
				else
					visitor := an_argument.type.visitor
				end
				is_function := True
				return_value.append (return_value_set_up (an_argument.name, an_argument.type))
				return_value.append (New_line_tab)

				cecil_call.append (cecil_function_declaration (visitor))

			else
				visitor := an_argument.type.visitor
				variables.append (variable_set_up (an_argument.name, visitor))
				variables.append (New_line_tab)

				if 
					visitor.is_basic_type or 
					visitor.is_enumeration or
					visitor.vt_type = Vt_bool
				then
					arguments.append (Comma_space)
					arguments.append (Open_parenthesis)
					arguments.append (visitor.cecil_type)
					arguments.append (Close_parenthesis)
					arguments.append (Tmp_clause)
					arguments.append (an_argument.name)

				else
					arguments.append (Comma_space)
					arguments.append (Eif_access)
					arguments.append (Space_open_parenthesis)
					arguments.append (Tmp_clause)
					arguments.append (an_argument.name)
					arguments.append (Close_parenthesis)
				end
				
				if is_paramflag_fout (an_argument.flags) then					
					return_value.append (out_value_set_up (an_argument.name, visitor))
					return_value.append (New_line_tab)

				else
					if 
						not visitor.is_basic_type and 
						not visitor.is_enumeration and
						not (visitor.vt_type = Vt_bool) 
					then
						free_object.append (Eif_wean)
						free_object.append (Space_open_parenthesis)
						free_object.append (Tmp_clause)
						free_object.append (an_argument.name)
						free_object.append (Close_parenthesis)
						free_object.append (Semicolon)
						free_object.append (New_line_tab)
					end
				end
			end
		end
		
	variable_set_up (arg_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set variable.
		require
			non_void_visitor: visitor /= Void
			non_void_arg_name: arg_name /= Void
			valid_arg_name: not arg_name.empty
		do
			create Result.make (1000)
			if visitor.is_basic_type or visitor.is_enumeration then
				Result.append (visitor.cecil_type)
				Result.append (Space)
				Result.append (Tmp_clause)
				Result.append (arg_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)
				Result.append (visitor.cecil_type)
				Result.append (Close_parenthesis)
				Result.append (arg_name)

			elseif  (visitor.vt_type = Vt_bool) then
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
				Result.append (" = NULL")
				Result.append (Semicolon)
				Result.append (New_line_tab)

				if (visitor.vt_type = Vt_bstr) then
					Result.append (visitor.c_type)
					Result.append (Space)
					Result.append (Tmp_clause)
					Result.append (Tmp_clause)
					Result.append (arg_name)
					Result.append (Space_equal_space)
					Result.append ("SysAllocString")
					Result.append (Space_open_parenthesis)
					Result.append (arg_name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab)
				end 

				if is_array (visitor.vt_type) and not is_byref (visitor.vt_type) then
					Result.append (visitor.c_type)
					Result.append (Space)
					Result.append (Tmp_clause)
					Result.append (Tmp_clause)
					Result.append (arg_name)
					Result.append (Space_equal_space)
					Result.append (Null)
					Result.append (Semicolon)
					Result.append (New_line_tab)

					Result.append ("SafeArrayCopy")
					Result.append (Space_open_parenthesis)
					Result.append (arg_name)
					Result.append (Comma_space)
					Result.append (Ampersand)
					Result.append (Tmp_clause)
					Result.append (Tmp_clause)
					Result.append (arg_name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab)

				end

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
				if is_void (visitor.vt_type) and visitor.eiffel_type.is_equal ("CELL [POINTER]") then
					Result.append ("(void **)")
				end

				if 
					(visitor.vt_type = Vt_bstr) or
					(is_array (visitor.vt_type) and not is_byref (visitor.vt_type))
				then
					Result.append (Tmp_clause)
					Result.append (Tmp_clause)
				end

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

	out_value_set_up (arg_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to return out value
		require
			non_void_visitor: visitor /= Void
			non_void_name: arg_name /= Void
			valid_arg_name: not arg_name.empty
		do
			create Result.make (1000)
				
			if 
				not visitor.is_array_basic_type and 
				not visitor.is_structure_pointer and 
				not visitor.is_interface_pointer and
				not (is_void (visitor.vt_type) and is_byref (visitor.vt_type))
			then
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
			pointed_type_descriptor ?= type_descriptor
			if pointed_type_descriptor /= Void then
				visitor := pointed_type_descriptor.pointed_data_type_descriptor.visitor
			else
				visitor := type_descriptor.visitor
			end

			create Result.make (1000)
			Result.append (Asterisk)
			Result.append (arg_name)
			Result.append (Space_equal_space)

			if visitor.is_basic_type or visitor.is_enumeration then
				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Tmp_variable_name)
			else
				if visitor.need_generate_ec then
					Result.append (Generated_ec_mapper)
				else
					Result.append (Ec_mapper)
				end
				Result.append (Dot)
				Result.append (visitor.ec_function_name)
				Result.append (Space_open_parenthesis)

				Result.append (Tmp_variable_name)
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
			-- EIF_PROCEDURE eiffel_procedure = 0;
			create Result.make (1000)
			Result.append (Eif_procedure)
			Result.append (Space)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (" = 0")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eiffel_procedure = eif_procedure ("func_name", tid);
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
			Result.append (New_line)
			Result.append (New_line_tab)

			-- (FUNCTION_CAST (void, (EIF_REFERENCE, ...)) eiffel_procedure)
			Result.append (function_cast_code (Void_c_keyword))
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Close_parenthesis)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end

	cecil_function_declaration (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up eif_function call
		require
			non_void_visitor: visitor /= Void
		do
			create Result.make (1000)
			if visitor.is_basic_type or visitor.is_enumeration then
				if 
					is_int (visitor.vt_type) or 
					is_integer2 (visitor.vt_type) or 
					is_integer4 (visitor.vt_type) or 
					is_unsigned_int (visitor.vt_type) or 
					is_unsigned_long (visitor.vt_type) or 
					is_unsigned_short (visitor.vt_type) 
				then
					Result := cecil_function_declaration_code (Eif_integer_function, Eif_integer_function_name)

				elseif 
					is_character (visitor.vt_type) or 
					is_unsigned_char (visitor.vt_type) 
				then
					Result := cecil_function_declaration_code (Eif_character_function, Eif_character_function_name)	
					
				elseif is_real4 (visitor.vt_type) then
					Result := cecil_function_declaration_code (Eif_real_function, Eif_real_function_name)
					
				elseif is_real8 (visitor.vt_type) then
					Result := cecil_function_declaration_code (Eif_double_function, Eif_double_function_name)
					
				elseif 
					is_byref (visitor.vt_type) and 
					is_void (visitor.vt_type) 
				then
					Result := cecil_function_declaration_code (Eif_pointer_function, Eif_pointer_function_name)
				end
			elseif (visitor.vt_type = Vt_bool) then
				Result := cecil_function_declaration_code (Eif_boolean_function, Eif_boolean_function_name)
				
			else
				Result := cecil_function_declaration_code (Eif_reference_function, Eif_reference_function_name)
			end
			
			Result.append (New_line_tab)
			if 
				visitor.is_basic_type or 
				visitor.is_enumeration or 
				visitor.vt_type = Vt_bool
			then
				Result.append (visitor.cecil_type)
				return_type := clone (visitor.cecil_type)
			else
				Result.append (Eif_reference)
				return_type := clone (Eif_reference)
			end
			Result.append (Space)
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append ("0;")
			Result.append (New_line_tab)
		end

	cecil_function_call: STRING is
			--
		require
			non_void_arguments: arguments /= Void
		do
			create Result.make (1000)
			Result.append ("if (" + Eiffel_function_variable_name + " != NULL)")
			Result.append (New_line_tab_tab)
			
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append (function_cast_code (return_type))
			Result.append (Eiffel_function_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Arguments)
			Result.append (New_line_tab)
			
			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)
			
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append ("eif_field (")
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			Result.append (Double_quote)
			if func_desc.coclass_eiffel_names.has (coclass_name) then
				Result.append (func_desc.coclass_eiffel_names.item (coclass_name))
			else
				Result.append (func_desc.interface_eiffel_name)
			end
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (return_type)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
		end

	cecil_function_declaration_code (cecil_function_return_type, cecil_function_type: STRING): STRING is
			-- Cecil funcion declaration.
		require
			non_void_type: cecil_function_return_type /= Void
			valid_type: not cecil_function_return_type.empty
			non_void_name: cecil_function_type /= Void
			valid_name:  not cecil_function_type.empty
		do
			create Result.make (1000)
			Result.append (cecil_function_return_type)
			Result.append (Space)
			Result.append (Eiffel_function_variable_name)
			Result.append (" = 0")
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			Result.append (Eiffel_function_variable_name)
			Result.append (Space_equal_space)
			Result.append (cecil_function_type)
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
		ensure
			non_void_code: Result /= Void
			valid_code: not Result.empty
		end

	empty_argument_procedure_body: STRING is
			-- Eiffel procedure call body
		do
			create Result.make (1000)
			Result.append (Eif_procedure)
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
			Result.append (New_line)
			Result.append (New_line_tab)
			Result.append ("(FUNCTION_CAST ( void, (EIF_REFERENCE))")
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

	function_cast_code (a_return_type: STRING): STRING is
			-- Function cast code.
		require
			non_void_return_type: a_return_type /= Void
			valid_return_type: not a_return_type.empty
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			-- (FUNCTION_CAST (`return_type', (EIF_REFERENCE, ...))
			create Result.make (1000)
			Result.append ("(FUNCTION_CAST (")

			Result.append (a_return_type)
			Result.append (Comma)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_reference)

			from
				func_desc.arguments.start
			until
				func_desc.arguments.off
			loop
				if not is_paramflag_fretval (func_desc.arguments.item.flags) then
					visitor := func_desc.arguments.item.type.visitor
					Result.append (Comma_space)
					if 
						visitor.is_basic_type or 
						visitor.is_enumeration or
						visitor.vt_type = Vt_bool
					then
						Result.append (visitor.cecil_type)
					else
						Result.append (Eif_reference)
					end
				end
				func_desc.arguments.forth
			end

			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
		ensure
			non_void_cast: Result /= Void
			valid_cast: not Result.empty
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
