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

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate C server access and setting features.
		require
			non_void_component: a_component /= Void
			non_void_coclass_name: a_component.name /= Void
			non_void_property: a_property /= Void
		local
			l_name, l_signature, l_string: STRING
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create c_access_feature.make
			create c_setting_feature.make

			l_visitor := a_property.data_type.visitor 

			-- Access feature
			create l_name.make (100)
			l_name.append (Get_clause)
			l_name.append (a_property.name)
			c_access_feature.set_name (l_name)

			c_access_feature.set_body (access_body (a_property.component_eiffel_name (a_component), l_visitor))
			c_access_feature.set_result_type (Std_method_imp)
			c_access_feature.set_comment (a_property.description)

			-- Set c signature
			create l_signature.make (100)
			l_signature.append (Beginning_comment_paramflag)
			l_signature.append (Out_keyword)
			l_signature.append (End_comment_paramflag)
			l_signature.append (l_visitor.c_type)
			l_signature.append (l_visitor.c_post_type)
			l_signature.append (Asterisk)
			l_signature.append (Space)
			l_signature.append (Argument_name)
			c_access_feature.set_signature (l_signature)

			-- Setting feature
			create l_name.make (100)
			l_name.append (Set_clause)
			l_name.append (a_property.name)
			c_setting_feature.set_name (l_name)

			-- set c setting body
			create l_string.make (100)
			l_string.append (Set_clause)
			l_string.append (a_property.component_eiffel_name (a_component))
			c_setting_feature.set_body (setting_body (l_string, l_visitor))

			c_setting_feature.set_result_type (Std_method_imp)
			c_setting_feature.set_comment (a_property.description)

			-- Set c signature
			create l_signature.make (100)
			l_signature.append (Beginning_comment_paramflag)
			l_signature.append (In)
			l_signature.append (End_comment_paramflag)
			l_signature.append (l_visitor.c_type)
			l_signature.append (l_visitor.c_post_type)
			l_signature.append (Space)
			l_signature.append (Argument_name)
			c_setting_feature.set_signature (l_signature)
		end

feature {NONE} -- Implementation

	access_body (l_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Access body code
		require
			non_void_name: l_name /= Void
			non_void_visitor: l_visitor /= Void
		do
			create Result.make (10000)
			Result.append (Ecatch)

			Result.append (New_line_tab)
			Result.append (cecil_function (l_name, l_visitor))

			Result.append (New_line_tab)

			Result.append (Asterisk)
			Result.append (Argument_name)
			Result.append (Space_equal_space)

			if 
				l_visitor.is_basic_type or
				l_visitor.is_enumeration
			then
				Result.append (Open_parenthesis)
				Result.append (l_visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Tmp_variable_name)
			else
				if l_visitor.need_generate_ec then
					Result.append (Generated_ec_mapper)
				else
					Result.append (Ec_mapper)
				end
				Result.append (Dot)
				Result.append (l_visitor.ec_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				if l_visitor.writable then
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

	setting_body (l_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Setting body code
		require
			non_void_name: l_name /= Void
			non_void_visitor: l_visitor /= Void
		do
			create Result.make (1000)
			Result.append (Ecatch)
			Result.append (set_variable (l_visitor))
			Result.append (New_line_tab)
			Result.append (cecil_procedure (l_name, l_visitor))
			Result.append (New_line_tab)
			Result.append (End_ecatch)
			Result.append (Return)
			Result.append (Space)
			Result.append (S_ok)
			Result.append (Semicolon)
		end

	set_variable (l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Variables
		require
			non_void_visitor: l_visitor /= Void
		do
			create Result.make (1000)
			Result.append (Tab)
			if l_visitor.is_basic_type or l_visitor.is_enumeration then
				Result.append (l_visitor.cecil_type)
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)
				Result.append (l_visitor.cecil_type)
				Result.append (Close_parenthesis)
				Result.append (Argument_name)
			elseif (l_visitor.vt_type = Vt_bool) then
				Result.append (l_visitor.cecil_type)
				Result.append (Space)
				Result.append (Tmp_variable_name)
				Result.append (Space_equal_space)
				Result.append (Ce_mapper)
				Result.append (Dot)
				Result.append (l_visitor.ce_function_name)
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
				if l_visitor.need_generate_ce then
					Result.append (Generated_ce_mapper)
				else
					Result.append (Ce_mapper)
				end
				Result.append (Dot)
				Result.append (l_visitor.ce_function_name)
				Result.append (Space_open_parenthesis)
				Result.append (Argument_name)

				if l_visitor.writable then
					Result.append (Comma_space)
					Result.append (Null)
				end
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
			end

			Result.append (Semicolon)
		end

	cecil_function (function_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up eif_function call
		require
			non_void_visitor: l_visitor /= Void
		local
			cecil_function_type, cecil_function_name, cecil_type: STRING
		do
			if 
				l_visitor.is_basic_type or
				l_visitor.is_enumeration or
				l_visitor.vt_type = Vt_bool
			then
				cecil_type := l_visitor.cecil_type
				if 
					is_int (l_visitor.vt_type) or 
					is_integer2 (l_visitor.vt_type) or 
					is_integer4 (l_visitor.vt_type) or 
					is_unsigned_int (l_visitor.vt_type) or 
					is_unsigned_long (l_visitor.vt_type) or 
					is_unsigned_short (l_visitor.vt_type) 
				then
					cecil_function_type := Eif_integer_function
					cecil_function_name := Eif_integer_function_name
					
				elseif 
					is_character (l_visitor.vt_type) or 
					is_unsigned_char (l_visitor.vt_type) 
				then
					cecil_function_type := Eif_character_function
					cecil_function_name := Eif_character_function_name
					
				elseif is_real4 (l_visitor.vt_type) then
					cecil_function_type := Eif_real_function
					cecil_function_name := Eif_real_function_name
					
				elseif is_real8 (l_visitor.vt_type) then
					cecil_function_type := Eif_double_function
					cecil_function_name := Eif_double_function_name
					
				elseif l_visitor.vt_type = Vt_bool then
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
				not (l_visitor.is_basic_type or
				l_visitor.is_enumeration or
				l_visitor.vt_type = Vt_bool)
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
			valid_function: not Result.is_empty
		end

	cecil_function_code (function_type, function_name, call_func_name: STRING): STRING is
			-- Cecil code
		require
			non_void_type: function_type /= Void
			non_void_name: function_name /= Void
			non_void_call_name: call_func_name /= Void
			not_empty: not function_type.is_empty and then not function_name.is_empty
							and then not call_func_name.is_empty
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
			valid_code: not Result.is_empty
		end

	cecil_procedure (function_name: STRING; l_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Cecil procedure code
		require
			non_void_name: function_name /= Void
			non_void_visitor: l_visitor /= Void
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
			if l_visitor.is_basic_type or l_visitor.is_enumeration then
				Result.append (l_visitor.cecil_type)
			elseif l_visitor.vt_type = Vt_bool then
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
			if l_visitor.is_basic_type or (l_visitor.vt_type = Vt_bool) or l_visitor.is_enumeration then
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
			if not (l_visitor.is_basic_type or (l_visitor.vt_type = Vt_bool) or l_visitor.is_enumeration) then
				Result.append (New_line_tab)
				Result.append (Eif_wean)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
			end
		ensure
			non_void_procedure: Result /= Void
			valid_procedure: not Result.is_empty
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
