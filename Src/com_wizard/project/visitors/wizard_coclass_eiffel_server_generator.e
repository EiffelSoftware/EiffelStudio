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
			generate,
			set_default_ancestors
		end

	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR
		redefine
			set_default_ancestors,
			generate_functions_and_properties
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
			server_impl_generator: WIZARD_COCLASS_EIFFEL_SERVER_IMPL_GENERATOR
			new_descriptor: WIZARD_COCLASS_DESCRIPTOR
			local_string: STRING
		do

			Precursor {WIZARD_COCLASS_EIFFEL_GENERATOR} (a_descriptor)
			coclass_descriptor := a_descriptor

			add_default_features (a_descriptor)

			check
				valid_writer: eiffel_writer.can_generate
			end

			-- Set as deferred
			eiffel_writer.set_deferred

			-- Generate code and file name.
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			-- Server Implementation
			create server_impl_generator

			server_impl_generator.generate (coclass_descriptor)
			
			if shared_wizard_environment.in_process_server then
				create definition_file_generator
				definition_file_generator.generate (coclass_descriptor)
			end
		end

feature --  Basic operation

	generate_functions_and_properties (a_desc: WIZARD_INTERFACE_DESCRIPTOR;
				a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS;
				inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Process functions and properties
		local
			prop_generator: WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR
			func_generator: WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
			tmp_original_name, tmp_changed_name: STRING
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
						tmp_original_name := vartype_namer.user_precondition_name (func_generator.original_name)
						tmp_changed_name := vartype_namer.user_precondition_name (func_generator.changed_name)
						inherit_clause.add_rename (tmp_original_name, tmp_changed_name)
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


	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors.
		do
			Precursor {WIZARD_COCLASS_EIFFEL_GENERATOR} (an_eiffel_writer)

		end

	add_default_features (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate process dependent feature.
		do
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

	add_creation is
			-- Add creation procedures.
		do
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
