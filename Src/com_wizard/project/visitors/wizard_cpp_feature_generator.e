indexing
	description: "Feature Generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_FEATURE_GENERATOR

inherit
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_TYPE_KIND
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export 
			{NONE} all
		end

	WIZARD_MESSAGE_OUTPUT

feature {NONE} -- Implementation

	check_interface_pointer (interface_name: STRING): STRING is
			-- Code for interface pointer checking
		require
			non_void_interface_name: interface_name /= Void 
			valid_interface_name: not interface_name.empty 
		local
			pointer_var: LINKED_LIST[STRING]
		do
			create pointer_var.make

			create Result.make (0)
			Result.append (Tab)
			Result.append (Hresult)
			Result.append (Space)
			Result.append (Hresult_variable_name)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)

			Result.append (Interface_variable_prepend)
			Result.append (interface_name)
			Result.append (C_equal)
			Result.append (Null)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)
			Result.append (Hresult_variable_name)
			Result.append (Space_equal_space)
			Result.append (Iunknown_variable_name)
			Result.append (Struct_selection_operator)
			Result.append (Query_interface)
			Result.append (Space_open_parenthesis)
			Result.append (Iid_type)
			Result.append (Underscore)
			Result.append (interface_name)
			Result.append (Comma_space)
			Result.append (Open_parenthesis)
			Result.append (C_void_pointer)
			Result.append (Asterisk)
			Result.append (Close_parenthesis)
			Result.append (Ampersand)
			Result.append (Interface_variable_prepend)
			Result.append (interface_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (examine_hresult_with_pointer (Hresult_variable_name, pointer_var))
			Result.append (New_line_tab)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end

	examine_parameter_error (variable_name: STRING): STRING is
			-- Examine parameter error function
		require
			non_void_variable_name: variable_name /= Void
			valid_variable_name: not variable_name.empty
		do
			Result := clone (New_line_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Hresult_variable_name)
			Result.append (C_equal)
			Result.append ("DISP_E_TYPEMISMATCH")
			Result.append (Space)
			Result.append (C_or)
			Result.append (Space)
			Result.append (Hresult_variable_name)
			Result.append (C_equal)
			Result.append ("DISP_E_PARAMNOTFOUND")
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)
			Result.append ("char * hresult_error")
			Result.append (Space_equal_space)
			Result.append (Formatter)
			Result.append (Dot)
			Result.append ("c_format_message")
			Result.append (Space_open_parenthesis)
			Result.append (Hresult_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
			Result.append ("char * arg_no;")
			Result.append (New_line_tab_tab)
			Result.append ("_itoa (nArgErr, arg_no, 10);")
			Result.append (New_line_tab_tab)
			Result.append ("char * arg_name = %"Argument No: %"")
			Result.append (New_line_tab_tab)
			Result.append ("int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1")
			Result.append (New_line_tab_tab)
			Result.append ("char * message;")
			Result.append (New_line_tab_tab)
			Result.append ("message = calloc (size, sizeof (char));")
			Result.append (New_line_tab_tab)
			Result.append ("strcat (message, hresult_error);")
			Result.append (New_line_tab_tab)
			Result.append ("strcat (message, arg_no);")
			Result.append (New_line_tab_tab)
			Result.append ("strcat (message, arg_name);")
			Result.append (New_line_tab_tab)
			Result.append ("com_eraise (message, HRESULT_CODE(hr));")
			Result.append (New_line_tab)
			Result.append (Close_curly_brace)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end

	examine_hresult_with_pointer (variable_name: STRING; pointer_variables: LINKED_LIST[STRING]): STRING is
			-- Hresult examination function
		require
			non_void_name: variable_name /= Void
			valid_name: not variable_name.empty
			non_void_variables: pointer_variables /= Void
		do
			Result := clone (Tab_tab)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Failed)
			Result.append (Space_open_parenthesis)
			Result.append (variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab)
			Result.append (Open_curly_brace)
			if not pointer_variables.empty then
				from
					pointer_variables.start
				until
					pointer_variables.off
				loop
					Result.append (New_line_tab_tab_tab)
					Result.append (Co_task_mem_free)
					Result.append (Space_open_parenthesis)
					Result.append (Open_parenthesis)
					Result.append (C_void_pointer)
					Result.append (Close_parenthesis)
					Result.append (pointer_variables.item)
					Result.append (Close_parenthesis)
					Result.append (Semicolon)
					pointer_variables.forth
				end
			end
			Result.append (New_line_tab_tab_tab)
			Result.append (Com_eraise)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Formatter)
			Result.append (Dot)
			Result.append (Format_message)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (variable_name)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			Result.append (Hresult_code)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.empty
		end

	examine_hresult (variable_name: STRING): STRING is
			-- Hresult examination function.
		require
			non_void_name: variable_name /= Void
			valid_name: not variable_name.empty
		do
			create Result.make (0)

			-- if (FAILED (`variable_name'))
			-- {
			--	com_eraise (f.c_format_message (`variable_name'), HRESULT_CODE (`variable_name'));
			-- }

			Result.append (Tab)
			Result.append (If_keyword)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Failed)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab)
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab)
			Result.append (Com_eraise)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Formatter)
			Result.append (Dot)
			Result.append (Format_message)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (variable_name)
			Result.append (Close_parenthesis)
			Result.append (Comma_space)
			Result.append (Hresult_code)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line_tab)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		ensure
			non_void_examine_hresult: Result /= Void
			valid_examine_hresult: not Result.empty
		end

	initialize_excepinfo: STRING is
			-- Code to initialize excepinfo
		do
			Result := clone (Tab)
			Result.append (Excepinfo_access)
			Result.append ("wCode")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("wReserved")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("bstrSource")
			Result.append (Space_equal_space)
			Result.append (Null)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("bstrDescription")
			Result.append (Space_equal_space)
			Result.append (Null)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("bstrHelpFile")
			Result.append (Space_equal_space)
			Result.append (Null)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("dwHelpContext")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("pvReserved")
			Result.append (Space_equal_space)
			Result.append (Null)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("pfnDeferredFillIn")
			Result.append (Space_equal_space)
			Result.append (Null)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			Result.append (Excepinfo_access)
			Result.append ("scode")
			Result.append (Space_equal_space)
			Result.append (Zero)
			Result.append (Semicolon)
			Result.append (New_line_tab)
		end

	retval_return_value_set_up (visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Code to set up return value
		require
			non_void_visitor: visitor /= Void
		local
			type: INTEGER
		do
			type := visitor.vt_type
			
			Result := clone (Return)
			Result.append (Space)
 
			if visitor.is_enumeration then
				add_warning (Current, Invalid_use_of_enumeration)
			elseif visitor.is_basic_type then
				Result.append (Open_parenthesis)
				if is_int (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("intVal"))
				elseif is_unsigned_int (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("uintVal"))
				elseif is_character (type) then
					Result.append (Eif_character)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("cVal"))
				elseif is_unsigned_char (type) then
					Result.append (Eif_character)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("bVal"))	
				elseif is_integer2 (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("iVal"))	
				elseif is_unsigned_short (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("uiVal"))	
				elseif is_integer4 (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("lVal"))
				elseif is_unsigned_long (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("ulVal"))
				elseif is_real4 (type) then
					Result.append (Eif_real)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("fltVal"))
				elseif is_real8 (type) then
					Result.append (Eif_double)
					Result.append (Close_parenthesis)
					Result.append (retval_value_set_up ("dblVal"))
				else
					Result.append (Eif_boolean)
					Result.append (Close_parenthesis)
					Result.append (Ce_mapper)
					Result.append (Dot)
					Result.append (visitor.ce_function_name)
					Result.append (Space_open_parenthesis)
					Result.append (retval_value_set_up ("boolVal"))
					Result.append (Comma_space)
					Result.append (Null)
					Result.append (Close_parenthesis)
				end
				Result.append (Semicolon)

			elseif visitor.is_basic_type_ref then
				Result.append (Open_parenthesis)
				if is_int (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("pintVal"))
				elseif is_unsigned_int (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("puintVal"))
				
				elseif is_character (type) then
					Result.append (Eif_character)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("pcVal"))
				elseif is_unsigned_char (type) then
					Result.append (Eif_character)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("pbVal"))	
				elseif is_integer2 (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("piVal"))	
				elseif is_unsigned_short (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("puiVal"))	
				elseif is_integer4 (type) then
					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("plVal"))
				elseif is_unsigned_long (type) then


					Result.append (Eif_integer)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("pulVal"))
				elseif is_real4 (type) then
					Result.append (Eif_real)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("pfltVal"))
				elseif is_real8 (type) then
					Result.append (Eif_double)
					Result.append (Close_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("pdblVal"))
				else
					Result.append (Eif_boolean)
					Result.append (Close_parenthesis)
					Result.append (Ce_mapper)
					Result.append (Dot)
					Result.append (visitor.ce_function_name)
					Result.append (Space_open_parenthesis)
					Result.append (Asterisk)
					Result.append (Open_parenthesis)
					Result.append (retval_value_set_up ("pboolVal"))
					Result.append (Comma_space)
					Result.append (Null)
					Result.append (Close_parenthesis)
				end
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
			else
				Result.append (Ce_mapper)
				Result.append (Dot)
				Result.append (visitor.ce_function_name)
				Result.append (Space_open_parenthesis)

				if is_array (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("pparray"))
					else
						Result.append (retval_value_set_up ("parray"))
					end
				elseif is_error (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("pscode"))
					else
						Result.append (retval_value_set_up ("scode"))
					end
				elseif is_currency (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("pcyVal"))
					else
						Result.append (retval_value_set_up ("cyVal"))
					end
				elseif is_date (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("pdate"))
					else
						Result.append (retval_value_set_up ("date"))
					end
				elseif is_bstr (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("pbstrVal"))
					else
						Result.append (retval_value_set_up ("bstrVal"))
					end
				elseif is_decimal (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("pdecVal"))
					else
						add_warning (Current, Not_variant_type)
					end
				elseif is_unknown (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("ppunkVal"))
					else
						Result.append (retval_value_set_up ("punkVal"))
					end
				elseif is_dispatch (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("ppdispVal"))
					else
						Result.append (retval_value_set_up ("pdispVal"))
					end
				elseif is_variant (type) then
					if is_byref (type) then
						Result.append (retval_value_set_up ("pvarVal"))
					else
						add_warning (Current, Not_variant_type)
					end
				elseif is_byref (type) then
					Result.append (retval_value_set_up ("byref"))
				else
					add_warning (Current, Not_variant_type)
				end
				Result.append (Comma_space)
				Result.append (Null)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
			end	
		ensure
			non_void_retval: Result /= Void
			valid_retval: not Result.empty
		end

	retval_value_set_up (attribute_name: STRING): STRING is
			-- Set up code for return variable 
		require
			non_void_name: attribute_name /= Void
			valid_name: not attribute_name.empty
		do
			Result := clone (Return_variant_variable_name)
			Result.append (Dot)
			Result.append (attribute_name)
			Result.append (Semicolon)
		ensure
			non_void_argument: Result /= Void
			valid_argument: not Result.empty
		end

end -- class WIZARD_C_FEATURE_GENERATOR

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
