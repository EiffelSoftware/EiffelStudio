indexing
	description: "Server implemented interface generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_EIFFEL_SERVER_GENERATOR

	WIZARD_EIFFEL_WRITER_GENERATOR

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

feature -- Basic operations

	generate (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate 
		local
			l_class_name: STRING
			l_clause: WIZARD_WRITER_INHERIT_CLAUSE
			l_visible: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			l_class_name := a_interface.impl_eiffel_class_name (False)

			create l_visible.make
			a_interface.set_impl_names (False)
			l_visible.set_name (a_interface.eiffel_class_name)
			system_descriptor.add_visible_class_server (l_visible)

			create eiffel_writer.make

			dispatch_interface := (a_interface.interface_descriptor.dispinterface or 
					a_interface.interface_descriptor.dual)
			eiffel_writer.set_class_name (l_class_name)
			eiffel_writer.set_description (a_interface.description)

			create l_clause.make
			l_clause.set_name (a_interface.interface_descriptor.eiffel_class_name)

			if a_interface.source then
				Source_eiffel_server_generator.initialize (a_interface, a_interface.interface_descriptor, eiffel_writer, l_clause)
				Source_eiffel_server_generator.generate_functions_and_properties (a_interface.interface_descriptor)
			else 
				Eiffel_server_generator.initialize (a_interface, a_interface.interface_descriptor, eiffel_writer, l_clause)
				Eiffel_server_generator.generate_functions_and_properties (a_interface.interface_descriptor)
			end

			eiffel_writer.add_inherit_clause (l_clause)
			set_default_ancestors (eiffel_writer)
			add_creation
			add_default_features (a_interface)
			
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

	add_default_features (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add default features,
			-- e.g. make, constructor, destructor, delete wrapper etc.
		do
			eiffel_writer.add_feature (create_item_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_create_item_feature (a_interface), Externals)
		end

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors
		local
			l_clause: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create l_clause.make
			l_clause.set_name ("ECOM_STUB")
			an_eiffel_writer.add_inherit_clause (l_clause)
		end

	ccom_create_item_feature (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_WRITER_FEATURE is
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
			an_argument.append (a_interface.impl_eiffel_class_name (False))
			Result.add_argument (an_argument)

			Result.set_result_type ("POINTER")

			create feature_body.make (100)
			feature_body.append ("%T%T%T%"C++ [new ")
			if a_interface.namespace /= Void and then not a_interface.namespace.is_empty then
				feature_body.append (a_interface.namespace)
				feature_body.append ("::")
			end
			feature_body.append (a_interface.impl_c_type_name (False))
			feature_body.append (" %%%"")
			feature_body.append (a_interface.impl_c_definition_header_file_name (False))
			feature_body.append ("%%%"](EIF_OBJECT)%"")

			Result.set_external
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
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
end -- class WIZARD_IMPLEMENTED_INTERFACE_EIFFEL_SERVER_GENERATOR

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

