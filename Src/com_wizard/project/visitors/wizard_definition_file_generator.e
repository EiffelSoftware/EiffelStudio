indexing

	description: "Definition file generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DEFINITION_FILE_GENERATOR

inherit
	WIZARD_TYPE_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Access

	definition_file_writer: WIZARD_WRITER_DEFINITION_FILE

feature -- Basic Operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generated writer
		local
			entry: WIZARD_WRITER_DEFINITION_ENTRY
		do
			create definition_file_writer.make
			-- Set system name
			definition_file_writer.set_system_name (shared_wizard_environment.project_name)

			-- Export features
			-- DllRegisterServer
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_export_feature_name (Register_dll_server_function_name)
			entry.set_feature_index (Dll_register_ordinal)
			entry.set_feature_alias (Dll_register_server)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			-- DllUnregisterServer
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_export_feature_name (Unregister_dll_server_function_name)
			entry.set_feature_index (Dll_unregister_ordinal)
			entry.set_feature_alias (Dll_unregister_server)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			-- DllGetClassObject
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_export_feature_name (Get_class_object_function_name)
			entry.set_feature_index (Dll_get_class_object_ordinal)
			entry.set_feature_alias (Dll_get_class_object)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			-- DllCanUnloadNow
			create entry.make
			entry.set_root_class_name (registration_class_name)
			entry.set_export_feature_name (Can_unload_dll_now_function_name)
			entry.set_feature_index (Dll_can_unload_now_ordinal)
			entry.set_feature_alias (Dll_can_unload_now)
			entry.set_call_type (Std_call_type)
			definition_file_writer.add_entry (entry)

			check
				can_generate_definition: definition_file_writer.can_generate
			end

			Shared_file_name_factory.create_file_name (Current, definition_file_writer)
			definition_file_writer.save_file (Shared_file_name_factory.last_created_file_name)
		end

	create_file_name (a_file_name_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Get file name.
		do
			a_file_name_factory.process_definition_file
		end

	Dll_register_ordinal: INTEGER is 1
			-- DllRegister exported function ordinal

	Dll_unregister_ordinal: INTEGER is 2
			-- DllUnregister exported function ordinal

	Dll_get_class_object_ordinal: INTEGER is 3
			-- DllGetClassObject exported function ordinal

	Dll_can_unload_now_ordinal: INTEGER is 4
			-- DllCanUnloadNow exported function ordinal

	Std_call_type: STRING is "__stdcall"
			-- Standard call type

end -- class WIZARD_TYPE_GENERATOR

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
