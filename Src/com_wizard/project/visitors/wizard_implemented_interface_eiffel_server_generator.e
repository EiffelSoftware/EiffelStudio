indexing
	description: "Objects that ..."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Initialization

	initialize is
			-- Initialize generator.
		do
			eiffel_writer := Void
		ensure
			void_writer: eiffel_writer = Void
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	generate (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate 
		local
			a_class_name: STRING
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create eiffel_writer.make

			a_class_name := name_for_class (a_descriptor.name, a_descriptor.type_kind, False)

			dispatch_interface := (a_descriptor.interface_descriptor.dispinterface or a_descriptor.interface_descriptor.dual)
			eiffel_writer.set_class_name (a_class_name)
			eiffel_writer.set_description (a_descriptor.description)

			create inherit_clause.make
			inherit_clause.set_name (a_descriptor.interface_descriptor.eiffel_class_name)
			generate_functions_and_properties (a_descriptor.interface_descriptor, a_descriptor, eiffel_writer, inherit_clause)
			eiffel_writer.add_inherit_clause (inherit_clause)
			set_default_ancestors (eiffel_writer)
			add_creation
			add_default_features (a_descriptor)
			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

		ensure then
			non_void_eiffel_writer: eiffel_writer /= Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	add_creation is
			-- Add creation routines.
		do
		end

	add_default_features (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add default features,
			-- e.g. make, constructor, destructor, delete wrapper etc.
		do
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
