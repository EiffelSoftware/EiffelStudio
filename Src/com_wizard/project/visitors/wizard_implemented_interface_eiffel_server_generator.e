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
			create a_visible.make
			an_interface.set_impl_names (False)
			a_visible.set_name (an_interface.eiffel_class_name)
			system_descriptor.add_visible_class_component (a_visible)

			create eiffel_writer.make

			a_class_name := an_interface.eiffel_class_name

			dispatch_interface := (an_interface.interface_descriptor.dispinterface or 
					an_interface.interface_descriptor.dual)
			eiffel_writer.set_class_name (a_class_name)
			eiffel_writer.set_description (an_interface.description)

			create inherit_clause.make
			inherit_clause.set_name (an_interface.interface_descriptor.eiffel_class_name)

			create interface_generator.make (an_interface, an_interface.interface_descriptor, eiffel_writer, inherit_clause)
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
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	add_creation is
			-- Add creation routines.
		do
			eiffel_writer.add_creation_routine (Make_word)
		end

	add_default_features (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add default features,
			-- e.g. make, constructor, destructor, delete wrapper etc.
		do
			eiffel_writer.add_feature (make_feature, Initialization)
		end

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors
		local
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create inherit_clause.make
			inherit_clause.set_name ("ECOM_STUB")
			an_eiffel_writer.add_inherit_clause (inherit_clause)

			create inherit_clause.make
			inherit_clause.set_name ("ECOM_EXCEPTION")
			an_eiffel_writer.add_inherit_clause (inherit_clause)
		end

invariant
	invariant_clause: -- Your invariant here

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
