indexing
	description: "Coclass eiffel server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR
		redefine
			generate
		end

feature -- Initialization

	initialize is
			-- Initialize generator.
		do
			eiffel_writer := Void
			dispatch_interface := False
			coclass_descriptor := Void
		ensure
			void_writer: eiffel_writer = Void
			void_coclass_descriptor: coclass_descriptor = Void
			not_dispatch_interface: dispatch_interface = False
		end

feature -- Access

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			definition_file_generator: WIZARD_DEFINITION_FILE_GENERATOR
		do
			Precursor {WIZARD_COCLASS_EIFFEL_GENERATOR} (a_descriptor)
			coclass_descriptor := a_descriptor

			add_default_features

			check
				valid_writer: eiffel_writer.can_generate
			end

			-- Generate code and file name.
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			if shared_wizard_environment.in_process_server then
				create definition_file_generator
				definition_file_generator.generate (coclass_descriptor)
			end
		end

feature --  Basic operation

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	add_default_features is
			-- Generate process dependent feature
		do
			if shared_wizard_environment.in_process_server then
				eiffel_writer.add_feature (dll_register_server_feature, Externals)
				eiffel_writer.add_feature (dll_unregister_server_feature, Externals)
				eiffel_writer.add_feature (dll_get_class_object_feature, Basic_operations)
				eiffel_writer.add_feature (dll_can_unload_now_feature, Externals)
				eiffel_writer.add_feature (ccom_get_class_object_feature, Externals)
			else
				add_initialize_feature
			end
		end

	ccom_embedding_feature: WIZARD_WRITER_FEATURE is
			-- 'ccom_initialize' feature
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_external
			Result.set_comment ("Initialize server with %"EMBEDDING%" option.")

			tmp_string := clone (Type_id_variable_name)
			tmp_string.append (Colon)
			tmp_string.append (Space)
			tmp_string.append (Integer_type)

			Result.add_argument (tmp_string)

			Result.set_name (Ccom_embedding_feature_name)

			tmp_string := clone (Tab_tab_tab)
			tmp_string.append (Double_quote)
			tmp_string.append (C_keyword)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Eif_type_id)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (C_binary_or)
			tmp_string.append (Percent_double_quote)
			tmp_string.append (Server_registration_header_file_name)
			tmp_string.append (Percent_double_quote)
			tmp_string.append (Double_quote)

			Result.set_body (tmp_string)
		ensure
			valid_writer: Result.can_generate
		end

	ccom_regserver_feature: WIZARD_WRITER_FEATURE is
			-- 'ccom_initialize' feature
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_external
			Result.set_comment ("Register server.")

			tmp_string := clone (Type_id_variable_name)
			tmp_string.append (Colon)
			tmp_string.append (Space)
			tmp_string.append (Integer_type)

			Result.add_argument (tmp_string)

			Result.set_name (Ccom_regserver_feature_name)

			tmp_string := clone (Tab_tab_tab)
			tmp_string.append (Double_quote)
			tmp_string.append (C_keyword)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Eif_type_id)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (C_binary_or)
			tmp_string.append (Percent_double_quote)
			tmp_string.append (Server_registration_header_file_name)
			tmp_string.append (Percent_double_quote)
			tmp_string.append (Double_quote)

			Result.set_body (tmp_string)
		ensure
			valid_writer: Result.can_generate
		end

	ccom_unregserver_feature: WIZARD_WRITER_FEATURE is
			-- 'ccom_initialize' feature
		local
			tmp_string: STRING
		do
			create Result.make
			Result.set_external
			Result.set_comment ("Unregister server.")

			tmp_string := clone (Type_id_variable_name)
			tmp_string.append (Colon)
			tmp_string.append (Space)
			tmp_string.append (Integer_type)

			Result.add_argument (tmp_string)

			Result.set_name (Ccom_unregserver_feature_name)

			tmp_string := clone (Tab_tab_tab)
			tmp_string.append (Double_quote)
			tmp_string.append (C_keyword)
			tmp_string.append (Space_open_parenthesis)
			tmp_string.append (Eif_type_id)
			tmp_string.append (Close_parenthesis)
			tmp_string.append (C_binary_or)
			tmp_string.append (Percent_double_quote)
			tmp_string.append (Server_registration_header_file_name)
			tmp_string.append (Percent_double_quote)
			tmp_string.append (Double_quote)

			Result.set_body (tmp_string)
		ensure
			valid_writer: Result.can_generate
		end

	initialize_feature: WIZARD_WRITER_FEATURE is
			-- 'initialize" feature
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Initialize_function_name)
			Result.set_effective
			Result.set_comment ("Initialize COM component.")

			tmp_body := clone (Tab_tab_tab)
			tmp_body.append (argument_test_code (Register_server_option_a, Register_server_option_b, Ccom_regserver_feature_name))
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Else_keyword)
			tmp_body.append (Space)
			tmp_body.append (argument_test_code (Unregister_server_option_a, Unregister_server_option_b, Ccom_unregserver_feature_name))
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Else_keyword)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)
			tmp_body.append (Ccom_embedding_feature_name)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Dynamic_type_function_name)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Current_keyword)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (End_keyword)

			Result.set_body (tmp_body)
		ensure
			valid_writer: Result.can_generate
		end

	common_c_external_feature_code (argument_types: STRING): STRING is
			-- Common C external feature code
		do
			Result := clone (Tab_tab_tab)
			Result.append (Double_quote)
			Result.append (C_keyword)
			Result.append (Open_parenthesis)
			Result.append (Argument_types)
			Result.append (Close_parenthesis)
			Result.append (Colon)
			Result.append (Eif_pointer)
			Result.append (Space)
			Result.append (C_binary_or)
			Result.append (Space)
			Result.append (Percent_double_quote)
			Result.append (coclass_descriptor.c_type_name)
			Result.append (Factory)
			Result.append (Header_file_extension)
			Result.append (Percent_double_quote)
			Result.append (Double_quote)
		end
 
	dll_register_server_feature: WIZARD_WRITER_FEATURE is
			-- Dll_register_server feature
		do
			create Result.make

			Result.set_external
			Result.set_name (Register_dll_server_function_name)
			Result.set_comment ("Register Dll server")
			Result.set_result_type (Pointer_type)

			Result.set_body (common_c_external_feature_code (""))
		ensure
			valid_writer: Result.can_generate
		end

	dll_unregister_server_feature: WIZARD_WRITER_FEATURE is
			-- Dll_unregister_server feature
		do
			create Result.make

			Result.set_external
			Result.set_name (Unregister_dll_server_function_name)
			Result.set_comment ("Unregister Dll server")
			Result.set_result_type (Pointer_type)

			Result.set_body (common_c_external_feature_code (""))
		ensure
			valid_writer: Result.can_generate
		end

	dll_can_unload_now_feature: WIZARD_WRITER_FEATURE is
			-- Dll_can_unload_now feature
		local
			tmp_body: STRING
		do
			create Result.make

			Result.set_external
			Result.set_name (Can_unload_dll_now_function_name)
			Result.set_comment ("Can unload Dll now?")
			Result.set_result_type (Pointer_type)

			Result.set_body (common_c_external_feature_code (""))
		ensure
			valid_writer: Result.can_generate
		end

	dll_get_class_object_feature: WIZARD_WRITER_FEATURE is
			-- Dll_get_class_object_feature
		local
			tmp_body: STRING
		do
			create Result.make

			Result.set_effective
			Result.set_name (Get_class_object_function_name)
			Result.set_comment ("Get class object.")
			Result.set_result_type (Pointer_type)

			Result.add_argument ("class_id: POINTER")
			Result.add_argument ("riid: POINTER")
			Result.add_argument ("interface_pointer: POINTER")

			tmp_body := clone (Tab_tab_tab)
			tmp_body.append (Result_clause)
			tmp_body.append (Ccom_clause)
			tmp_body.append (Get_class_object_function_name)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Dynamic_type_function_name)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Current_keyword)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Comma_space)
			tmp_body.append ("class_id, riid, interface_pointer")
			tmp_body.append (Close_parenthesis)

			Result.set_body (tmp_body)
		ensure
			valid_writer: Result.can_generate
		end

	ccom_get_class_object_feature: WIZARD_WRITER_FEATURE is
			-- "ccom_get_class_object" feature
		local
			tmp_string: STRING
		do
			create Result.make

			Result.set_external
			tmp_string := clone (Ccom_clause)
			tmp_string.append (Get_class_object_function_name)

			Result.set_name (tmp_string)
			Result.set_comment ("Get class object.")
			Result.set_result_type (Pointer_type)

			Result.add_argument ("tid: INTEGER")
			Result.add_argument ("class_id: POINTER")
			Result.add_argument ("riid: POINTER")
			Result.add_argument ("interface_pointer: POINTER")

			Result.set_body (common_c_external_feature_code ("EIF_TYPE_ID, REFCLSID, REFIID, (void **)"))
		ensure
			valid_writer: Result.can_generate
		end

	argument_test_code (input_a, input_b, feature_name: STRING): STRING is
			-- Code to test 
		require
			non_void_input_a: input_a /= Void
			non_void_input_b: input_b /= Void
			non_void_name: feature_name /= Void
			valid_input_a: not input_a.empty
			valid_input_b: not input_b.empty
			valid_name: not feature_name.empty
		do
			Result := clone (If_keyword)
			Result.append (Space)
			Result.append (Index_of_word_option_function_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			Result.append (input_a)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (More)
			Result.append (Space)
			Result.append (Zero)
			Result.append (Space)
			Result.append (Or_keyword)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab_tab)
			Result.append (Index_of_word_option_function_name)
			Result.append (Space_open_parenthesis)
			Result.append (Double_quote)
			Result.append (input_b)
			Result.append (Double_quote)
			Result.append (Close_parenthesis)
			Result.append (Space)
			Result.append (More)
			Result.append (Space)
			Result.append (Zero)
			Result.append (Space)
			Result.append (Then_keyword)
			Result.append (New_line_tab_tab_tab)
			Result.append (Tab)
			Result.append (feature_name)
			Result.append (Space_open_parenthesis)
			Result.append (Dynamic_type_function_name)
			Result.append (Space_open_parenthesis)
			Result.append (Current_keyword)
			Result.append (Close_parenthesis)
			Result.append (Close_parenthesis)
		end

	generate_functions_and_properties (a_desc: WIZARD_INTERFACE_DESCRIPTOR;
				a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS;
				inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Process functions and properties
		local
			prop_generator: WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR
			func_generator: WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
		do
			if not a_desc.functions.empty then
				from
					a_desc.functions.start
				until
					a_desc.functions.off
				loop
					-- Generate feature writer
					create func_generator
					func_generator.generate (a_component_descriptor.name, a_desc.functions.item)

					if func_generator.function_renamed then
						inherit_clause.add_rename (func_generator.original_name, func_generator.changed_name)
					end

					if func_generator.feature_writer.result_type = Void or else 
						func_generator.feature_writer.result_type.empty 
					then
						an_eiffel_writer.add_feature (func_generator.feature_writer, Basic_operations)
					else
						an_eiffel_writer.add_feature (func_generator.feature_writer, Access)
					end
					a_desc.functions.forth
				end
			end
			if not a_desc.properties.empty then
				from
					a_desc.properties.start
				until
					a_desc.properties.off
				loop
					-- Generate feature writer
					create prop_generator
					prop_generator.generate(a_component_descriptor.eiffel_class_name, a_desc.properties.item)
					an_eiffel_writer.add_feature (prop_generator.setting_feature, Element_change)
					an_eiffel_writer.add_feature (prop_generator.access_feature, Access)

					if prop_generator.property_renamed then
						from
							prop_generator.changed_names.start
						until
							prop_generator.changed_names.off
						loop
							inherit_clause.add_rename (prop_generator.changed_names.key_for_iteration, prop_generator.changed_names.item_for_iteration)
							prop_generator.changed_names.forth
						end
					end

					a_desc.properties.forth
				end
			end

			if 
				a_desc.inherited_interface /= Void and not
				a_desc.inherited_interface.guid.is_equal (Iunknown_guid) and then
				not a_desc.inherited_interface.guid.is_equal (Idispatch_guid) 
			then
				generate_functions_and_properties (a_desc.inherited_interface, a_component_descriptor, an_eiffel_writer, inherit_clause)
			end		
		end

	add_creation is
		do
			if not shared_wizard_environment.in_process_server then
				eiffel_writer.add_creation_routine (Initialize_function_name)
			end
		end

	add_initialize_feature is
			-- Add creation routines.
		local
			inherit_clause_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create inherit_clause_writer.make
			inherit_clause_writer.set_name (Arguments_type)

			eiffel_writer.add_inherit_clause (inherit_clause_writer)

			create inherit_clause_writer.make
			inherit_clause_writer.set_name (Internal_type)
			eiffel_writer.add_inherit_clause (Inherit_clause_writer)

			eiffel_writer.add_feature (initialize_feature, Initialization)

			eiffel_writer.add_feature (ccom_embedding_feature, Externals)

			eiffel_writer.add_feature (ccom_regserver_feature, Externals)

			eiffel_writer.add_feature (ccom_unregserver_feature, Externals)
		end

end -- class WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR

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
