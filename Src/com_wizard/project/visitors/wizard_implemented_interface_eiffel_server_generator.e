indexing
	description: "Server implemented interface generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Basic operations

	generate (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate 
		local
			a_class_name: STRING
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			a_visible: WIZARD_WRITER_VISIBLE_CLAUSE
			interface_generator: WIZARD_COMPONENT_INTERFACE_EIFFEL_SERVER_GENERATOR
		do
			a_class_name := an_interface.impl_eiffel_class_name (False)

			create a_visible.make
			an_interface.set_impl_names (False)
			a_visible.set_name (an_interface.eiffel_class_name)
			system_descriptor.add_visible_class_server (a_visible)

			create eiffel_writer.make

			dispatch_interface := (an_interface.interface_descriptor.dispinterface or 
					an_interface.interface_descriptor.dual)
			eiffel_writer.set_class_name (a_class_name)
			eiffel_writer.set_description (an_interface.description)

			create inherit_clause.make
			inherit_clause.set_name (an_interface.interface_descriptor.eiffel_class_name)

			if an_interface.source then
				create {WIZARD_COMPONENT_INTERFACE_SOURCE_EIFFEL_SERVER_GENERATOR}
					interface_generator.make (an_interface, an_interface.interface_descriptor, eiffel_writer, inherit_clause)
			else 
				create interface_generator.make (an_interface, an_interface.interface_descriptor, eiffel_writer, inherit_clause)
			end
			interface_generator.generate_functions_and_properties (an_interface.interface_descriptor)
			eiffel_writer.add_inherit_clause (inherit_clause)
			set_default_ancestors (eiffel_writer)
			add_creation
			add_default_features (an_interface)
			
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			eiffel_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_impl_interface_eiffel_server
		end

feature {NONE} -- Implementation

	add_creation is
			-- Add creation routines.
		do
		end

	add_default_features (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add default features,
			-- e.g. make, constructor, destructor, delete wrapper etc.
		do
			eiffel_writer.add_feature (create_item_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_create_item_feature (an_interface), Externals)
		end

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create inherit_clause.make
			inherit_clause.set_name ("ECOM_STUB")
			an_eiffel_writer.add_inherit_clause (inherit_clause)
		end

	ccom_create_item_feature (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `create_item' feature.
		local
			feature_body: STRING
			an_argument: STRING
		do
			create Result.make
			Result.set_name ("ccom_create_item")
			Result.set_comment ("Initialize %Qitem%'")

			create an_argument.make (100)
			an_argument.append ("eif_object: ")
			an_argument.append (an_interface.impl_eiffel_class_name (False))
			Result.add_argument (an_argument)

			Result.set_result_type ("POINTER")

			create feature_body.make (100)
			feature_body.append (Tab_tab_tab)
			feature_body.append ("%"C++ %(new ")
			if an_interface.namespace /= Void and then not an_interface.namespace.is_empty then
				feature_body.append (an_interface.namespace)
				feature_body.append ("::")
			end
			feature_body.append (an_interface.impl_c_type_name (False))
			feature_body.append (Space)
			feature_body.append (Percent_double_quote)
			feature_body.append (an_interface.impl_c_header_file_name (False))
			feature_body.append (Percent_double_quote)
			feature_body.append (Close_bracket)
			feature_body.append ("(EIF_OBJECT)")
			feature_body.append (double_quote)

			Result.set_external
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

end -- class WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_SERVER_GENERATOR

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
