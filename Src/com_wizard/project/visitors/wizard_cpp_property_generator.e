indexing
	description: "C property generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_PROPERTY_GENERATOR

inherit
	WIZARD_PROPERTY_GENERATOR

	WIZARD_CPP_FEATURE_GENERATOR
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT

feature -- Access

	c_access_feature: WIZARD_WRITER_C_FUNCTION
			-- C access feature

	c_setting_feature: WIZARD_WRITER_C_FUNCTION
			-- C setting feature

	c_header_file: STRING 
			-- C header file name.

feature {NONE} -- Implementation

	set_header_file (a_header_file: STRING) is
			-- Set `c_header_file' with `a_header_file'
		require
			non_void_header_file: a_header_file /= Void
			valid_header_file: not a_header_file.empty
		do
			c_header_file := clone (a_header_file)
		end

	set_access_body (interface_name: STRING; lcid, member_id, type: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set access body
		require
			non_void_visitor: visitor /= Void
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.empty
			non_void_access_feature: c_access_feature /= Void
		local
			tmp_body: STRING
			pointer_var: LINKED_LIST[STRING]
		do
			create pointer_var.make

			tmp_body := check_interface_pointer (interface_name)
			tmp_body.append (New_line_tab)

			-- Set up "invoke" function call

			tmp_body.append ("DISPID disp = (DISPID) ")
			tmp_body.append_integer (member_id)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append ("LCID lcid = (LCID) ")
			tmp_body.append_integer (lcid)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			tmp_body.append (Empty_dispparams)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return_variant_variable)
			tmp_body.append (New_line)
			tmp_body.append (New_line)

			tmp_body.append (initialize_excepinfo)
			tmp_body.append (New_line_tab)

			tmp_body.append ("unsigned int nArgErr;")
			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)
			tmp_body.append (Hresult_variable_name)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Interface_variable_prepend)
			tmp_body.append (interface_name)
			tmp_body.append (Struct_selection_operator)
			tmp_body.append (Invoke)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append ("disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, ")
			tmp_body.append (Ampersand)
			tmp_body.append (Return_variant_variable_name)
			
			tmp_body.append (", excepinfo, &nArgErr);")
			tmp_body.append (New_line_tab)

			-- if argument error
			tmp_body.append (examine_parameter_error (Hresult_variable_name))
			tmp_body.append (New_line_tab)
			tmp_body.append (examine_hresult_with_pointer (Hresult_variable_name, pointer_var))

			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)

			-- return result from each type
			tmp_body.append (retval_return_value_set_up (visitor))

			c_access_feature.set_body (tmp_body)
		end

	set_setting_body (interface_name: STRING; lcid, member_id: INTEGER; visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- 
		require
			non_void_visitor: visitor /= Void
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.empty
			non_void_c_setting_feature: c_setting_feature /= Void
		local
			tmp_body: STRING
			pointer_var: LINKED_LIST[STRING]
			tmp_c_writer: WIZARD_WRITER_C_FUNCTION
			type: INTEGER
		do
			create pointer_var.make

			type := visitor.vt_type

			tmp_body := check_interface_pointer (interface_name)
			tmp_body.append (New_line)

			-- Set up "invoke" function call

			tmp_body.append (Tab)
			tmp_body.append ("DISPID disp = (DISPID) ")
			tmp_body.append_integer (member_id)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append ("LCID lcid = (LCID) ")
			tmp_body.append_integer (lcid)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			-- Set up parameter
			tmp_body.append ("DISPPARAMS args;")
			tmp_body.append (New_line_tab)
			tmp_body.append ("VARIANTARG arg;")

			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)
			tmp_body.append (visitor.c_type)
			tmp_body.append (Space)
			tmp_body.append (Tmp_variable_name)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			tmp_body.append (Tmp_variable_name)
			tmp_body.append (Space_equal_space)

			if is_byref (type) then
				pointer_var.extend (Tmp_variable_name)
			end

			if visitor.is_basic_type then
				tmp_body.append (Open_parenthesis)
				tmp_body.append (visitor.c_type)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Argument_name)
			else
				if visitor.need_generate_ec then
					tmp_body.append (Generated_ec_mapper)
				else
					tmp_body.append (Ec_mapper)
				end

				tmp_body.append (Dot)
				tmp_body.append (visitor.ec_function_name)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Argument_name)
				tmp_body.append (Close_parenthesis)
			end
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			tmp_body.append ("arg.vt")
			tmp_body.append (Space_equal_space)
			tmp_body.append_integer (type)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append ("arg.")

			tmp_body.append (vartype_namer.variant_field_name (visitor))

			tmp_body.append (Space_equal_space)
			tmp_body.append (Tmp_variable_name)
			tmp_body.append (Semicolon)

			tmp_body.append (New_line_tab)
			tmp_body.append ("args.cArgs = 1")
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append ("args.cNamedArgs = 0")
			tmp_body.append (Semicolon)

			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)

			tmp_body.append (Return_variant_variable)
			tmp_body.append (New_line)
			tmp_body.append (New_line)
			tmp_body.append (initialize_excepinfo)
			tmp_body.append (New_line_tab)
			tmp_body.append ("unsigned int nArgErr;")
			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)

			tmp_body.append (Hresult_variable_name)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Interface_variable_prepend)
			tmp_body.append (interface_name)
			tmp_body.append (Struct_selection_operator)
			tmp_body.append (Invoke)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append ("disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, ")
			tmp_body.append (Ampersand)
			tmp_body.append (Return_variant_variable_name)
			
			tmp_body.append (", excepinfo, &nArgErr);")
			tmp_body.append (New_line_tab)

			-- if argument error
			tmp_body.append (examine_parameter_error (Hresult_variable_name))
			tmp_body.append (examine_hresult_with_pointer (Hresult_variable_name, pointer_var))

			if not pointer_var.empty then
				tmp_body.append (New_line_tab)
				tmp_body.append (Co_task_mem_free)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Open_parenthesis)
				tmp_body.append (C_void_pointer)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (pointer_var.first)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
			end
			tmp_body.append (New_line_tab)
			c_setting_feature.set_body (tmp_body)
		end

end -- class WIZARD_C_PROPERTY_GENERATOR

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
 
