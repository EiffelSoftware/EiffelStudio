indexing
	description: "Generate C server code for property"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_SERVER_PROPERTY_GENERATOR

inherit
	WIZARD_CPP_PROPERTY_GENERATOR

feature -- Basic operations

	generate (coclass_name: STRING; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate C server access and setting features.
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_coclass_name: coclass_name /= Void
		local
			tmp_string: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create c_access_feature.make
			create c_setting_feature.make

			create visitor
			visitor.visit (a_descriptor.data_type)

			-- Access feature
			tmp_string := clone (Get_clause)
			tmp_string.append (a_descriptor.name)
			c_access_feature.set_name (tmp_string)

			-- Set c access body
			if a_descriptor.coclass_eiffel_names.has (coclass_name) then
				tmp_string := clone (a_descriptor.coclass_eiffel_names.item (coclass_name))
			else
				tmp_string := clone (a_descriptor.interface_eiffel_name)
			end

			c_access_feature.set_body (access_body (tmp_string, visitor))

			visitor.visit (a_descriptor.data_type)

			-- Set result type.
			c_access_feature.set_result_type (Std_method_imp)

			-- Set comment
			c_access_feature.set_comment (a_descriptor.description)

			-- Set c signature
			tmp_string := clone (Beginning_comment_paramflag)
			tmp_string.append (Out_keyword)
			tmp_string.append (End_comment_paramflag)
			tmp_string.append (visitor.c_type)
			tmp_string.append (visitor.c_post_type)
			tmp_string.append (Asterisk)
			tmp_string.append (Space)
			tmp_string.append (Argument_name)
			c_access_feature.set_signature (tmp_string)

			-- Setting feature
			tmp_string := clone (Set_clause)
			tmp_string.append (a_descriptor.name)
			c_setting_feature.set_name (tmp_string)

			-- set c setting body
			tmp_string := clone (Set_clause)
			if a_descriptor.coclass_eiffel_names.has (coclass_name) then
				tmp_string.append (a_descriptor.coclass_eiffel_names.item (coclass_name))
			else
				tmp_string.append (a_descriptor.interface_eiffel_name)
			end
			c_setting_feature.set_body (setting_body (tmp_string, visitor))

			--  Set result type
			c_setting_feature.set_result_type (Std_method_imp)

			-- Set comment
			c_setting_feature.set_comment (a_descriptor.description)

			-- Set c signature
			tmp_string := clone (Beginning_comment_paramflag)
			tmp_string.append (In)
			tmp_string.append (End_comment_paramflag)
			tmp_string.append (visitor.c_type)
			tmp_string.append (visitor.c_post_type)
			tmp_string.append (Space)
			tmp_string.append (Argument_name)
			c_setting_feature.set_signature (tmp_string)
		end

feature {NONE} -- Implementation

	access_body (a_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Access body code
		require
			non_void_name: a_name /= Void
			non_void_visitor: visitor /= Void
		do
			Result := clone (Ecatch)

			Result.append (New_line_tab)
			Result.append (cecil_function (a_name, visitor))

			Result.append (New_line_tab)

			Result.append (Asterisk)
			Result.append (Argument_name)
			Result.append (Space_equal_space)

			if visitor.is_basic_type then
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
			Result.append (New_line_tab)
			Result.append (End_ecatch)
			Result.append (Return)
			Result.append (Space)
			Result.append (S_ok)
			Result.append (Semicolon)
		end

	setting_body (a_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Setting body code
		require
			non_void_name: a_name /= Void
			non_void_visitor: visitor /= Void
		do
			Result := clone (Ecatch)
			Result.append (set_variable (visitor))
			Result.append (New_line_tab)
			Result.append (cecil_procedure (a_name, visitor))
			Result.append (New_line_tab)
			Result.append (End_ecatch)
			Result.append (Return)
			Result.append (Space)
			Result.append (S_ok)
			Result.append (Semicolon)
		end

	set_variable (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Variables
		require
			non_void_visitor: visitor /= Void
		do
			Result := clone (Tab)
			if visitor.is_basic_type then
				Result.append (visitor.cecil_type)
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				if is_boolean (visitor.vt_type) then
					Result.append (Ce_mapper)
					Result.append (Dot)
					Result.append (visitor.ce_function_name)
					Result.append (Space_open_parenthesis)
					Result.append (Argument_name)
					Result.append (Close_parenthesis)
				else
					Result.append (Open_parenthesis)
					Result.append (visitor.cecil_type)
					Result.append (Close_parenthesis)
					Result.append (Argument_name)
				end
			else
				Result.append (Eif_object)
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Semicolon)
				Result.append (New_line_tab)
				Result.append (Tmp_variable_name)
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
				Result.append (Argument_name)

				if visitor.writable then
					Result.append (Comma_space)
					Result.append (Null)
				end
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
			end

			Result.append (Semicolon)
		end

	cecil_function (function_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up eif_function call
		require
			non_void_visitor: visitor /= Void
		do
			if visitor.is_basic_type or else visitor.is_basic_type_ref then
				if is_int (visitor.vt_type) or is_integer2 (visitor.vt_type) or is_integer4 (visitor.vt_type) or is_unsigned_int (visitor.vt_type)
						or is_unsigned_long (visitor.vt_type) or is_unsigned_short (visitor.vt_type) then
					Result := cecil_function_code (Eif_integer_function, Eif_integer_function_name, function_name)
				elseif is_boolean (visitor.vt_type) then
					Result := cecil_function_code (Eif_boolean_function, Eif_boolean_function_name, function_name)
				elseif is_character (visitor.vt_type) or is_unsigned_char (visitor.vt_type) then
					Result := cecil_function_code (Eif_character_function, Eif_character_function_name, function_name)	
				elseif is_real4 (visitor.vt_type) then
					Result := cecil_function_code (Eif_real_function, Eif_real_function_name, function_name)
				elseif is_real8 (visitor.vt_type) then
					Result := cecil_function_code (Eif_double_function, Eif_double_function_name, function_name)
				end
				-- 'cecil_type' tmp_value = ('cecil_type')eiffel_function (eif_access (eiffel_object))
				Result.append (New_line_tab)

				if visitor.is_basic_type then
					Result.append (visitor.cecil_type)
				else
					Result.append (visitor.c_type)
				end
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)

				if visitor.is_basic_type then
					Result.append (visitor.cecil_type)
				else
					Result.append (visitor.c_type)
				end

				Result.append (Close_parenthesis)

				if is_boolean (visitor.vt_type) then
					Result.append (Ce_mapper)
					Result.append (Dot)
					Result.append (visitor.ec_function_name)
					Result.append (Space_open_parenthesis)
					Result.append (Eiffel_function_variable_name)
					Result.append (Space_open_parenthesis)
					Result.append (Eif_access)
					Result.append (Space_open_parenthesis)
					Result.append (Eiffel_object)
					Result.append (Close_parenthesis)
					Result.append (Close_parenthesis)
					Result.append (Close_parenthesis)
				else
					Result.append (Eiffel_function_variable_name)
					Result.append (Space_open_parenthesis)
					Result.append (Eif_access)
					Result.append (Space_open_parenthesis)
					Result.append (Eiffel_object)
					Result.append (Close_parenthesis)
					Result.append (Close_parenthesis)
				end
			else
				Result := cecil_function_code (Eif_reference_function, Eif_reference_function_name, function_name) 
				Result.append (New_line_tab)
				Result.append (Eif_reference)
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				Result.append (Eiffel_function_variable_name)
				Result.append (Space_open_parenthesis)
				Result.append (Eif_access)
				Result.append (Space_open_parenthesis)
				Result.append (Eiffel_object)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
			end
			Result.append (Semicolon)
		end

	cecil_function_code (function_type, function_name, call_func_name: STRING): STRING is
			-- Cecil code
		require
			non_void_type: function_type /= Void
			non_void_name: function_name /= Void
			non_void_call_name: call_func_name /= Void
			not_empty: not function_type.empty and then not function_name.empty
							and then not call_func_name.empty
		do
			-- EIF_type_FUNCTION eiffel_function
			Result := Clone (function_type)
			Result.append (Space)
			Result.append (Eiffel_function_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eiffel_function = eif_type_function ("call_func_name", tid)
			Result.append (Eiffel_function_variable_name)
			Result.append (Space_equal_space)
			Result.append (function_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			Result.append (call_func_name)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		end

	cecil_procedure (function_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Cecil procedure code
		require
			non_void_name: function_name /= Void
			non_void_visitor: visitor /= Void
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
			Result.append (function_name)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (Type_id)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eif_procedure (eif_access (eiffel_object),
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			if visitor.is_basic_type then
				Result.append (Tmp_variable_name)
			else
				Result.append (Eif_access)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
			end
			Result.append (Close_parenthesis)
			Result.append (Semicolon)

			-- eif_wean ('tmp_object')
			if not visitor.is_basic_type then
				Result.append (New_line_tab)
				Result.append (Eif_wean)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
			end
		end

end -- class WIZARD_C_SERVER_PROPERTY_GENERATOR

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
