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

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; 
					a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate C server access and setting features.
		require
			non_void_component: a_component /= Void
			non_void_coclass_name: a_component.name /= Void
			non_void_property: a_property /= Void
		local
			a_name, a_signature, tmp_string: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create c_access_feature.make
			create c_setting_feature.make

			visitor := a_property.data_type.visitor 

			-- Access feature
			create a_name.make (100)
			a_name.append (Get_clause)
			a_name.append (a_property.name)
			c_access_feature.set_name (a_name)

			c_access_feature.set_body (access_body (a_property.eiffel_name (a_component), visitor))
			c_access_feature.set_result_type (Std_method_imp)
			c_access_feature.set_comment (a_property.description)

			-- Set c signature
			create a_signature.make (100)
			a_signature.append (Beginning_comment_paramflag)
			a_signature.append (Out_keyword)
			a_signature.append (End_comment_paramflag)
			a_signature.append (visitor.c_type)
			a_signature.append (visitor.c_post_type)
			a_signature.append (Asterisk)
			a_signature.append (Space)
			a_signature.append (Argument_name)
			c_access_feature.set_signature (a_signature)

			-- Setting feature
			create a_name.make (100)
			a_name.append (Set_clause)
			a_name.append (a_property.name)
			c_setting_feature.set_name (a_name)

			-- set c setting body
			create tmp_string.make (100)
			tmp_string.append (Set_clause)
			tmp_string.append (a_property.eiffel_name (a_component))
			c_setting_feature.set_body (setting_body (tmp_string, visitor))

			c_setting_feature.set_result_type (Std_method_imp)
			c_setting_feature.set_comment (a_property.description)

			-- Set c signature
			create a_signature.make (100)
			a_signature.append (Beginning_comment_paramflag)
			a_signature.append (In)
			a_signature.append (End_comment_paramflag)
			a_signature.append (visitor.c_type)
			a_signature.append (visitor.c_post_type)
			a_signature.append (Space)
			a_signature.append (Argument_name)
			c_setting_feature.set_signature (a_signature)
		end

feature {NONE} -- Implementation

	access_body (a_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Access body code
		require
			non_void_name: a_name /= Void
			non_void_visitor: visitor /= Void
		do
			create Result.make (10000)
			Result.append (Ecatch)

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
			create Result.make (1000)
			Result.append (Ecatch)
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
			create Result.make (1000)
			Result.append (Tab)
			if visitor.is_basic_type or visitor.is_enumeration then
				Result.append (visitor.cecil_type)
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)
				Result.append (visitor.cecil_type)
				Result.append (Close_parenthesis)
				Result.append (Argument_name)
			elseif (visitor.vt_type = Vt_bool) then
				Result.append (visitor.cecil_type)
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				Result.append (Ce_mapper)
				Result.append (Dot)
				Result.append (visitor.ce_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Argument_name)
				Result.append (Close_parenthesis)
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
		local
			cecil_function_type, cecil_function_name, cecil_type: STRING
		do
			if 
				visitor.is_basic_type or
				visitor.is_enumeration or
				visitor.vt_type = Vt_bool
			then
				cecil_type := visitor.cecil_type
				if 
					is_int (visitor.vt_type) or 
					is_integer2 (visitor.vt_type) or 
					is_integer4 (visitor.vt_type) or 
					is_unsigned_int (visitor.vt_type) or 
					is_unsigned_long (visitor.vt_type) or 
					is_unsigned_short (visitor.vt_type) 
				then
					cecil_function_type := Eif_integer_function
					cecil_function_name := Eif_integer_function_name
					
				elseif 
					is_character (visitor.vt_type) or 
					is_unsigned_char (visitor.vt_type) 
				then
					cecil_function_type := Eif_character_function
					cecil_function_name := Eif_character_function_name
					
				elseif is_real4 (visitor.vt_type) then
					cecil_function_type := Eif_real_function
					cecil_function_name := Eif_real_function_name
					
				elseif is_real8 (visitor.vt_type) then
					cecil_function_type := Eif_double_function
					cecil_function_name := Eif_double_function_name
					
				elseif visitor.vt_type = Vt_bool then
					cecil_function_type := Eif_boolean_function
					cecil_function_name := Eif_boolean_function_name
				end
			else
				cecil_type := Eif_reference
				cecil_function_type := Eif_reference_function
				cecil_function_name := Eif_reference_function_name
			end

			Result := cecil_function_code (cecil_function_type, cecil_function_name, function_name)
			Result.append (New_line_tab)

			-- 'cecil_type' tmp_value;
			
			Result.append (cecil_type)
			Result.append (Space)
			Result.append (Tmp_variable_name)
			
			if 
				not (visitor.is_basic_type or
				visitor.is_enumeration or
				visitor.vt_type = Vt_bool)
			then
				Result.append (Space_equal_space)
				Result.append (Zero)
			end
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- if (eiffel_function != NULL)
			
			Result.append ("if (eiffel_function != NULL)")
			Result.append (New_line_tab_tab)
			
			-- tmp_value = (`cecil_type')eiffel_function (eif_access (eiffel_object))
			

			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append ("(FUNCTION_CAST (")
			Result.append (cecil_type)
			Result.append (Comma_space)
			Result.append (open_parenthesis)
			Result.append (Eif_reference)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)

			Result.append (Eiffel_function_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			
			-- else
			
			Result.append (Else_keyword)
			Result.append (New_line_tab_tab)
			
			-- tmp_value = eif_field (eif_access (eiffel_object), %"`function_name'%", `cecil_type')
			
			Result.append (Tmp_variable_name)
			Result.append (Space_equal_space)
			Result.append ("eif_field (")
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			Result.append (Double_quote)
			Result.append (function_name)
			Result.append (Double_quote)
			Result.append (Comma_space)
			Result.append (cecil_type)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		ensure
			non_void_function: Result /= Void
			valid_function: not Result.empty
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
			-- EIF_type_FUNCTION eiffel_function = 0;
			
			create Result.make (10000)
			Result.append (function_type)
			Result.append (Space)
			Result.append (Eiffel_function_variable_name)
			Result.append ("= 0")
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- eiffel_function = eif_type_function ("call_func_name", tid);
			
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
		ensure
			non_void_code: Result /= Void
			valid_code: not Result.empty
		end

	cecil_procedure (function_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Cecil procedure code
		require
			non_void_name: function_name /= Void
			non_void_visitor: visitor /= Void
		do
			-- EIF_PROCEDURE eiffel_procedure
			create Result.make (10000)
			Result.append (Eif_procedure)
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
			Result.append ("(FUNCTION_CAST (void, (EIF_REFERENCE, ")
			if visitor.is_basic_type then
				Result.append (visitor.cecil_type)
			elseif is_boolean (visitor.vt_type) and not visitor.is_pointed then
				Result.append (Eif_boolean)
			else
				Result.append (Eif_reference)
			end

			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Eiffel_procedure_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Space_open_parenthesis)
			Result.append (Eif_access)
			Result.append (Space_open_parenthesis)
			Result.append (Eiffel_object)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			if visitor.is_basic_type or (visitor.vt_type = Vt_bool) then
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
			if not (visitor.is_basic_type or (visitor.vt_type = Vt_bool)) then
				Result.append (New_line_tab)
				Result.append (Eif_wean)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
			end
		ensure
			non_void_procedure: Result /= Void
			valid_procedure: not Result.empty
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
