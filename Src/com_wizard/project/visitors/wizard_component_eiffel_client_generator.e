indexing
	description: "Component Eiffel generator for client"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

	WIZARD_COMPONENT_CLIENT_GENERATOR
	
feature -- Basic operations

	generate_functions_and_properties (a_interface_desc: WIZARD_INTERFACE_DESCRIPTOR;
				a_component: WIZARD_COMPONENT_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Generate functions and properties of 'a_interface_desc'
		local
			function_generator: WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR
			property_generator: WIZARD_EIFFEL_CLIENT_PROPERTY_GENERATOR
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			tmp_original_name, tmp_changed_name: STRING
		do
			create inherit_clause.make
			inherit_clause.set_name (a_interface_desc.eiffel_class_name)

			if not a_interface_desc.properties.empty then
				from
					a_interface_desc.properties.start
				until
					a_interface_desc.properties.off
				loop
					create property_generator

					property_generator.generate (a_component, a_interface_desc.properties.item)
					an_eiffel_writer.add_feature (property_generator.access_feature, Access)
					an_eiffel_writer.add_feature (property_generator.external_access_feature, Externals)
					an_eiffel_writer.add_feature (property_generator.external_setting_feature, Externals)
					an_eiffel_writer.add_feature (property_generator.setting_feature, Element_change)

					if property_generator.property_renamed then
						from
							property_generator.changed_names.start
						until
							property_generator.changed_names.off
						loop
							inherit_clause.add_rename (property_generator.changed_names.key_for_iteration, 
													property_generator.changed_names.item_for_iteration)
							property_generator.changed_names.forth
						end
					end

					a_interface_desc.properties.forth
				end
			end

			if not a_interface_desc.functions.empty then
				from
					a_interface_desc.functions.start
				until
					a_interface_desc.functions.off
				loop
					create function_generator
					function_generator.generate (a_component, a_interface_desc.functions.item)

					if function_generator.function_renamed then
						inherit_clause.add_rename (function_generator.original_name, function_generator.changed_name)
						tmp_original_name := vartype_namer.user_precondition_name (function_generator.original_name)
						tmp_changed_name := vartype_namer.user_precondition_name (function_generator.changed_name)
						inherit_clause.add_rename (tmp_original_name, tmp_changed_name)
					end

					if (function_generator.feature_writer.result_type /= Void and then 
						not function_generator.feature_writer.result_type.empty) and
						(function_generator.feature_writer.arguments = Void or else function_generator.feature_writer.arguments.empty)
					then
						an_eiffel_writer.add_feature (function_generator.feature_writer, Access)
						an_eiffel_writer.add_feature (function_generator.external_feature_writer, Externals)
					else
						an_eiffel_writer.add_feature (function_generator.feature_writer, Basic_operations)
						an_eiffel_writer.add_feature (function_generator.external_feature_writer, Externals)
					end

					a_interface_desc.functions.forth
				end
			end
			an_eiffel_writer.add_inherit_clause (inherit_clause)
		end

feature {NONE} -- Implementation

	ccom_create_from_pointer_feature_name: STRING
			-- Name of external feature create from pointer.

	ccom_delete_feature_name: STRING
			-- Name of external delete feature.

	ccom_create_feature_name: STRING
			-- Name of external create feature.

	make_from_pointer_feature: WIZARD_WRITER_FEATURE is
			-- `make_from_pointer' function
		local
			feature_body: STRING
		do
			create Result.make

			Result.set_name ("make_from_pointer")
			Result.set_comment ("Make from pointer")
			Result.add_argument (clone (Default_pointer_argument))
			Result.set_effective

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Initializer_variable)
			feature_body.append (Space)
			feature_body.append (Assignment)
			feature_body.append (Space)
			feature_body.append (ccom_create_from_pointer_feature_name)
			feature_body.append (Open_parenthesis)
			feature_body.append ("cpp_obj")
			feature_body.append (Close_parenthesis)
			feature_body.append (New_line_tab_tab_tab)

			feature_body.append (Item_clause)
			feature_body.append (Space)
			feature_body.append (Assignment)
			feature_body.append (Space)
			feature_body.append (Ccom_item_function_name)
			feature_body.append (Space)
			feature_body.append (Open_parenthesis)
			feature_body.append (Initializer_variable)
			feature_body.append (Close_parenthesis)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	create_coclass_from_pointer_feature (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Set `ccom_create_[coclass_name]_from_pointer' external feature.
			-- Call C++ constructor
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (ccom_create_from_pointer_feature_name)
			Result.set_comment ("Create from pointer")
			Result.set_result_type (Pointer_type)
			Result.add_argument (clone (Pointer_variable))
			Result.set_external

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (New)
			feature_body.append (Space)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Iunknown_pointer)
			feature_body.append (Close_parenthesis)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)

		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	delete_wrapper_feature: WIZARD_WRITER_FEATURE is
			-- `delete_wrapper' feature.
		local
			feature_body: STRING
		do
			create Result.make

			Result.set_name ("delete_wrapper")
			Result.set_comment ("Delete wrapper")
			Result.set_effective
			
			feature_body := clone (Tab_tab_tab)
			feature_body.append (ccom_delete_feature_name)
			feature_body.append (Open_parenthesis)
			feature_body.append (Initializer_variable)
			feature_body.append (Close_parenthesis)
			
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	delete_coclass_feature (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Set "ccom_delete_[coclass_name]" external feature
			-- Call C++ destructor
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (ccom_delete_feature_name)
			Result.set_comment ("Release resource")
			Result.add_argument (Pointer_variable)
			Result.set_external

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (Delete)
			feature_body.append (Space)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Close_parenthesis)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	create_coclass_feature (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `create_coclass' external feature.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
			non_void_ccom_create_feature_name: ccom_create_feature_name /= Void
			valid_ccom_create_feature_name: not ccom_create_feature_name.empty
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (ccom_create_feature_name)
			Result.set_comment ("Creation")
			Result.set_result_type (Pointer_type)
			Result.set_external

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (New)
			feature_body.append (Space)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Close_parenthesis)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	ccom_item_feature  (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `ccom_item' feature.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_item_function_name)
			Result.set_comment ("Item")
			Result.set_external
			Result.set_result_type (Pointer_type)
			Result.add_argument (clone (Default_pointer_argument))

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Close_parenthesis)
			feature_body.append (Colon)
			feature_body.append (Eif_pointer)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	last_error_code_feature: WIZARD_WRITER_FEATURE is
			-- `last_error_code' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (clone (last_error_code_name))
			Result.set_comment ("Last error code.")
			Result.set_result_type (Integer_type)

			create feature_body.make (0)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Result_clause)
			feature_body.append (ccom_last_error_code_name)
			feature_body.append (Space_open_parenthesis)
			feature_body.append (Initializer_variable)
			feature_body.append (close_parenthesis)

			Result.set_body (feature_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.empty
			non_void_feature_comment: Result.comment /= Void
			valid_feature_comment: not Result.comment.empty
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.empty
		end

	last_source_of_exception_feature: WIZARD_WRITER_FEATURE is
			-- `last_source_of_exception' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (clone (last_source_of_exception_name))
			Result.set_comment ("Last source of exception.")
			Result.set_result_type (String_type)

			create feature_body.make (0)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Result_clause)
			feature_body.append (ccom_last_source_of_exception_name)
			feature_body.append (Space_open_parenthesis)
			feature_body.append (Initializer_variable)
			feature_body.append (close_parenthesis)

			Result.set_body (feature_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.empty
			non_void_feature_comment: Result.comment /= Void
			valid_feature_comment: not Result.comment.empty
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.empty
		end

	last_error_description_feature: WIZARD_WRITER_FEATURE is
			-- `last_error_description' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (clone (last_error_description_name))
			Result.set_comment ("Last error description.")
			Result.set_result_type (String_type)

			create feature_body.make (0)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Result_clause)
			feature_body.append (ccom_last_error_description_name)
			feature_body.append (Space_open_parenthesis)
			feature_body.append (Initializer_variable)
			feature_body.append (close_parenthesis)

			Result.set_body (feature_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.empty
			non_void_feature_comment: Result.comment /= Void
			valid_feature_comment: not Result.comment.empty
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.empty
		end

	last_error_help_file_feature: WIZARD_WRITER_FEATURE is
			-- `last_error_help_file' feature.
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (clone (last_error_help_file_name))
			Result.set_comment ("Last error help file.")
			Result.set_result_type (String_type)

			create feature_body.make (0)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Result_clause)
			feature_body.append (ccom_last_error_help_file_name)
			feature_body.append (Space_open_parenthesis)
			feature_body.append (Initializer_variable)
			feature_body.append (close_parenthesis)

			Result.set_body (feature_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.empty
			non_void_feature_comment: Result.comment /= Void
			valid_feature_comment: not Result.comment.empty
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.empty
		end

	ccom_last_error_code_feature  (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `ccom_last_error_code' feature.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_code_name)
			Result.set_comment ("Last error code")
			Result.set_external
			Result.set_result_type (Integer_type)
			Result.add_argument (clone (Default_pointer_argument))

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Close_parenthesis)
			feature_body.append (Colon)
			feature_body.append (Eif_integer)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	ccom_last_source_of_exception_feature  (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `ccom_last_error_code' feature.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_source_of_exception_name)
			Result.set_comment ("Last source of exception")
			Result.set_external
			Result.set_result_type (String_type)
			Result.add_argument (clone (Default_pointer_argument))

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Close_parenthesis)
			feature_body.append (Colon)
			feature_body.append (Eif_reference)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	ccom_last_error_description_feature  (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `ccom_last_error_description' feature.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_description_name)
			Result.set_comment ("Last error description")
			Result.set_external
			Result.set_result_type (String_type)
			Result.add_argument (clone (Default_pointer_argument))

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Close_parenthesis)
			feature_body.append (Colon)
			feature_body.append (Eif_reference)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	ccom_last_error_help_file_feature  (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `ccom_last_error_help_file' feature.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_help_file_name)
			Result.set_comment ("Last error help file")
			Result.set_external
			Result.set_result_type (String_type)
			Result.add_argument (clone (Default_pointer_argument))

			feature_body := clone (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Close_parenthesis)
			feature_body.append (Colon)
			feature_body.append (Eif_reference)
			feature_body.append (Double_quote)

			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

end -- class WIZARD_COMPONENT_EIFFEL_CLIENT_GENERATOR

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
