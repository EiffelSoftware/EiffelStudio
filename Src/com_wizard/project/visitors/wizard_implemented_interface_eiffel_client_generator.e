indexing
	description: "Implemented interface Eiffel client generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_CLIENT_GENERATOR

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

feature -- Basic operations

	generate (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate 
		local
			a_class_name: STRING
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create eiffel_writer.make

			a_class_name := name_for_class (a_descriptor.name, a_descriptor.type_kind, True)

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

			if dispatch_interface then
				eiffel_writer.add_feature (last_error_code_feature, Status_report)
				eiffel_writer.add_feature (last_error_description_feature, Status_report)
				eiffel_writer.add_feature (last_error_help_file_feature, Status_report)
				eiffel_writer.add_feature (last_source_of_exception_feature, Status_report)
				eiffel_writer.add_feature (ccom_last_error_code_feature (a_descriptor), Externals)
				eiffel_writer.add_feature (ccom_last_error_description_feature (a_descriptor), Externals)
				eiffel_writer.add_feature (ccom_last_error_help_file_feature (a_descriptor), Externals)
				eiffel_writer.add_feature (ccom_last_source_of_exception_feature (a_descriptor), Externals)

			end

			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

		ensure then
			non_void_eiffel_writer: eiffel_writer /= Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_client
		end

feature {NONE} -- Implementation

	add_creation is
			-- Add creation routines.
		do
			eiffel_writer.add_creation_routine (Make_from_other)
			eiffel_writer.add_creation_routine (Make_from_pointer)
		end

	add_default_features (an_implemented_interface_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add default features,
			-- e.g. make, constructor, destructor, delete wrapper etc.
		local
			a_coclass_name: STRING
		do
			a_coclass_name := name_for_feature (clone (an_implemented_interface_descriptor.eiffel_class_name))

			create ccom_create_from_pointer_feature_name.make (0)
			ccom_create_from_pointer_feature_name.append (Ccom_clause)
			ccom_create_from_pointer_feature_name.append ("create_")
			ccom_create_from_pointer_feature_name.append (a_coclass_name)
			ccom_create_from_pointer_feature_name.append ("_from_pointer")

			create ccom_delete_feature_name.make (0)
			ccom_delete_feature_name.append (Ccom_clause)
			ccom_delete_feature_name.append ("delete_")
			ccom_delete_feature_name.append (a_coclass_name)

			eiffel_writer.add_feature (delete_coclass_feature (an_implemented_interface_descriptor), Externals)
			eiffel_writer.add_feature (delete_wrapper_feature, Implementation)
			eiffel_writer.add_feature (create_coclass_from_pointer_feature (an_implemented_interface_descriptor), Externals)
			eiffel_writer.add_feature (ccom_item_feature (an_implemented_interface_descriptor), Externals)
			eiffel_writer.add_feature (make_from_pointer_feature, Initialization)

		end

end -- class WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_CLIENT_GENERATOR

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
