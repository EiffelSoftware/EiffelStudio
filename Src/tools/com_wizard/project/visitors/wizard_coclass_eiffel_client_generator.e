indexing
	description: "Coclass eiffel client generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR
		redefine
			generate
		end

	WIZARD_COMPONENT_EIFFEL_CLIENT_GENERATOR

feature -- Access

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			l_name: STRING
			l_visible: WIZARD_WRITER_VISIBLE_CLAUSE
		do
			Precursor {WIZARD_COCLASS_EIFFEL_GENERATOR} (a_descriptor)

			l_name := name_for_class (a_descriptor.name, a_descriptor.type_kind, True)
			eiffel_writer.set_class_name (l_name)

			create l_visible.make
			l_visible.set_name (l_name)
			l_visible.add_feature ("make")
			l_visible.add_feature (Make_from_other)
			l_visible.add_feature (Make_from_pointer)
			system_descriptor.add_visible_class_client (l_visible)

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

	process_interfaces (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process coclass interfaces.
		local
			l_processor: WIZARD_COCLASS_INTERFACE_EIFFEL_CLIENT_PROCESSOR
		do
			create l_processor.make (a_coclass, eiffel_writer)
			l_processor.process_interfaces
			dispatch_interface := l_processor.dispatch_interface
		end

feature --  Basic operation

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_coclass_eiffel_client
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


	add_default_features (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add default features to coclass client. 
			-- e.g. make, constructor, destructor, delete wrapper etc.
		local
			a_coclass_name: STRING
		do
			a_coclass_name := name_for_feature (a_coclass_descriptor.eiffel_class_name.twin)

			create ccom_create_feature_name.make (240)
			ccom_create_feature_name.append ("ccom_create_")
			ccom_create_feature_name.append (a_coclass_name)

			create ccom_create_from_pointer_feature_name.make (240)
			ccom_create_from_pointer_feature_name.append (ccom_create_feature_name)
			ccom_create_from_pointer_feature_name.append ("_from_pointer")

			create ccom_delete_feature_name.make (240)
			ccom_delete_feature_name.append ("ccom_delete_")
			ccom_delete_feature_name.append (a_coclass_name)

			if is_typeflag_fcancreate (a_coclass_descriptor.flags) then
				eiffel_writer.add_feature (create_coclass_feature (a_coclass_descriptor), Externals)
				eiffel_writer.add_feature (make_feature, Initialization)
			end
			eiffel_writer.add_feature (delete_coclass_feature (a_coclass_descriptor), Externals)
			eiffel_writer.add_feature (delete_wrapper_feature, Implementation)
			eiffel_writer.add_feature (create_coclass_from_pointer_feature (a_coclass_descriptor), Externals)
			eiffel_writer.add_feature (ccom_item_feature (a_coclass_descriptor), Externals)
			eiffel_writer.add_feature (make_from_pointer_feature, Initialization)

		end

	make_feature: WIZARD_WRITER_FEATURE is
			-- `make' feature.
		require
			non_void_eiffel_writer: eiffel_writer /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name ("make")
			Result.set_comment ("Creation")

			create feature_body.make (1000)
			feature_body.append ("%T%T%Tinitializer := ")
			feature_body.append (ccom_create_feature_name)
			feature_body.append ("%N%T%T%Titem := ccom_item (initializer)")

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	add_creation is
			-- Add creation routines.
		do
			if is_typeflag_fcancreate (coclass_descriptor.flags) then
				eiffel_writer.add_creation_routine (Make_word)
			end
			eiffel_writer.add_creation_routine (Make_from_other)
			eiffel_writer.add_creation_routine (Make_from_pointer)
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
end -- class WIZARD_COCLASS_EIFFEL_CLIENT_GENERATOR

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

