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
	
	ECOM_TYPE_FLAGS
		export
			{NONE} all
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

			create feature_body.make (10000)
			feature_body.append (Tab_tab_tab)
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

			create feature_body.make (1000)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (New)
			feature_body.append (Space)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
			feature_body.append (a_component_descriptor.c_type_name)
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (a_component_descriptor.c_header_file_name)
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append (Open_parenthesis)
			feature_body.append (Iunknown)
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
			
			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
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

			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (Delete)
			feature_body.append (Space)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
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

			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			feature_body.append (New)
			feature_body.append (Space)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
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

			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
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

			create feature_body.make (1000)
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

			create feature_body.make (1000)
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

			create feature_body.make (1000)
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

			create feature_body.make (1000)
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

			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
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

			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
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

			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
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

			create feature_body.make (500)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Double_quote)
			feature_body.append (Cpp_clause)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.empty then
				feature_body.append (a_component_descriptor.namespace)
				feature_body.append ("::")
			end
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
