indexing
	description: "C client property generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CPP_CLIENT_PROPERTY_GENERATOR

inherit
	WIZARD_CPP_PROPERTY_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

create 
	generate

feature {NONE} -- Basic operations

	generate (a_component: WIZARD_COMPONENT_DESCRIPTOR; 
					a_property: WIZARD_PROPERTY_DESCRIPTOR; 
					interface_name: STRING; 
					lcid: INTEGER) is
			-- Generate C client access and setting features.
		require
			non_void_component: a_component /= Void
			non_void_coclass_name: a_component.name /= Void
			non_void_property: a_property /= Void
			non_void_interface_name: interface_name /= Void
			valid_interface_name: not interface_name.empty
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			visitor := a_property.data_type.visitor

			create_access_feature (a_component, interface_name, lcid, a_property, visitor)

				-- Setting function
			if not is_varflag_freadonly (a_property.var_flags) then
				create_set_feature (a_component, interface_name, lcid, a_property, visitor)
			end
		ensure then
			c_access_feature_exist: c_access_feature /= Void
			c_setting_feature_exist: not is_varflag_freadonly (a_property.var_flags) implies (c_setting_feature /= Void)
		end

feature {NONE} -- Implementation

	create_access_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR; interface_name: STRING; 
						lcid: INTEGER; a_property: WIZARD_PROPERTY_DESCRIPTOR;
						visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Create access feature.
		require
			non_void_component: a_component /= Void
			non_void_interface_name: interface_name /= Void
			non_void_property: a_property/= Void
			valid_interface_name: not interface_name.empty
		do
			-- Access feature (get_  function)
			create c_access_feature.make

			c_access_feature.set_name (external_feature_name (a_property.eiffel_name (a_component)))

			if visitor.c_header_file /= Void and then not visitor.c_header_file.empty then
				set_header_file (visitor.c_header_file)
			end

			-- Set result type
			if 
				visitor.is_basic_type or 
				(visitor.vt_type = Vt_bool) or 
				visitor.is_enumeration 
			then
				c_access_feature.set_result_type (visitor.cecil_type)
			else
				c_access_feature.set_result_type (Eif_reference)
			end

			-- Set comment
			c_access_feature.set_comment (a_property.description)

			-- Set c access body
			set_access_body (interface_name, lcid, a_property.member_id, a_property.data_type.type, visitor)
		end

	create_set_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR; interface_name: STRING; 
						lcid: INTEGER; a_property: WIZARD_PROPERTY_DESCRIPTOR;
						visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- -- Create set feature.
		require
			non_void_component: a_component /= Void
			non_void_interface_name: interface_name /= Void
			non_void_property: a_property/= Void
			valid_interface_name: not interface_name.empty
		local
			a_comment, a_signature, set_feature_name: STRING
		do
			create c_setting_feature.make
			
			create set_feature_name.make (100)
			set_feature_name.append (Set_clause)
			set_feature_name.append (a_property.eiffel_name (a_component))
			c_setting_feature.set_name (external_feature_name (set_feature_name))

			-- Set comment
			create a_comment.make (200)
			a_comment.append (a_property.description)
			a_comment.prepend ("Set ")
			c_setting_feature.set_comment (a_comment)

			-- Set signature
			create a_signature.make (200)
			if 
				visitor.is_basic_type or 
				(visitor.vt_type = Vt_bool) or 
				visitor.is_enumeration 
			then
				a_signature.append (visitor.cecil_type)

			elseif 
				visitor.is_structure or 
				visitor.is_array_basic_type 
			then
				a_signature.append (visitor.c_type)
				a_signature.append (Space)
				a_signature.append (Asterisk)
			elseif 
				visitor.is_structure_pointer
			then
				a_signature.append (visitor.c_type)
			
			elseif
				visitor.is_interface_pointer or
				visitor.is_coclass_pointer or
				visitor.is_interface or
				visitor.is_coclass
			then
				a_signature.append (Iunknown)

			else
				a_signature.append (Eif_object)
			end
			a_signature.append (Space)
			a_signature.append (Argument_name)
			c_setting_feature.set_signature (a_signature)
			c_setting_feature.set_result_type ("void")

			-- Set setting feature body
			set_setting_body (interface_name, lcid, a_property.member_id, visitor)
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

			if not visitor.is_structure then
				if 
					visitor.is_interface_pointer or
					visitor.is_coclass_pointer
				then
					if visitor.vt_type = Vt_unknown then
						tmp_body.append (Iunknown)
					else
						tmp_body.append (Idispatch)
					end
				else
					tmp_body.append (visitor.c_type)
				end
				tmp_body.append (Space)
				tmp_body.append (Tmp_variable_name)
				
				if 
					visitor.is_interface_pointer or
					visitor.is_coclass_pointer or
					visitor.is_structure_pointer
				then
					tmp_body.append (" = 0")
				end
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab)

				if 
					visitor.vt_type = Vt_dispatch
				then
					tmp_body.append ("hr = " + Argument_name + 
								"->QueryInterface (IID_IDispatch, (void**)&" +
								Tmp_variable_name + 
								")")
				elseif
					visitor.vt_type = Vt_unknown
				then
					tmp_body.append (Tmp_variable_name + " = " + Argument_name)
				
				else
					tmp_body.append (Tmp_variable_name)
					tmp_body.append (Space_equal_space)

					if is_byref (type) then
						pointer_var.extend (Tmp_variable_name)
					end


					if 
						visitor.is_basic_type or 
						visitor.is_enumeration  or
						visitor.is_array_basic_type or
						visitor.is_structure_pointer
					then
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
				end
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab)
			end

			tmp_body.append ("arg.vt")
			tmp_body.append (Space_equal_space)
			tmp_body.append_integer (type)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)

			if visitor.is_structure then
				tmp_body.append (Memcpy)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Ampersand)
				tmp_body.append (Open_parenthesis)
				tmp_body.append ("arg.")
				tmp_body.append (vartype_namer.variant_field_name (visitor))
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Comma_space)
				tmp_body.append (Argument_name)
				tmp_body.append (Comma_space)
				tmp_body.append (Sizeof)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (visitor.c_type)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Close_parenthesis)
			else
				tmp_body.append ("arg.")
				tmp_body.append (vartype_namer.variant_field_name (visitor))
				tmp_body.append (Space_equal_space)
				tmp_body.append (Tmp_variable_name)
			end
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

end -- class WIZARD_CPP_CLIENT_PROPERTY_GENERATOR

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
