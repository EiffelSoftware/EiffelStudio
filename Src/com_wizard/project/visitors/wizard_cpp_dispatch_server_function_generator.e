indexing
	description: "Cpp dispatch server function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_DISPATCH_SERVER_FUNCTION_GENERATOR

inherit
	WIZARD_CPP_SERVER_FUNCTION_GENERATOR
		redefine
			body
		end

feature {NONE} -- Implementation

	body: STRING is
			-- Feature body
		local
			cecil_call, arguments, variables, out_value, free_object: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_data_type_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			Result := clone (Tab)
			Result.append (Ecatch_auto)
			Result.append (Open_parenthesis)
			create visitor

			visitor.visit (func_desc.return_type)
			if not is_void (visitor.vt_type) then
				Result.append (Open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Zero)
			end
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			if func_desc.argument_count > 0 then
				arguments := clone (Space_open_parenthesis)
				arguments.append (Eif_access)
				arguments.append (Space_open_parenthesis)
				arguments.append (Eiffel_object)
				arguments.append (Close_parenthesis)

				create cecil_call.make (0)
				create variables.make (0)				
				create out_value.make (0)
				create free_object.make (0)

				from
					func_desc.arguments.start
				until
					func_desc.arguments.after
				loop
					create visitor
					visitor.visit (func_desc.arguments.item.type)

					if is_paramflag_fout (func_desc.arguments.item.flags) then
						pointed_data_type_descriptor ?= func_desc.arguments.item.type
						if pointed_data_type_descriptor = Void then
			 				message_output.add_warning (Current, message_output.Not_pointer_type)
						end							
						variables.append (out_variable_set_up (func_desc.arguments.item.name, visitor))
						variables.append (New_line_tab)
						out_value.append (out_value_set_up (func_desc.arguments.item.name, visitor))
						out_value.append (New_line_tab)

						arguments.append (Comma_space)

						if is_boolean (visitor.vt_type) or visitor.is_basic_type or else visitor.is_basic_type_ref then
							arguments.append (Tmp_clause)
							arguments.append (func_desc.arguments.item.name)
						else
							arguments.append (Eif_access)
							arguments.append (Space_open_parenthesis)
							arguments.append (Tmp_clause)
							arguments.append (func_desc.arguments.item.name)
							arguments.append (Close_parenthesis)
						end
					else
						variables.append (in_variable_set_up (func_desc.arguments.item.name, visitor))
						variables.append (New_line_tab)
						if visitor.is_basic_type then
							arguments.append (Comma_space)
							arguments.append (Open_parenthesis)
							arguments.append (visitor.cecil_type)
							arguments.append (Close_parenthesis)
							arguments.append (Tmp_clause)
							arguments.append (func_desc.arguments.item.name)
						elseif is_boolean (visitor.vt_type)  then
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
					end
	
					if not visitor.is_basic_type and not is_boolean (visitor.vt_type) then
						free_object.append (Eif_wean)
						free_object.append (Space_open_parenthesis)
						free_object.append (Tmp_clause)
						free_object.append (func_desc.arguments.item.name)
						free_object.append (Close_parenthesis)
						free_object.append (Semicolon)
						free_object.append (New_line_tab)
					end

					func_desc.arguments.forth
				end
			else
				Result.append (empty_argument_body_code)
			end

			create visitor

			visitor.visit (func_desc.return_type)

			if func_desc.argument_count > 0 then
				if visitor.c_type.is_equal (Hresult) then
					cecil_call.append (cecil_procedure_set_up)
				else
					cecil_call.append (cecil_function_set_up (visitor))
				end

				arguments.append (Close_parenthesis)
				arguments.append (Semicolon)

				Result.append (New_line_tab)
				Result.append (variables)
				Result.append (New_line_tab)
				Result.append (cecil_call)
				Result.append (arguments)
				Result.append (New_line_tab)

				if not visitor.is_basic_type and not is_boolean (visitor.vt_type) then
					Result.append (Eif_object)
					Result.append (Space)
					Result.append (Tmp_eif_object)
					Result.append (Space_equal_space)
					Result.append (Eif_protect)
					Result.append (Space_open_parenthesis)
					Result.append (Tmp_variable_name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab)
				end
				
				Result.append (out_value)
				Result.append (free_object)
			end

			Result.append (return_value (visitor))
		end

	empty_argument_body_code: STRING is
			-- Code for empty argument body
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			pointed_data_type: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			create visitor
			visitor.visit (func_desc.return_type)

			if visitor.c_type.is_equal (Hresult) or else visitor.c_type.is_equal (Void_c_keyword) then
				Result := empty_argument_body
			else
				create visitor
				pointed_data_type ?= func_desc.return_type
				if pointed_data_type /= Void then
					visitor.visit (pointed_data_type.pointed_data_type_descriptor)
				else
					visitor.visit (func_desc.return_type)
				end
				Result := cecil_function_set_up (visitor)
				Result.append (Space_open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space_open_parenthesis)
				Result.append (Eiffel_object)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (New_line_tab)
				if not visitor.is_basic_type then
					Result.append (Eif_object)
					Result.append (Space)
					Result.append (Tmp_eif_object)
					Result.append (Space_equal_space)
					Result.append (Eif_protect)
					Result.append (Space_open_parenthesis)
					Result.append (Tmp_variable_name)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					Result.append (New_line_tab)
				end
			end
		end

	return_value (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to return value
		require
			non_void_visitor: visitor /= Void
		do
			Result := clone (End_ecatch)
			Result.append (Return)
			if is_hresult (visitor.vt_type) then
				Result.append (Space)
				Result.append (S_ok)
			elseif visitor.is_basic_type or else visitor.is_basic_type_ref then
				Result.append (Space_open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Tmp_variable_name)
			else
				Result.append (Space)
				if visitor.need_generate_ec then
					Result.append (Generated_ec_mapper)
				else
					Result.append (Ec_mapper)
				end
				Result.append (Dot)
				Result.append (visitor.ec_function_name)
				Result.append (Space_open_parenthesis)
				if is_boolean (visitor.vt_type) then
					Result.append (Tmp_variable_name)
				else
					Result.append (Eif_wean)
					Result.append (Space_open_parenthesis)
					Result.append (Tmp_eif_object)
					Result.append (Close_parenthesis)
				end
				Result.append (Close_parenthesis)
			end

			Result.append (Semicolon)
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
