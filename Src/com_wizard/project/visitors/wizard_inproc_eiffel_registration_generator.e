indexing
	description: "Eiffel Inprocess registration code generator"
	status: "See notice at end of class";
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
		local
			tmp_name: STRING
		do
			create eiffel_writer.make

			tmp_name := to_eiffel_name (shared_wizard_environment.project_name)
			tmp_name.prepend ("ECOM_")
			tmp_name.append ("_REGISTRATION")
			tmp_name.to_upper

			eiffel_writer.set_class_name (tmp_name)

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
		"Objectes of this class set the registry keys necessary for COM to access the component%%%N%T%T%T%T  %
		% %%and activate a new instance of the component whenever COM asks for if.%%%N%T%T%T%T  %
		% %%User should not inherit from this class or modify it."

	Local_string_var: STRING is "local_string"
			-- Used for code generation.

	dll_register_server_name: STRING is "dll_register_server"
			-- Used for code generation.

	ccom_dll_register_server: STRING is "ccom_dll_register_server"
			-- Used for code generation.

	dll_unregister_server_name: STRING is "dll_unregister_server"
			-- Used for code generation.

	ccom_dll_unregister_server: STRING is "ccom_dll_unregister_server"
			-- Used for code generation.

	dll_get_class_object_name: STRING is "dll_get_class_object"
			-- Used for code generation.

	ccom_dll_get_class_object: STRING is "ccom_dll_get_class_object"
			-- Used for code generation.

	dll_can_unload_now_name: STRING is "dll_can_unload_now"
			-- Used for code generation.

	ccom_dll_can_unload_now: STRING is "ccom_dll_can_unload_now"
			-- Used for code generation.

invariant
	invariant_clause: -- Your invariant here

end -- class WIZARD_INPROC_EIFFEL_REGISTRATION_GENERATOR

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
