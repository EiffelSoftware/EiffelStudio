indexing

	description: "Definition file generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DEFINITION_FILE_GENERATOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Access

	definition_file_writer: WIZARD_WRITER_DEFINITION_FILE

feature -- Basic Operations

	generate  is
			-- Generated writer
		local
			entry: WIZARD_WRITER_DEFINITION_ENTRY
		do
			create definition_file_writer.make
			-- Set system name
			definition_file_writer.set_system_name (environment.project_name)

			-- Export features
			-- DllRegisterServer
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_class_creation_feature_name (Registration_class_creation_routine)
			entry.set_export_feature_name (Register_dll_server_function_name)
			entry.set_feature_index (Dll_register_ordinal)
			entry.set_feature_alias (Dll_register_server)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			-- DllUnregisterServer
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_class_creation_feature_name (Registration_class_creation_routine)
			entry.set_export_feature_name (Unregister_dll_server_function_name)
			entry.set_feature_index (Dll_unregister_ordinal)
			entry.set_feature_alias (Dll_unregister_server)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			-- DllGetClassObject
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_class_creation_feature_name (Registration_class_creation_routine)
			entry.set_export_feature_name (Get_class_object_function_name)
			entry.set_feature_index (Dll_get_class_object_ordinal)
			entry.set_feature_alias (Dll_get_class_object)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			-- DllCanUnloadNow
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_class_creation_feature_name (Registration_class_creation_routine)
			entry.set_export_feature_name (Can_unload_dll_now_function_name)
			entry.set_feature_index (Dll_can_unload_now_ordinal)
			entry.set_feature_alias (Dll_can_unload_now)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			check
				can_generate_definition: definition_file_writer.can_generate
			end

			Shared_file_name_factory.create_definition_file_name (Current, definition_file_writer)
			definition_file_writer.save_file (Shared_file_name_factory.last_created_file_name)
		end

	Dll_register_ordinal: INTEGER is 1
			-- DllRegister exported function ordinal

	Dll_unregister_ordinal: INTEGER is 2
			-- DllUnregister exported function ordinal

	Dll_get_class_object_ordinal: INTEGER is 3
			-- DllGetClassObject exported function ordinal

	Dll_can_unload_now_ordinal: INTEGER is 4
			-- DllCanUnloadNow exported function ordinal

	Std_call_type: STRING is "__stdcall";
			-- Standard call type

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
end -- class WIZARD_TYPE_GENERATOR

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

