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
			generate,
			body
		end

feature -- Basic operation

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			--Generate C server feature
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
			tmp_signature, tmp_string: STRING
		do
			func_desc := a_descriptor
			coclass_name := a_component.name

			create ccom_feature_writer.make
			create c_header_files.make

			ccom_feature_writer.set_name (func_desc.name)
			ccom_feature_writer.set_comment (func_desc.description)

			ccom_feature_writer.set_result_type (Std_method_imp)
			ccom_feature_writer.set_signature (signature)
			ccom_feature_writer.set_body (body)
		end

feature {NONE} -- Implementation

	signature: STRING is
			-- Set server signature
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (1000)
			if func_desc.arguments.empty and func_desc.return_type.name.is_equal (Void_c_keyword) then
				Result.append (Void_c_keyword)					
			else
				from
					func_desc.arguments.start
				until
					func_desc.arguments.off
				loop
					visitor := func_desc.arguments.item.type.visitor

					Result.append (Beginning_comment_paramflag)

					if is_paramflag_fout (func_desc.arguments.item.flags) then
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

				if func_desc.return_type.name.is_equal (Void_c_keyword) then
					Result.remove (Result.count)
				else
					visitor := func_desc.return_type.visitor
					Result.append (Beginning_comment_paramflag)
					Result.append (Out_keyword)
					Result.append (Comma_space)
					Result.append (Retval)
					Result.append (End_comment_paramflag)
					Result.append (visitor.c_type)
					Result.append (Space)
					Result.append (Asterisk)
					Result.append (Return_value_name)
				end
			end
		end

	body: STRING is
			-- Feature body
		local
			out_value: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create Result.make (100000)
			Result.append (Ecatch)

			if func_desc.argument_count = 0 and func_desc.return_type.name.is_equal (Void_c_keyword) then
				Result.append (New_line_tab)
				Result.append (empty_argument_procedure_body)
			else
				create arguments.make (500)
				arguments.append (Space_open_parenthesis)
				arguments.append (Eif_access)
				arguments.append (Space_open_parenthesis)
				arguments.append (Eiffel_object)
				arguments.append (Close_parenthesis)

				create variables.make (1000)
				create out_value.make (10000)
				create free_object.make (10000)

				from
					func_desc.arguments.start
				until
					func_desc.arguments.after
				loop
					visitor := func_desc.arguments.item.type.visitor

					if is_paramflag_fout (func_desc.arguments.item.flags) then
						variables.append (variable_set_up (func_desc.arguments.item.name, visitor))
						variables.append (New_line_tab)
						out_value.append (out_value_set_up (func_desc.arguments.item.name, visitor))
						out_value.append (New_line_tab)

						arguments.append (Comma_space)

						if visitor.is_basic_type or visitor.is_enumeration then
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
						variables.append (variable_set_up (func_desc.arguments.item.name, visitor))
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
							arguments.append (func_desc.arguments.item.name)
						
						else
							arguments.append (Comma)
							arguments.append (Eif_access)
							arguments.append (Space_open_parenthesis)
							arguments.append (Tmp_clause)
							arguments.append (func_desc.arguments.item.name)
							arguments.append (Close_parenthesis)
						end
	
						if 
							not visitor.is_basic_type and 
							not (visitor.vt_type = Vt_bool) and 
							not visitor.is_enumeration
						then
							free_object.append (Eif_wean)
							free_object.append (Space_open_parenthesis)
							free_object.append (Tmp_clause)
							free_object.append (func_desc.arguments.item.name)
							free_object.append (Close_parenthesis)
							free_object.append (Semicolon)
							free_object.append (New_line_tab)
						end
					end

					func_desc.arguments.forth
				end

				arguments.append (Close_parenthesis)
				arguments.append (Semicolon)

				visitor := func_desc.return_type.visitor
				if visitor.c_type.is_equal (Void_c_keyword) then
					cecil_call := cecil_procedure_set_up
					cecil_call.append (arguments)
				else
					cecil_call := cecil_function_declaration (visitor)
					cecil_call.append (cecil_function_call)
				end
				
				Result.append (New_line_tab)
				if variables.count > 0 then
					Result.append (variables)
					Result.append (New_line_tab)
				end

				Result.append (cecil_call)
				Result.append (New_line_tab)

				if not visitor.c_type.is_equal (Void_c_keyword) then
					Result.append (Asterisk)
					Result.append (Return_value_name)
					Result.append (Space_equal_space)
					Result.append (Open_parenthesis)
					Result.append (visitor.c_type)
					Result.append (Close_parenthesis)

					if visitor.is_basic_type or visitor.is_enumeration then
						Result.append (Tmp_variable_name)
						Result.append (Semicolon)
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
						Result.append (Semicolon)
					end
					Result.append (New_line)
					Result.append (New_line_tab)
				end

				if func_desc.arguments.count > 0 or not visitor.c_type.is_equal (Void_c_keyword) then
					Result.append (out_value)
					Result.append (free_object)
				end
			end

			Result.append (New_line_tab)
			Result.append (End_ecatch)
			Result.append (Return_s_ok)
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
