indexing
	description: "Coclass eiffel server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_SERVER_IMPL_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR [WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_GENERATOR]
		redefine
			generate,
			set_default_ancestors
		end

	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR 
		redefine
			set_default_ancestors
		end

feature -- Basic operation

	generate (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			local_string: STRING
			a_visible: WIZARD_WRITER_VISIBLE_CLAUSE
			interface_processor: WIZARD_COCLASS_INTERFACE_EIFFEL_PROCESSOR 
						[WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_GENERATOR]
		do
			coclass_descriptor := a_coclass

			if not shared_wizard_environment.new_eiffel_project then
				create a_visible.make
				a_visible.set_name (implemented_coclass_name (a_coclass.eiffel_class_name))
				system_descriptor.add_visible_class_component (a_visible)

				create eiffel_writer.make

				eiffel_writer.set_class_name (implemented_coclass_name (a_coclass.eiffel_class_name))

				-- Process interfaces.
				create interface_processor.make (a_coclass, eiffel_writer)
				interface_processor.process_interfaces
				interface_processor := Void

				local_string := clone (a_coclass.eiffel_class_name)
				local_string.append (" Implementation.")
				eiffel_writer.set_description (local_string)

				set_default_ancestors (eiffel_writer)
				add_creation
				add_default_features (a_coclass)

				-- Generate code
				Shared_file_name_factory.create_file_name (Current, eiffel_writer)
				eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)
			end

			eiffel_writer := Void
		end

	add_creation is
			-- Add creation clause,.
		do
			eiffel_writer.add_creation_routine (Make_word)
		end

	add_default_features (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add default features to coclass server. 
			-- e.g. make, constructor etc.
		do
			eiffel_writer.add_feature (make_feature, Initialization)
		end


	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
		local
			tmp_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create tmp_writer.make

			if shared_wizard_environment.new_eiffel_project then
				tmp_writer.set_name (shared_wizard_environment.eiffel_class_name)
			else
				tmp_writer.set_name (coclass_descriptor.eiffel_class_name)
			end

			an_eiffel_writer.add_inherit_clause (tmp_writer)

			create tmp_writer.make
			tmp_writer.set_name ("ECOM_EXCEPTION")

			an_eiffel_writer.add_inherit_clause (tmp_writer)

			create tmp_writer.make
			tmp_writer.set_name ("ECOM_STUB")
			an_eiffel_writer.add_inherit_clause (tmp_writer)

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
