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

feature -- Access

	excepinfo_setting: STRING is
			-- Fills EXCEPINFO `bstrDescription' and `bstrSource'
		do
			Result := "if (pExcepInfo != NULL)%N%
	%					{%N%
	%						WCHAR * wide_string = 0;%N%
	%						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));%N%
	%						BSTR b_string = SysAllocString (wide_string);%N%
	%						free (wide_string);%N%
	%						pExcepInfo->bstrDescription = b_string;%N%
	%						wide_string = ccom_create_from_string (%"" + Shared_wizard_environment.project_name + "%");%N%
	%						b_string = SysAllocString (wide_string);%N%
	%						free (wide_string);%N%
	%						pExcepInfo->bstrSource = b_string;%N%
	%						pExcepInfo->wCode = HRESULT_CODE (hr);%N%
	%					}"
		end
			
feature -- Basic operations

	add_ref_to_interface_variable (visitor: WIZARD_DATA_TYPE_VISITOR;
				a_variable_name: STRING): STRING is
			-- `AddRef' to interface.
		require
			non_void_visitor: visitor /= Void
			non_void_name: a_variable_name /= Void
			valid_name: not a_variable_name.empty
		do
			create Result.make (100)
			if 
				visitor.is_interface_pointer and
				(visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (Open_parenthesis)
				Result.append (a_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Add_reference_function)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
			end

			if 
				visitor.is_interface_pointer_pointer and
				(visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				visitor.c_type.substring_index (Idispatch_type, 1) > 0)
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
				Result := clone (iunknown_type)
			elseif a_visitor.c_type.substring_index (idispatch_type, 1) /= 0 then
				Result := clone (idispatch_type)
			else
				check 
					interface_type: a_visitor.is_interface_pointer or a_visitor.is_interface_pointer_pointer or
						a_visitor.is_coclass_pointer or a_visitor.is_coclass_pointer_pointer					
				end
				pointed_descriptor ?= a_data_type_descriptor
				check
					non_void_pointed_descriptor: pointed_descriptor /= Void
				end
				Result := pointed_descriptor.interface_descriptor.c_type_name
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.empty
		end

	check_failer  (is_arguments_empty: BOOLEAN; an_additional_string, a_return_code: STRING): STRING is
			-- Case statement for function descriptor
		require
			non_void_additional_string: an_additional_string /= Void
			non_void_return_code: a_return_code /= Void
			valid_return_code: not a_return_code.empty
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
			if not is_arguments_empty then
				Result.append (Co_task_mem_free)
				Result.append (Space_open_parenthesis)
				Result.append (Tmp_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab_tab)
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

	get_argument_from_variant (a_data_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
				a_variable_name, a_variant_name: STRING;
				counter: INTEGER; is_arguments_empty: BOOLEAN): STRING is
			-- Extract data from VARIANT structure.
		require
			non_void_data_descriptor: a_data_descriptor /= Void
			non_void_variable: a_variable_name /= Void
			valid_variable: not a_variable_name.empty
			non_void_variant: a_variant_name /= Void
			valid_variant: not a_variant_name.empty
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			visitor := a_data_descriptor.visitor
			create Result.make (1000)
			if 
				(visitor.is_interface_pointer or 
				visitor.is_coclass_pointer) and
				not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (visitor.c_type)
				Result.append (Space)
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (Zero)						
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)
				
				if is_unknown (visitor.vt_type) then
					Result.append (Iunknown)
				else
					Result.append (Idispatch)
				end
				Result.append (Space)
				Result.append ("tmp_")
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (a_variant_name)
				Result.append (Dot)
				Result.append (vartype_namer.variant_field_name (visitor))
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append ("IID tmp_iid_")
				Result.append_integer (counter)
				Result.append (Space_equal_space)
				Result.append (interface_descriptor_guid (a_data_descriptor, visitor).to_definition_string)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

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

				Result.append (check_failer (is_arguments_empty, "", "DISP_E_BADVARTYPE"))
				Result.append (Tab)

			elseif 
				(visitor.is_interface_pointer_pointer or 
				visitor.is_coclass_pointer_pointer) and
				not (visitor.c_type.substring_index (Iunknown_type, 1) > 0 or 
				visitor.c_type.substring_index (Idispatch_type, 1) > 0)
			then
				Result.append (visitor.c_type)
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
				Result.append (interface_descriptor_guid (a_data_descriptor, visitor).to_definition_string)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append (interface_descriptor_c_type_name (a_data_descriptor, visitor))
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

				if is_unknown (visitor.vt_type) then
					Result.append (Iunknown)
				else
					Result.append (Idispatch)
				end
				Result.append (Asterisk)
				Result.append (Space)
				Result.append ("tmp_")
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (a_variant_name)
				Result.append (Dot)
				Result.append (vartype_namer.variant_field_name (visitor))
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
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

				Result.append (check_failer (is_arguments_empty, "", "DISP_E_BADVARTYPE"))

				Result.append (Tab)
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (Ampersand)
				Result.append ("tmp_tmp_")
				Result.append (a_variable_name)						
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

			elseif visitor.is_structure then
				Result.append (visitor.c_type)
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
				if not (visitor.vt_type = Vt_variant) then
					Result.append (Ampersand)
					Result.append (Open_parenthesis)
				end
				Result.append (a_variant_name)
				Result.append (Dot)
				Result.append (vartype_namer.variant_field_name (visitor))
				if not (visitor.vt_type = Vt_variant) then
					Result.append (Close_parenthesis)
				end
				Result.append (Comma_space)
				Result.append (sizeof)
				Result.append (Space_open_parenthesis)
				Result.append (visitor.c_type)
				Result.append (Close_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

			else
				Result.append (visitor.c_type)
				Result.append (Space)
				Result.append (a_variable_name)
				Result.append (Space_equal_space)
				Result.append (a_variant_name)
				Result.append (Dot)
				Result.append (vartype_namer.variant_field_name (visitor))
				Result.append (Semicolon)
				Result.append (New_line_tab_tab_tab)
				Result.append (Tab)

				Result.append (add_ref_to_interface_variable (visitor, a_variable_name))
			end
		ensure
			non_void_argumet: Result /= Void
			valid_argument: not Result.empty
		end

end -- class WIZARD_DISPATCH_INVOKE_GENERATOR_HELPER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
