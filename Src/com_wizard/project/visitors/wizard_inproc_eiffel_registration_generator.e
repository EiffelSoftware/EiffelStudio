indexing
	description: "Eiffel Inprocess registration code generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INPROC_EIFFEL_REGISTRATION_GENERATOR

inherit
	WIZARD_REGISTRATION_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Access

	eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS

feature -- Basic operations

	generate is
			-- Generate Eiffel registration code for in-process server.
		do
			create eiffel_writer.make

			eiffel_writer.set_class_name (registration_class_name)
			eiffel_writer.set_description (description_message)

			add_creation

			eiffel_writer.add_feature (make_feature, Initialization)

			eiffel_writer.add_feature (dll_register_server_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_register_server_feature, Externals)

			eiffel_writer.add_feature (dll_unregister_server_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_unregister_server_feature, Externals)

			eiffel_writer.add_feature (dll_get_class_object_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_get_class_object_feature, Externals)

			eiffel_writer.add_feature (dll_can_unload_now_feature, Basic_operations)
			eiffel_writer.add_feature (ccom_dll_can_unload_now_feature, Externals)

			-- Generate code and file name.
			Shared_file_name_factory.create_registration_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	description_message: STRING is 
		"Set the registry keys necessary for COM to activate the component%%%N%T%T%T%T  %
		% %%Do not modify this class."

	add_creation is
			-- Add creation procedures.
		do
			eiffel_writer.add_creation_routine ("make")
		end

	make_feature: WIZARD_WRITER_FEATURE is
			-- `make' feature
		do
			create Result.make
			Result.set_name ("make")
			Result.set_effective
			Result.set_comment ("Initialize server.")
			Result.set_body ("%T%T%T")
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_register_server_feature: WIZARD_WRITER_FEATURE is
			-- Register Server.
		do
			create Result.make
			Result.set_name ("dll_register_server")
			Result.set_effective
			Result.set_comment ("Register Server")
			Result.set_body ("%T%T%TResult := ccom_dll_register_server")
			Result.set_result_type ("INTEGER")
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_register_server_feature: WIZARD_WRITER_FEATURE is
			-- External Register server feature.
		do
			create Result.make
			Result.set_name ("ccom_dll_register_server")
			Result.set_external
			Result.set_comment ("Register server.")
			Result.set_body ("%T%T%T%"C++ [macro %%%"server_registration.h%%%"] (): EIF_INTEGER%"")
			Result.set_result_type ("INTEGER")
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_unregister_server_feature: WIZARD_WRITER_FEATURE is
			-- Unregister Server.
		do
			create Result.make
			Result.set_name ("dll_unregister_server")
			Result.set_effective
			Result.set_comment ("Unregister Server")
			Result.set_body ("%T%T%TResult := ccom_dll_unregister_server")
			Result.set_result_type ("INTEGER")
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_unregister_server_feature: WIZARD_WRITER_FEATURE is
			-- External Unregister server feature.
		do
			create Result.make
			Result.set_name (ccom_dll_unregister_server)
			Result.set_external
			Result.set_comment ("Unregister server.")
			Result.set_body ("%T%T%T%"C++ [macro %%%"server_registration.h%%%"] (): EIF_INTEGER%"")
			Result.set_result_type ("INTEGER")
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_get_class_object_feature: WIZARD_WRITER_FEATURE is
			-- Get Class Object.
		do
			create Result.make
			Result.set_name ("dll_get_class_object")
			Result.set_effective
			Result.set_comment ("Get class object.")
			Result.add_argument ("a_clsid, a_riid, ppv: POINTER")
			Result.set_result_type ("INTEGER")
			Result.set_body ("%T%T%TResult := ccom_dll_get_class_object (a_clsid, a_riid, ppv)")
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_get_class_object_feature: WIZARD_WRITER_FEATURE is
			-- External Get Class Object feature.
		do
			create Result.make
			Result.set_name (ccom_dll_get_class_object)
			Result.set_external
			Result.set_comment ("Get Class Object.")
			Result.add_argument ("a_clsid, a_riid, ppv: POINTER")
			Result.set_body ("%T%T%T%"C++ [macro %%%"server_registration.h%%%"] (CLSID*, IID*, void**): EIF_INTEGER%"")
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	dll_can_unload_now_feature: WIZARD_WRITER_FEATURE is
			-- DLL can unload now.
		do
			create Result.make
			Result.set_name ("dll_can_unload_now")
			Result.set_effective
			Result.set_comment ("Can unload now?")
			Result.set_body ("%T%T%TResult := ccom_dll_can_unload_now")
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_dll_can_unload_now_feature: WIZARD_WRITER_FEATURE is
			-- External Can unload now feature.
		do
			create Result.make
			Result.set_name (ccom_dll_can_unload_now)
			Result.set_external
			Result.set_comment ("Can unload now?")
			Result.set_body ("%T%T%T%"C++ [macro %%%"server_registration.h%%%"] (): EIF_INTEGER%"")
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
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
end -- class WIZARD_INPROC_EIFFEL_REGISTRATION_GENERATOR

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

