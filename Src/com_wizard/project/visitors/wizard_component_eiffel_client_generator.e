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
			l_body: STRING
		do
			create Result.make

			Result.set_name ("make_from_pointer")
			Result.set_comment ("Make from pointer")
			Result.add_argument ("a_object: POINTER")
			Result.set_effective

			create l_body.make (10000)
			l_body.append ("%T%T%Tinitializer := ")
			l_body.append (ccom_create_from_pointer_feature_name)
			l_body.append ("(a_object)%N%T%T%Titem := ccom_item (initializer)")
			Result.set_body (l_body)
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
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_create_from_pointer_feature_name)
			Result.set_comment ("Create from pointer")
			Result.set_result_type (Pointer_type)
			Result.add_argument ("a_pointer: POINTER")
			Result.set_external

			create l_body.make (1000)
			l_body.append ("%T%T%T%"C++ [new ")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"](IUnknown *)%"")
			Result.set_body (l_body)

		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	delete_wrapper_feature: WIZARD_WRITER_FEATURE is
			-- `delete_wrapper' feature.
		local
			l_body: STRING
		do
			create Result.make

			Result.set_name ("delete_wrapper")
			Result.set_comment ("Delete wrapper")
			Result.set_effective
			
			create l_body.make (500)
			l_body.append ("%T%T%T")
			l_body.append (ccom_delete_feature_name)
			l_body.append ("(initializer)")
			Result.set_body (l_body)
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
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_delete_feature_name)
			Result.set_comment ("Release resource")
			Result.add_argument ("a_pointer: POINTER")
			Result.set_external

			create l_body.make (500)
			l_body.append ("%T%T%T%"C++ [delete ")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"]()%"")
			Result.set_body (l_body)
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
			valid_ccom_create_feature_name: not ccom_create_feature_name.is_empty
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_create_feature_name)
			Result.set_comment ("Creation")
			Result.set_result_type ("POINTER")
			Result.set_external

			create l_body.make (500)
			l_body.append ("%T%T%T%"C++ [new ")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"]()%"")
			Result.set_body (l_body)
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
			l_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_item_function_name)
			Result.set_comment ("Item")
			Result.set_external
			Result.set_result_type ("POINTER")
			Result.add_argument (Default_pointer_argument.twin)

			create l_body.make (500)
			l_body.append ("%T%T%T%"C++ [")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"](): EIF_POINTER%"")
			Result.set_body (l_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	last_error_code_feature: WIZARD_WRITER_FEATURE is
			-- `last_error_code' feature.
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (last_error_code_name.twin)
			Result.set_comment ("Last error code.")
			Result.set_result_type ("INTEGER")

			create l_body.make (1000)
			l_body.append ("%T%T%TResult := ")
			l_body.append (ccom_last_error_code_name)
			l_body.append (" (initializer)")
			Result.set_body (l_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.is_empty
			non_void_feature_comment: Result.comment /= Void
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.is_empty
		end

	last_source_of_exception_feature: WIZARD_WRITER_FEATURE is
			-- `last_source_of_exception' feature.
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (last_source_of_exception_name.twin)
			Result.set_comment ("Last source of exception.")
			Result.set_result_type ("STRING")

			create l_body.make (1000)
			l_body.append ("%T%T%TResult := ")
			l_body.append (ccom_last_source_of_exception_name)
			l_body.append (" (initializer)")
			Result.set_body (l_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.is_empty
			non_void_feature_comment: Result.comment /= Void
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.is_empty
		end

	last_error_description_feature: WIZARD_WRITER_FEATURE is
			-- `last_error_description' feature.
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (last_error_description_name.twin)
			Result.set_comment ("Last error description.")
			Result.set_result_type ("STRING")

			create l_body.make (1000)
			l_body.append ("%T%T%TResult := ")
			l_body.append (ccom_last_error_description_name)
			l_body.append (" (initializer)")
			Result.set_body (l_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.is_empty
			non_void_feature_comment: Result.comment /= Void
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.is_empty
		end

	last_error_help_file_feature: WIZARD_WRITER_FEATURE is
			-- `last_error_help_file' feature.
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (last_error_help_file_name.twin)
			Result.set_comment ("Last error help file.")
			Result.set_result_type ("STRING")

			create l_body.make (1000)
			l_body.append ("%T%T%TResult := ")
			l_body.append (ccom_last_error_help_file_name)
			l_body.append (" (initializer)")
			Result.set_body (l_body)
			Result.set_effective
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			valid_feature_name: not Result.name.is_empty
			non_void_feature_comment: Result.comment /= Void
			non_void_feature_body: Result.body /= Void
			valid_feature_body: not Result.body.is_empty
		end

	ccom_last_error_code_feature  (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `ccom_last_error_code' feature.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_code_name)
			Result.set_comment ("Last error code")
			Result.set_external
			Result.set_result_type ("INTEGER")
			Result.add_argument ("a_object: POINTER")

			create l_body.make (500)
			l_body.append ("%T%T%T%"C++ [")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"](): EIF_INTEGER%"")
			Result.set_body (l_body)
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
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_source_of_exception_name)
			Result.set_comment ("Last source of exception")
			Result.set_external
			Result.set_result_type ("STRING")
			Result.add_argument ("a_object: POINTER")

			create l_body.make (500)
			l_body.append ("%T%T%T%"C++ [")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"](): EIF_REFERENCE%"")

			Result.set_body (l_body)
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
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_description_name)
			Result.set_comment ("Last error description")
			Result.set_external
			Result.set_result_type ("STRING")
			Result.add_argument ("a_object: POINTER")

			create l_body.make (500)
			l_body.append ("%T%T%T%"C++ [")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"](): EIF_REFERENCE%"")
			Result.set_body (l_body)
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
			l_body: STRING
		do
			create Result.make
			Result.set_name (ccom_last_error_help_file_name)
			Result.set_comment ("Last error help file")
			Result.set_external
			Result.set_result_type ("STRING")
			Result.add_argument ("a_object: POINTER")

			create l_body.make (500)
			l_body.append ("%T%T%T%"C++ [")
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				l_body.append (a_component_descriptor.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component_descriptor.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component_descriptor.c_definition_header_file_name)
			l_body.append ("%%%"](): EIF_REFERENCE%"")
			Result.set_body (l_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

end -- class WIZARD_COMPONENT_EIFFEL_CLIENT_GENERATOR

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

