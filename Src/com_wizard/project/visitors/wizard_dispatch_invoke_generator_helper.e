indexing
	description: "Invoke generator helper."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER

inherit
	WIZARD_WRITER_DICTIONARY
		export 
			{NONE} all
		end

	WIZARD_GUIDS
		export 
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export 
			{NONE} all
		end

	ECOM_VAR_TYPE
		export 
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_NAMER_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

feature -- Access

	excepinfo_setting: STRING is
			-- Fills EXCEPINFO `bstrDescription' and `bstrSource'
		do
			Result := "if (pExcepInfo != NULL)%R%N%
	%					{%R%N%
	%						WCHAR * wide_string = 0;%R%N%
	%						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));%R%N%
	%						BSTR b_string = SysAllocString (wide_string);%R%N%
	%						free (wide_string);%R%N%
	%						pExcepInfo->bstrDescription = b_string;%R%N%
	%						wide_string = ccom_create_from_string (%"" + environment.project_name + "%");%R%N%
	%						b_string = SysAllocString (wide_string);%R%N%
	%						free (wide_string);%R%N%
	%						pExcepInfo->bstrSource = b_string;%R%N%
	%						pExcepInfo->wCode = HRESULT_CODE (hr);%R%N%
	%					}"
		end
			
feature -- Basic operations

	add_ref_to_interface_variable (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_variable_name: STRING): STRING is
			-- Add `AddRef' to interface.
		require
			non_void_visitor: a_visitor /= Void
			non_void_name: a_variable_name /= Void
			valid_name: not a_variable_name.is_empty
		do
			create Result.make (100)
			if 
				a_visitor.is_interface_pointer and
				(a_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				a_visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (Open_parenthesis)
				Result.append (a_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Add_reference_function)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
			end

			if 
				a_visitor.is_interface_pointer_pointer and
				(a_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				a_visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (Open_parenthesis)
				Result.append (Asterisk)
				Result.append (Open_parenthesis)
				Result.append (a_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Add_reference_function)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
			end
		ensure
			non_void_result: Result /= Void
		end

	interface_descriptor_c_type_name (a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Interface's name.
		require
			non_void_descriptor: a_data_type_descriptor /= Void
			non_void_visitor: a_visitor /= void
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if a_visitor.c_type.substring_index (iunknown_type, 1) /= 0 then
				Result := iunknown_type.twin
			elseif a_visitor.c_type.substring_index (idispatch_type, 1) /= 0 then
				Result := idispatch_type.twin
			else
				check 
					interface_type: a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer					
				end
				pointed_descriptor ?= a_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				Result := pointed_descriptor.interface_descriptor.namespace +
					"::" + pointed_descriptor.interface_descriptor.c_type_name
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	check_failer  (an_argument_count: INTEGER; an_additional_string, a_return_code: STRING): STRING is
			-- Case statement for function descriptor
		require
			non_void_additional_string: an_additional_string /= Void
			non_void_return_code: a_return_code /= Void
			valid_return_code: not a_return_code.is_empty
		do
			create Result.make (10000)
			Result.append (If_keyword)
			Result.append (Space_open_parenthesis)
			Result.append (Failed)
			Result.append (Space_open_parenthesis)
			Result.append (Hresult_variable_name)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			
			Result.append (Open_curly_brace)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab)
			if an_argument_count > 0 then
				Result.append ("CoTaskMemFree (tmp_value);%R%N%T%T%T%T%T")
			end
			Result.append (an_additional_string)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab)
			Result.append (Return)
			Result.append (Space)
			Result.append (a_return_code)
			Result.append (Semicolon)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			
			Result.append (Close_curly_brace)
			Result.append (New_line_tab_tab_tab)
		end

	interface_descriptor_guid (a_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
					a_visitor: WIZARD_DATA_TYPE_VISITOR): ECOM_GUID is
			-- Interface's GUID.
		require
			non_void_descriptor: a_data_type_descriptor /= Void
			non_void_visitor: a_visitor /= void
		local
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		do
			if a_visitor.c_type.substring_index (iunknown_type, 1) /= 0 then
				Result := Iunknown_guid
			elseif a_visitor.c_type.substring_index (idispatch_type, 1) /= 0 then
				Result := Idispatch_guid
			else
				check 
					interface_type: a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer					
				end
				pointed_descriptor ?= a_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				Result := pointed_descriptor.interface_descriptor.guid
			end
		ensure
			non_void_guid: Result /= Void
		end

	get_interface_pointer (unknown_name, a_variable_name, a_variant_name, variant_field_name: STRING; 
					counter: INTEGER): STRING is
			-- Get intergace pointer from Variant.
		require
			non_void_unknown_name: unknown_name /= Void
			valid_unknown_name: not unknown_name.is_empty
			non_void_variable_name: a_variable_name /= Void
			valid_variable_name: not a_variable_name.is_empty
			non_void_variant_name: a_variant_name /= Void
			valid_variant_name: not a_variant_name.is_empty
			non_void_variant_field_name: variant_field_name /= Void
			valid_variant_field_name: not variant_field_name.is_empty
		do
				create Result.make (300)
				
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				
				Result.append (Open_curly_brace)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
				
				Result.append (unknown_name)
				Result.append (Space)
				Result.append ("tmp_")
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (variant_field_name)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
				
				Result.append ("if (tmp_" + a_variable_name + " != NULL)")
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab_tab)
				Result.append (Hresult_variable_name)
				Result.append (Space_equal_space)
				Result.append ("tmp_")
				Result.append (a_variable_name)
				Result.append (Struct_selection_operator)
				Result.append (Query_interface)
				Result.append (Space_open_parenthesis)
				Result.append ("tmp_iid_")
				Result.append_integer (counter)
				Result.append (Comma_space)
				Result.append ("(void**)")
				Result.append (Open_parenthesis)
				Result.append (Ampersand)
				Result.append (a_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				
				Result.append (Close_curly_brace)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

	get_interface_pointer_pointer (unknown_name, a_variable_name, a_variant_name, variant_field_name: STRING; 
					counter: INTEGER): STRING is
			-- Get intergace pointer from Variant.
		require
			non_void_unknown_name: unknown_name /= Void
			valid_unknown_name: not unknown_name.is_empty
			non_void_variable_name: a_variable_name /= Void
			valid_variable_name: not a_variable_name.is_empty
			non_void_variant_name: a_variant_name /= Void
			valid_variant_name: not a_variant_name.is_empty
			non_void_variant_field_name: variant_field_name /= Void
			valid_variant_field_name: not variant_field_name.is_empty
		do
				create Result.make (300)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				
				Result.append (Open_curly_brace)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
				Result.append (unknown_name)
				Result.append (Asterisk)
				Result.append (Space)
				Result.append ("tmp_")
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (variant_field_name)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
				
				Result.append ("if (tmp_" + a_variable_name + " != NULL)")
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab_tab)
				
				Result.append ("if (* tmp_" + a_variable_name + " != NULL)")
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab_tab)
				Result.append (Tab)
				Result.append (Hresult_variable_name)
				Result.append (Space_equal_space)
				Result.append (Open_parenthesis)
				Result.append (Asterisk)
				Result.append ("tmp_")
				Result.append (a_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Struct_selection_operator)
				Result.append (Query_interface)
				Result.append (Space_open_parenthesis)
				Result.append ("tmp_iid_")
				Result.append_integer (counter)
				Result.append (Comma_space)
				Result.append ("(void**)")
				Result.append (Open_parenthesis)
				Result.append (Ampersand)
				Result.append ("tmp_tmp_")
				Result.append (a_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				
				Result.append (Close_curly_brace)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end
		
	get_argument_from_variant (a_data_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
				a_variable_name, a_variant_name: STRING;
				counter: INTEGER; an_argument_count: INTEGER): STRING is
			-- Extract data from VARIANT structure.
		require
			non_void_data_descriptor: a_data_descriptor /= Void
			non_void_variable: a_variable_name /= Void
			valid_variable: not a_variable_name.is_empty
			non_void_variant: a_variant_name /= Void
			valid_variant: not a_variant_name.is_empty
		local
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_visitor := a_data_descriptor.visitor
			create Result.make (1000)

			Result.append ("if (" + a_variant_name + 
						"->vt != " + l_visitor.vt_type.out + ")%R%N%T%T%T%T{%R%N%T%T%T%T%T")
			
			Result.append ("hr = VariantChangeType (" + 
							a_variant_name +", " +
							"" + a_variant_name + ", " +
							"VARIANT_NOUSEROVERRIDE, " + 
							l_visitor.vt_type.out + ");%R%N%T%T%T%T%T")

			Result.append (check_failer (an_argument_count, 
							"*puArgErr = " + counter.out + ";", 
							"DISP_E_TYPEMISMATCH"))

			Result.append ("%R%N%T%T%T%T}")
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)

			
			if 
				(l_visitor.is_interface_pointer or 
				l_visitor.is_coclass_pointer) and
				not (l_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				l_visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (l_visitor.c_type)
				Result.append (Space)
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (Zero)						
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
			
				Result.append ("IID tmp_iid_")
				Result.append_integer (counter)
				Result.append (Space_equal_space)
				Result.append (interface_descriptor_guid (a_data_descriptor, l_visitor).to_definition_string)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				
				Result.append ("if (" + a_variant_name + "->vt = VT_UNKNOWN)")
				Result.append (get_interface_pointer 
					(Iunknown, a_variable_name, a_variant_name, Variant_punkval, counter))
				
				Result.append ("else if (" + a_variant_name + "->vt = VT_DISPATCH)")
				Result.append (get_interface_pointer 
					(Idispatch, a_variable_name, a_variant_name, Variant_pdispval, counter))
				

				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append (check_failer (an_argument_count, "", "DISP_E_TYPEMISMATCH"))
				Result.append (Tab)

			elseif 
				(l_visitor.is_interface_pointer_pointer or 
				l_visitor.is_coclass_pointer_pointer) and
				not (l_visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				l_visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (l_visitor.c_type)
				Result.append (Space)
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (Zero)						
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append ("IID tmp_iid_")
				Result.append_integer (counter)
				Result.append (Space_equal_space)
				Result.append (interface_descriptor_guid (a_data_descriptor, l_visitor).to_definition_string)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append (interface_descriptor_c_type_name (a_data_descriptor, l_visitor))
				Result.append (Space)
				Result.append (Asterisk)
				Result.append (Space)
				Result.append ("tmp_tmp_")
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (Zero)						
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append ("if (" + a_variant_name + "->vt = (VT_UNKNOWN |VT_BYREF))")
				Result.append (get_interface_pointer_pointer 
					(Iunknown, a_variable_name, a_variant_name, Variant_ppunkval, counter))
				
				Result.append ("else if (" + a_variant_name + "->vt = (VT_DISPATCH |VT_BYREF))")
				Result.append (get_interface_pointer_pointer 
					(Idispatch, a_variable_name, a_variant_name, Variant_ppdispval, counter))
				
				Result.append (check_failer (an_argument_count, "", "DISP_E_TYPEMISMATCH"))

				Result.append (Tab)
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (Ampersand)
				Result.append ("tmp_tmp_")
				Result.append (a_variable_name)						
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

			elseif l_visitor.is_structure then
				Result.append (l_visitor.c_type)
				Result.append (Space)
				Result.append (a_variable_name)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append (Memcpy)
				Result.append (Space_open_parenthesis)
				Result.append (Ampersand)
				Result.append (a_variable_name)
				Result.append (Comma_space)
				if not (l_visitor.vt_type = Vt_variant) then
					Result.append (Ampersand)
					Result.append (Open_parenthesis)
				end
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (vartype_namer.variant_field_name (l_visitor))
				if not (l_visitor.vt_type = Vt_variant) then
					Result.append (Close_parenthesis)
				end
				Result.append (Comma_space)
				Result.append (sizeof)
				Result.append (Space_open_parenthesis)
				Result.append (l_visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

			else
				Result.append (l_visitor.c_type)
				Result.append (Space)
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append ("(" + l_visitor.c_type + ")")
				Result.append (a_variant_name)
				Result.append ("->")
				Result.append (vartype_namer.variant_field_name (l_visitor))
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append (add_ref_to_interface_variable (l_visitor, a_variable_name))
			end
		ensure
			non_void_argumet: Result /= Void
			valid_argument: not Result.is_empty
		end

end -- class WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

