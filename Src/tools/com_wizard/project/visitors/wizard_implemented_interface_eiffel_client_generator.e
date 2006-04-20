indexing
	description: "Implemented interface Eiffel client generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_CLIENT_GENERATOR
		redefine
			set_default_ancestors
		end

	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

feature -- Basic operations

	generate (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate 
		local
			a_class_name: STRING
			inherit_clause: WIZARD_WRITER_INHERIT_CLAUSE
			a_visible: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			create a_visible.make

			a_descriptor.set_impl_names (True)

			a_visible.set_name (a_descriptor.eiffel_class_name)
			a_visible.add_feature (Make_from_other)
			a_visible.add_feature (Make_from_pointer)
			system_descriptor.add_visible_class_client (a_visible)

			create eiffel_writer.make

			a_class_name := a_descriptor.eiffel_class_name

			dispatch_interface := (a_descriptor.interface_descriptor.dispinterface or a_descriptor.interface_descriptor.dual)

			eiffel_writer.set_class_name (a_class_name)
			eiffel_writer.set_description (a_descriptor.description)

			create inherit_clause.make
			inherit_clause.set_name (a_descriptor.interface_descriptor.eiffel_class_name)

			Eiffel_client_generator.initialize (a_descriptor, a_descriptor.interface_descriptor, eiffel_writer, inherit_clause)
			Eiffel_client_generator.generate_functions_and_properties (a_descriptor.interface_descriptor)
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

			eiffel_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_impl_interface_eiffel_client
		end

feature {NONE} -- Implementation

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors
		local
			tmp_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create tmp_writer.make
			tmp_writer.set_name (Queriable_type)
			an_eiffel_writer.add_inherit_clause (tmp_writer)
		end

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
			a_coclass_name := name_for_feature (an_implemented_interface_descriptor.eiffel_class_name.twin)

			create ccom_create_from_pointer_feature_name.make (100)
			ccom_create_from_pointer_feature_name.append (Ccom_clause)
			ccom_create_from_pointer_feature_name.append ("create_")
			ccom_create_from_pointer_feature_name.append (a_coclass_name)
			ccom_create_from_pointer_feature_name.append ("_from_pointer")

			create ccom_delete_feature_name.make (100)
			ccom_delete_feature_name.append (Ccom_clause)
			ccom_delete_feature_name.append ("delete_")
			ccom_delete_feature_name.append (a_coclass_name)

			eiffel_writer.add_feature (delete_coclass_feature (an_implemented_interface_descriptor), Externals)
			eiffel_writer.add_feature (delete_wrapper_feature, Implementation)
			eiffel_writer.add_feature (create_coclass_from_pointer_feature (an_implemented_interface_descriptor), Externals)
			eiffel_writer.add_feature (ccom_item_feature (an_implemented_interface_descriptor), Externals)
			eiffel_writer.add_feature (make_from_pointer_feature, Initialization)

		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_CLIENT_GENERATOR

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

