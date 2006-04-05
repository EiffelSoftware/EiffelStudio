indexing
	description: "Coclass eiffel server generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_SERVER_IMPL_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR 
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
			l_description: STRING
			l_visible: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			coclass_descriptor := a_coclass

			create l_visible.make
			l_visible.set_name (implemented_coclass_name (a_coclass.eiffel_class_name))
			system_descriptor.add_visible_class_server (l_visible)
			create eiffel_writer.make

			eiffel_writer.set_class_name (implemented_coclass_name (a_coclass.eiffel_class_name))

			create l_description.make (1000)
			l_description.append (a_coclass.eiffel_class_name)
			l_description.append (" Implementation.")
			eiffel_writer.set_description (l_description)
			set_default_ancestors (eiffel_writer)

			add_creation
			add_default_features (a_coclass)

			if not environment.is_eiffel_interface then
				process_interfaces (a_coclass)
			end

			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			eiffel_writer := Void
		end

	process_interfaces (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process coclass interfaces.
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_PROCESSOR 
		do
			create interface_processor.make (a_coclass, eiffel_writer)
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
		end

	add_creation is
			-- Add creation clause,.
		do
			eiffel_writer.add_creation_routine (Make_word)
			eiffel_writer.add_creation_routine ("make_from_pointer")
		end

	add_default_features (a_component: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add default features to coclass server. 
			-- e.g. make, constructor etc.
		do
			if environment.is_eiffel_interface then
				eiffel_writer.add_feature (make_feature_precursor, Initialization)
			else
				eiffel_writer.add_feature (make_feature, Initialization)
			end
			eiffel_writer.add_feature (make_from_pointer_feature, Initialization)
			eiffel_writer.add_feature (create_item_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_create_item_feature (a_component), Externals)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	set_default_ancestors (a_writer: WIZARD_WRITER_EIFFEL_CLASS) is
		local
			l_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create l_writer.make

			if environment.is_eiffel_interface then
				l_writer.set_name (environment.eiffel_class_name)
				l_writer.add_redefine (make_word)
			else
				l_writer.set_name (coclass_descriptor.eiffel_class_name)
			end

			a_writer.add_inherit_clause (l_writer)

			if environment.is_eiffel_interface then
				create l_writer.make
				l_writer.set_name ("ECOM_STUB")
				a_writer.add_inherit_clause (l_writer)
			end
		end

	ccom_create_item_feature (a_component: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_WRITER_FEATURE is
			-- `create_item' feature.
		local
			l_body: STRING
			l_argument: STRING
		do
			create Result.make
			Result.set_name ("ccom_create_item")
			Result.set_comment ("Initialize %Qitem%'")

			create l_argument.make (100)
			l_argument.append ("eif_object: like Current")
			Result.add_argument (l_argument)

			Result.set_result_type ("POINTER")

			create l_body.make (100)
			l_body.append ("%T%T%T%"C++ [new ")
			if a_component.namespace /= Void and then not a_component.namespace.is_empty then
				l_body.append (a_component.namespace)
				l_body.append ("::")
			end
			l_body.append (a_component.c_type_name)
			l_body.append (" %%%"")
			l_body.append (a_component.c_definition_header_file_name)
			l_body.append ("%%%"](EIF_OBJECT)%"")

			Result.set_external
			Result.set_body (l_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	make_feature_precursor: WIZARD_WRITER_FEATURE is
			-- `make' feature.
		local
			l_body: STRING
		do
			create Result.make
			Result.set_name ("make")
			Result.set_comment ("Creation.")

			create l_body.make (100)
			l_body.append ("%T%T%TPrecursor {")
			l_body.append (environment.eiffel_class_name)
			l_body.append ("}")

			Result.set_effective
			Result.set_body (l_body)
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
end -- class WIZARD_COCLASS_EIFFEL_SERVER_GENERATOR

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

