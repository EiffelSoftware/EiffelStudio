indexing
	description: "Cpp client function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_DUAL_CLIENT_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_CLIENT_FUNCTION_GENERATOR
		redefine
			set_client_result_type_and_signature,
			feature_body,
			retval_struct_pointer_set_up
		end

feature {NONE} -- Implementation

	retval_struct_pointer_set_up (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Create Eiffel object
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
			Result.append ("make")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- `visitor.c_type' a_ptr;
			--

			Result.append (visitor.c_type)
			Result.append (Space)
			Result.append (Asterisk)
			Result.append (Return_value_name)
			Result.append (Space_equal_space)
			Result.append (Zero)
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

			-- 'return_variable_name' = eif_field (eif_access (result), "item", EIF_POINTER)

			Result.append (Return_value_name)
			Result.append (Space_equal_space)
			Result.append (Open_parenthesis)
			Result.append (visitor.c_type)
			Result.append (Asterisk)
			Result.append (Close_parenthesis)
			Result.append (Eif_field)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (C_result)
			Result.append (Close_parenthesis)
			Result.append (Double_quote)
			Result.append (Item_clause)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Eif_pointer)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		end


	set_client_result_type_and_signature is
			-- Set result type and signature of function
		local
			visitor : WIZARD_DATA_TYPE_VISITOR
		do
			Precursor

			if not func_desc.return_type.name.is_equal (Void_c_keyword) then
				create visitor
				visitor.visit (func_desc.return_type)

				if visitor.is_basic_type or visitor.is_enumeration then
					ccom_feature_writer.set_result_type (visitor.cecil_type)
				elseif is_boolean (visitor.vt_type) and then not visitor.is_pointed then
					ccom_feature_writer.set_result_type (Eif_boolean)
				else
					ccom_feature_writer.set_result_type (Eif_reference)
				end
			end
		end

	feature_body (interface_name: STRING): STRING is
			-- Ccom client feature body
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			out_value, signature, free_memory, variables, return_value: STRING
			tmp_safearray: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR
			pointer_var: LINKED_LIST[STRING]
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			Result := check_interface_pointer (interface_name)

			if func_desc.argument_count > 0 or else not func_desc.return_type.name.is_equal (Void_c_keyword) then
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

	
					if is_paramflag_fout (arguments.item.flags) then  -- if out or inout
						if 
							visitor.is_interface or 
							visitor.is_structure or 
							visitor.is_interface_pointer or
							visitor.is_structure_pointer or 
							visitor.is_array_basic_type or
							visitor.is_coclass or 
							visitor.is_coclass_pointer
						then
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
							variables.append (Semicolon)
							variables.append (New_line_tab)

							signature.append (Tmp_clause)
							signature.append (arguments.item.name)
	
							variables.append ( in_out_parameter_set_up (arguments.item.name, arguments.item.type, visitor))
							out_value.append ( out_set_up (arguments.item.name, arguments.item.type.type, visitor))
						end
						signature.append (Comma)
	
					else  --if is_paramflag_fin (arguments.item.flags) and not is_paramflag_fout (arguments.item.flags) then -- in parameter
						signature.append (in_parameter_set_up (arguments.item.name, arguments.item.type, visitor))
						signature.append (Comma)
					end
					
					arguments.forth
					visitor := Void
				end -- loop

				if not func_desc.return_type.name.is_equal (Void_c_keyword) then

					create visitor
					visitor.visit (func_desc.return_type)

					return_value := clone (New_line_tab)
					return_value.append (Return)

					if visitor.is_basic_type then
						variables.append (visitor.c_type)
						variables.append (Space)
						variables.append (Return_value_name)
						variables.append (Space_equal_space)
						variables.append (Zero)
						variables.append (Semicolon)
						variables.append (New_line_tab)

						signature.append (Space)
						signature.append (Ampersand)
						signature.append (Return_value_name)

						return_value.append (Space_open_parenthesis)
						return_value.append (visitor.cecil_type)
						return_value.append (Close_parenthesis)
						return_value.append (Return_value_name)

					elseif is_boolean (visitor.vt_type) and then not visitor.is_pointed then
						variables.append (visitor.c_type)
						variables.append (Space)
						variables.append (Return_value_name)
						variables.append (Space_equal_space)
						variables.append (Zero)
						variables.append (Semicolon)
						variables.append (New_line_tab)

						signature.append (Space)
						signature.append (Ampersand)
						signature.append (Return_value_name)

						return_value.append (Space_open_parenthesis)
						return_value.append (Eif_boolean)
						return_value.append (Close_parenthesis)
						return_value.append (Ce_mapper)
						return_value.append (Dot)
						return_value.append (visitor.ce_function_name)
						return_value.append (Space_open_parenthesis)
						return_value.append (Return_value_name)
						return_value.append (Close_parenthesis)
						return_value.append (Semicolon)

					elseif visitor.is_structure or visitor.is_interface then

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
						if visitor.is_pointed then
							variables.append (visitor.c_type)
							variables.append (Space)
							variables.append (Return_value_name)
							variables.append (visitor.c_post_type)
							variables.append (Space_equal_space)
							variables.append (Zero)
							variables.append (Semicolon)
							variables.append (New_line_tab)

							signature.append (Space)
							signature.append (Ampersand)
							signature.append (Return_value_name)
						else
							variables.append (visitor.c_type)
							variables.append (Space)
							variables.append (Return_value_name)
							variables.append (visitor.c_post_type)
							variables.append (Semicolon)
							variables.append (New_line_tab)

							signature.append (Space)
							signature.append (Return_value_name)
						end

						if visitor.is_basic_type then

						elseif visitor.is_enumeration then
							return_value.append (Space_open_parenthesis)
							return_value.append (Eif_integer)
							return_value.append (Close_parenthesis)
							return_value.append (Return_value_name)

						else
							return_value.append (Space_open_parenthesis)
							return_value.append (Eif_reference)
							return_value.append (Close_parenthesis)
							if visitor.need_generate_ce then
								return_value.append (Generated_ce_mapper)
							else
								return_value.append (Ce_mapper)
							end
							return_value.append (Dot)
							return_value.append (visitor.ce_function_name)
							return_value.append (Space_open_parenthesis)
							return_value.append (Return_value_name)

							if visitor.writable then
								return_value.append (Comma_space)
								return_value.append (Null)
							end
							return_value.append (Close_parenthesis)	
						end

					end
					return_value.append (Semicolon)
					return_value.append (New_line_tab)
				else
					if not signature.empty then
						signature.remove (signature.count)
					end
				end

				-- Format signature
				signature.append (Close_parenthesis)
				signature.append (Semicolon)
				signature.append (New_line)			

				-- Set up body
				Result.append (variables)
				Result.append (New_line_tab)

				Result.append (Hresult_variable_name)
				Result.append (Space_equal_space)

				Result.append (Interface_variable_prepend)
				Result.append (interface_name)
				Result.append (Struct_selection_operator)
				Result.append (func_desc.name)
				Result.append (signature)
				Result.append (examine_hresult (Hresult_variable_name))
				Result.append (out_value)
				if return_value /= Void then
					Result.append (New_line)
					Result.append (return_value)
				end
			else
				Result.append (New_line_tab)
				Result.append (Hresult_variable_name)
				Result.append (Space_equal_space)
				Result.append (Interface_variable_prepend)
				Result.append (interface_name)
				Result.append (Struct_selection_operator)
				Result.append (func_desc.name)
				Result.append (Space_open_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				if not (func_desc.return_type.type = Vt_void) then
					Result.append (examine_hresult (Hresult_variable_name))
				end
			end
		end  -- function

end -- class WIZARD_CPP_DUAL_CLIENT_FUNCTION_GENERATOR

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
