indexing
	description: "Generate Eiffel Client code from property"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_CLIENT_PROPERTY_GENERATOR

inherit
	WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

create
	generate

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate client access and setting features.
		local
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			visitor := a_descriptor.data_type.visitor 

			create changed_names.make (2)


			define_feature_names (a_component_descriptor, a_descriptor)
			generate_access_feature (visitor, a_descriptor)
			generate_external_access_feature (visitor, a_component_descriptor, a_descriptor)

			if not is_varflag_freadonly (a_descriptor.var_flags) then
				generate_setting_feature (visitor)
				generate_external_setting_feature (visitor, a_component_descriptor)
			end
		ensure then
			external_access_feature_exist: external_access_feature /= Void
			external_setting_feature_exist: not is_varflag_freadonly (a_descriptor.var_flags)  implies (external_setting_feature /= Void)
		end

feature {NONE} -- Implementation

	access_feature_name: STRING
			-- Name of access feature.

	set_feature_name: STRING
			-- Name of set feature.

	external_access_feature_name: STRING
			-- Name of external access feature.

	external_set_feature_name: STRING 
			-- Name of external set feature.

	c_type (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- C type of component.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		do
			create Result.make (50)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				Result.append (a_component_descriptor.namespace)
				Result.append ("::")
			end
			Result.append (a_component_descriptor.c_type_name)
		ensure
			non_void_c_type: Result /= Void
			valid_c_type: not Result.empty
		end
		
	define_feature_names (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; 
				a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Define feature names.
		require
			non_void_component: a_component_descriptor /= Void
			non_void_descriptor: a_descriptor /= Void
		local
			tmp_string: STRING
		do
			if a_descriptor.coclass_eiffel_names.has (a_component_descriptor.name) then
				property_renamed := True
				access_feature_name := clone (a_descriptor.coclass_eiffel_names.item (a_component_descriptor.name))
				changed_names.put (access_feature_name, a_descriptor.interface_eiffel_name)

				create tmp_string.make (100)
				tmp_string.append (Set_clause)
				tmp_string.append (a_descriptor.interface_eiffel_name)
				
				create set_feature_name.make (100)
				set_feature_name.append (Set_clause)
				set_feature_name.append (access_feature_name)
				changed_names.put (set_feature_name, tmp_string)
			else
				access_feature_name := a_descriptor.interface_eiffel_name
				
				create set_feature_name.make (100)
				set_feature_name.append (Set_clause)
				set_feature_name.append (access_feature_name)
			end
			external_access_feature_name := external_feature_name (access_feature_name)
			external_set_feature_name := external_feature_name (set_feature_name)
		ensure
			non_void_access_feature_name: access_feature_name /= Void
			valid_access_feature_name: not access_feature_name.empty
			non_void_set_feature_name: set_feature_name /= Void
			valid_set_feature_name: not set_feature_name.empty
			non_void_external_access_feature_name: external_access_feature_name /= Void
			valid_external_access_feature_name: not external_access_feature_name.empty
			non_void_external_set_feature_name: external_set_feature_name /= Void
			valid_external_set_feature_name: not external_set_feature_name.empty
		end

	generate_access_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate access feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_descriptor: a_descriptor /= Void
			non_void_access_feature_name: access_feature_name /= Void
			valid_access_feature_name: not access_feature_name.empty
		do
			create access_feature.make
			access_feature.set_name (access_feature_name)
			access_feature.set_result_type (a_visitor.eiffel_type)
			access_feature.set_comment (a_descriptor.description)
			access_feature.set_body (access_body)
			access_feature.set_effective
		ensure
			non_void_access_feature: access_feature /= Void
			non_void_access_feature_name: access_feature.name /= Void
			valid_access_feature_name: access_feature.name.is_equal (access_feature_name)
			non_void_access_feature_body: access_feature.body /= Void
		end

	generate_setting_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Generate setting feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_set_feature_name: set_feature_name /= Void
			valid_set_feature_name: not set_feature_name.empty
		local
			an_argument: STRING
		do
			create setting_feature.make
			setting_feature.set_name (set_feature_name)

			-- Set arguments
			create an_argument.make (100)
			an_argument.append (Argument_name)
			an_argument.append (Colon)
			an_argument.append (Space)
			an_argument.append (a_visitor.eiffel_type)
			setting_feature.add_argument (an_argument)

			setting_feature.set_comment (setting_feature_comment (access_feature_name))
			
			setting_feature.set_effective
			setting_feature.set_body (setting_body (a_visitor))

		ensure
			non_void_setting_feature: setting_feature /= Void
			non_void_setting_feature_name: setting_feature.name /= Void
			valid_setting_feature_name: setting_feature.name.is_equal (set_feature_name)
			non_void_setting_feature_body: setting_feature.body /= Void
			valid_setting_feature_arguments: not setting_feature.arguments.empty
		end

	generate_external_access_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR;
				a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; 
				a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate external access feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_external_access_feature_name: external_access_feature_name /= Void
			valid_external_access_feature_name: not external_access_feature_name.empty
			non_void_component: a_component_descriptor /= Void
			non_void_descriptor: a_descriptor /= Void
		do
			create external_access_feature.make
			external_access_feature.set_name (external_access_feature_name)

			external_access_feature.set_result_type (a_visitor.eiffel_type)
			external_access_feature.set_comment (a_descriptor.description)
			external_access_feature.add_argument (clone (Default_pointer_argument))
			external_access_feature.set_body 
					(external_access_body (c_type (a_component_descriptor), 
											a_component_descriptor.c_header_file_name, 
											a_visitor))
			external_access_feature.set_external
		ensure
			non_void_external_access_feature: external_access_feature /= Void
			non_void_external_access_feature_name: external_access_feature.name /= Void
			valid_external_access_feature_name: external_access_feature.name.is_equal (external_access_feature_name)
			non_void_external_access_feature_body: external_access_feature.body /= Void
			valid_external_access_feature_arguments: not external_access_feature.arguments.empty
		end

	generate_external_setting_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR;
				a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Generate external set feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_external_set_feature_name: external_set_feature_name /= Void
			valid_external_set_feature_name: not external_set_feature_name.empty
			non_void_component: a_component_descriptor /= Void
		local
			an_argument: STRING
		do
			create external_setting_feature.make

			external_setting_feature.set_name (external_set_feature_name)

			external_setting_feature.add_argument (clone (Default_pointer_argument))	
		
			create an_argument.make (100)
			an_argument.append (Argument_name)
			an_argument.append (Colon)
			an_argument.append (Space)
			if 
				a_visitor.is_array_basic_type or 
				a_visitor.is_interface or 
				a_visitor.is_structure or 
				a_visitor.is_structure_pointer or
				a_visitor.is_interface_pointer or 
				a_visitor.is_coclass_pointer
			then
				an_argument.append (Pointer_type)
			else
				an_argument.append (a_visitor.eiffel_type)
			end
			external_setting_feature.add_argument (an_argument)
			
			external_setting_feature.set_comment (setting_feature_comment (access_feature_name))
			external_setting_feature.set_external
			external_setting_feature.set_body 
					(external_setting_body (c_type (a_component_descriptor), 
							a_component_descriptor.c_header_file_name, 
							a_visitor))
		ensure
			non_void_external_setting_feature: external_setting_feature /= Void
			non_void_external_setting_feature_name: external_setting_feature.name /= Void
			valid_external_setting_feature_name: external_setting_feature.name.is_equal (external_set_feature_name)
			non_void_external_setting_feature_body: external_setting_feature.body /= Void
			valid_external_setting_feature_arguments: not external_setting_feature.arguments.empty
		end

	setting_feature_comment (a_name: STRING): STRING is
			-- Comment for setting feature.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (1000)
			Result.append ("Set ")
			Result.append (Back_quote)
			Result.append (a_name)
			Result.append (Single_quote)
			Result.append (Space)
			Result.append ("with ")
			Result.append (Back_quote)
			Result.append (Argument_name)
			Result.append (Single_quote)
			Result.append (Dot)
		ensure
			non_void_comment: Result /= Void
			valid_comment: not Result.empty
		end

	setting_body (a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Coclass client setting body code
		require
			non_void_visitor: a_visitor /= Void
			non_void_external_set_feature_name: external_set_feature_name /= Void
			valid_external_set_feature_name: not external_set_feature_name.empty
		local
			tmp_string, local_variable: STRING
		do
			create Result.make (1000)
			Result.append (Tab_tab_tab)

			create tmp_string.make (100)
			tmp_string.append (external_set_feature_name)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Initializer_variable)
			tmp_string.append (Comma_space)

			if a_visitor.is_array_basic_type then
				create local_variable.make (100)
				local_variable.append (Any_clause)
				local_variable.append (Any_type)
				setting_feature.add_local_variable (local_variable)

				Result.append (Any_clause)
				Result.append (Space)
				Result.append (Assignment)
				Result.append (Space)
				Result.append (Argument_name)
				Result.append (To_c_function)

				tmp_string.append (Dollar)
				tmp_string.append (Any_clause)
			elseif 
				a_visitor.is_interface or 
				a_visitor.is_interface_pointer or
				a_visitor.is_structure or 
				a_visitor.is_structure_pointer or
				a_visitor.is_coclass or
				a_visitor.is_coclass_pointer
			then
				tmp_string.append (Argument_name)
				tmp_string.append (Item_function)
			else
				tmp_string.append (Argument_name)
			end
			tmp_string.append (Close_parenthesis)
			Result.append (tmp_string)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty		
		end

	access_body: STRING is
			-- Coclass client access body
		require
			non_void_external_access_feature_name: external_access_feature_name /= Void
			valid_external_access_feature_name: not external_access_feature_name.empty
		do
			create Result.make (1000)
			Result.append (Tab_tab_tab)
			Result.append (Result_clause)
			Result.append (external_access_feature_name)
			Result.append (Space_open_parenthesis)
			Result.append (Initializer_variable)
			Result.append (close_parenthesis)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty		
		end

	external_access_body (class_name, header_file_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- External access feature body
		require
			non_void_class_name: class_name /= Void
			valid_class_name: not class_name.empty
			non_void_header_file_name: header_file_name /= Void
			valud_header_file_name: not header_file_name.empty
			non_void_visitor: visitor /= Void
		do
			create Result.make (1000)
			Result.append (Tab_tab_tab)
			Result.append (Double_quote)
			Result.append (Cpp_clause)
			Result.append (class_name)
			Result.append (Space)
			Result.append (Percent_double_quote)
			Result.append (header_file_name)
			Result.append (Percent_double_quote)
			Result.append (Close_bracket)
			Result.append (Open_parenthesis)
			Result.append (Close_parenthesis)
			Result.append (Colon)
			if 
				visitor.is_basic_type or 
				visitor.vt_type = Vt_bool or
				visitor.is_enumeration
			then
				Result.append (visitor.cecil_type)
			else
				Result.append (Eif_reference)
			end
			Result.append (Double_quote)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty		
		end

	external_setting_body (class_name, header_file_name: STRING; visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- External setting body
		require
			non_void_class_name: class_name /= Void
			valid_class_name: not class_name.empty
			non_void_header_file_name: header_file_name /= Void
			valud_header_file_name: not header_file_name.empty
			non_void_visitor: visitor /= Void
		do
			create Result.make (1000)
			Result.append (Tab_tab_tab)
			Result.append (Double_quote)
			Result.append (Cpp_clause)
			Result.append (class_name)
			Result.append (Space)
			Result.append (Percent_double_quote)
			Result.append (header_file_name)
			Result.append (Percent_double_quote)
			Result.append (Close_bracket)
			Result.append (Open_parenthesis)
			if 
				visitor.is_array_basic_type or 
				visitor.is_interface or 
				visitor.is_structure 
			then
				Result.append (visitor.c_type)
				Result.append (Space)
				Result.append (Asterisk)

			elseif 
				visitor.is_structure_pointer 
			then
				Result.append (visitor.c_type)
				
			elseif
				visitor.is_interface_pointer or
				visitor.is_coclass_pointer
			then
				Result.append (Iunknown)

			elseif 
				visitor.is_basic_type or 
				visitor.vt_type = Vt_bool or
				visitor.is_enumeration
			then
				Result.append (visitor.cecil_type)
			else
				Result.append (Eif_object)
			end
			Result.append (Close_parenthesis)
			Result.append (Double_quote)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty		
		end

end -- class WIZARD_EIFFEL_CLIENT_PROPERTY_GENERATOR

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
