indexing
	description: "Source interface Eiffel client generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SOURCE_INTERFACE_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_SOURCE_INTERFACE_CLIENT_GENERATOR

	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

create
	generate

feature -- Initialization

	generate (an_interface: WIZARD_INTERFACE_DESCRIPTOR; a_coclass: WIZARD_COCLASS_DESCRIPTOR;
				an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Initialize
		do
			an_eiffel_writer.add_feature (enable_feature (an_interface), Basic_operations)
			an_eiffel_writer.add_feature (disable_feature (an_interface), Basic_operations)
			an_eiffel_writer.add_feature (boolean_feature (an_interface), Access)
			an_eiffel_writer.add_feature (external_enable_feature (an_interface, a_coclass), Externals)
			an_eiffel_writer.add_feature (external_disable_feature (an_interface, a_coclass), Externals)
		end

feature -- Basic operations

	enable_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `enable_call_back_on_...' feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		local
			a_precondition_body, a_body: STRING
			an_argument: STRING
			a_precondition, a_postcondition: WIZARD_WRITER_ASSERTION
		do
			create Result.make
			Result.set_effective

			Result.set_name (enable_feature_name (an_interface))

			Result.set_comment ("Enable call back.")

			create an_argument.make (100)
			an_argument.append ("some_events: ")
			an_argument.append (an_interface.implemented_interface.impl_eiffel_class_name (False))
			Result.add_argument (an_argument)

			create a_precondition_body.make (100)
			a_precondition_body.append ("not ")
			a_precondition_body.append (boolean_name (an_interface))
			create a_precondition.make ("disabled", a_precondition_body)
			Result.add_precondition (a_precondition)

			create a_precondition.make ("non_void_events", "some_events /= Void")
			Result.add_precondition (a_precondition)

			create a_postcondition.make ("enabled", boolean_name (an_interface))
			Result.add_postcondition(a_postcondition)

			create a_body.make (1000)
			a_body.append (tab_tab_tab)
			a_body.append ("if (some_events.item = default_pointer) then")
			a_body.append (New_line_tab_tab_tab)
			a_body.append (tab)
			a_body.append ("some_events.create_item")
			a_body.append (New_line_tab_tab_tab)
			a_body.append (End_keyword)
			a_body.append (New_line_tab_tab_tab)
			a_body.append (external_feature_name (enable_feature_name (an_interface)))
			a_body.append (Space_open_parenthesis)
			a_body.append (Initializer_variable)
			a_body.append (Comma_space)
			a_body.append ("some_events.item)")
			a_body.append (New_line_tab_tab_tab)
			a_body.append (boolean_name (an_interface))
			a_body.append (" := True")
			Result.set_body (a_body)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

	disable_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `disable_call_back_on_...' feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		local
			a_postcondition_body, a_body: STRING
			a_precondition, a_postcondition: WIZARD_WRITER_ASSERTION
		do
			create Result.make
			Result.set_effective

			Result.set_name (disable_feature_name (an_interface))

			Result.set_comment ("Disable call back.")

			create a_precondition.make ("enabled", boolean_name (an_interface))
			Result.add_precondition (a_precondition)

			create a_postcondition_body.make (100)
			a_postcondition_body.append ("not ")
			a_postcondition_body.append (boolean_name (an_interface))
			create a_postcondition.make ("disabled", a_postcondition_body)
			Result.add_postcondition(a_postcondition)

			create a_body.make (1000)
			a_body.append (tab_tab_tab)
			a_body.append (external_feature_name (disable_feature_name (an_interface)))
			a_body.append (Space_open_parenthesis)
			a_body.append (Initializer_variable)
			a_body.append (Close_parenthesis)
			a_body.append (New_line_tab_tab_tab)
			a_body.append (boolean_name (an_interface))
			a_body.append (" := False")
			Result.set_body (a_body)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

	boolean_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- Boolean feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make
			Result.set_attribute
			
			Result.set_name (boolean_name (an_interface))
			Result.set_comment ("Is call back enabled?")

			Result.set_result_type (Boolean_type)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

	boolean_name (an_interface: WIZARD_INTERFACE_DESCRIPTOR): STRING is
			-- Name of call back boolean.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
		do
			create Result.make (100)
			Result.append ("call_bacl_on_")
			Result.append (name_for_feature (an_interface.name))
			Result.append ("_enabled")
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

	external_enable_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR; 
				a_coclass: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- External enable call back eature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
			non_void_coclass: a_coclass /= Void
			non_void_coclass_c_type_name: a_coclass.c_type_name /= Void
			valid_coclass_c_type_name: not a_coclass.c_type_name.is_empty
			non_void_coclass_header_file_name: a_coclass.c_header_file_name /= Void
			valid_coclass_header_file_name: not a_coclass.c_header_file_name.is_empty
		local
			a_body: STRING
		do
			create Result.make
			Result.set_external
			
			Result.set_name (external_feature_name (enable_feature_name (an_interface)))
			Result.set_comment ("Enable call back.")

			Result.add_argument (default_pointer_argument)
			Result.add_argument ("an_interface_pointer: POINTER")
			
			create a_body.make (100)
			a_body.append (Tab_tab_tab)
			a_body.append (Double_quote)
			a_body.append (Cpp_clause)
			if a_coclass.namespace /= Void and then not a_coclass.namespace.is_empty then
				a_body.append (a_coclass.namespace)
				a_body.append ("::")
			end
			a_body.append (a_coclass.c_type_name)
			a_body.append (Space)
			a_body.append (Percent_double_quote)
			a_body.append (a_coclass.c_header_file_name)
			a_body.append (Percent_double_quote)			
			a_body.append (Close_bracket)
			a_body.append (Open_parenthesis)
			a_body.append (Eif_pointer)
			a_body.append (Close_parenthesis)
			a_body.append (Double_quote)
			Result.set_body (a_body)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end
	
	external_disable_feature (an_interface: WIZARD_INTERFACE_DESCRIPTOR; 
				a_coclass: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- External disable call back feature.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_name: an_interface.name /= Void
			valid_interface_name: not an_interface.name.is_empty
			non_void_coclass: a_coclass /= Void
			non_void_coclass_c_type_name: a_coclass.c_type_name /= Void
			valid_coclass_c_type_name: not a_coclass.c_type_name.is_empty
			non_void_coclass_header_file_name: a_coclass.c_header_file_name /= Void
			valid_coclass_header_file_name: not a_coclass.c_header_file_name.is_empty
		local
			a_body: STRING
		do
			create Result.make
			Result.set_external
			
			Result.set_name (external_feature_name (disable_feature_name (an_interface)))
			Result.set_comment ("Disable call back.")
			
			Result.add_argument (default_pointer_argument)
			
			create a_body.make (100)
			a_body.append (Tab_tab_tab)
			a_body.append (Double_quote)
			a_body.append (Cpp_clause)
			if a_coclass.namespace /= Void and then not a_coclass.namespace.is_empty then
				a_body.append (a_coclass.namespace)
				a_body.append ("::")
			end
			a_body.append (a_coclass.c_type_name)
			a_body.append (Space)
			a_body.append (Percent_double_quote)
			a_body.append (a_coclass.c_header_file_name)
			a_body.append (Percent_double_quote)			
			a_body.append (Close_bracket)
			a_body.append (Open_parenthesis)
			a_body.append (Close_parenthesis)
			a_body.append (Double_quote)
			Result.set_body (a_body)
		ensure
			non_void_feature: Result /= Void
			valid_feature: Result.can_generate
		end

end -- class WIZARD_SOURCE_INTERFACE_EIFFEL_CLIENT_GENERATOR

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
