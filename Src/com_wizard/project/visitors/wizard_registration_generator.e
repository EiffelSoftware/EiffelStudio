indexing
	description: "Registration code generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_REGISTRATION_GENERATOR

inherit
	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_REJECTED_TYPE_LIBRARIES
		export
			{NONE} all
		end

feature -- Access

	generate is 
			-- Generated Eiffel registration code.
		deferred
		end

	ccom_dll_register_server: STRING is "ccom_dll_register_server"
			-- Used for code generation.

	ccom_dll_unregister_server: STRING is "ccom_dll_unregister_server"
			-- Used for code generation.

	ccom_dll_get_class_object: STRING is "ccom_dll_get_class_object"
			-- Used for code generation.

	ccom_dll_can_unload_now: STRING is "ccom_dll_can_unload_now"
			-- Used for code generation.

	Ccom_initialize_com: STRING is "ccom_initialize_com"
			-- Used for code generation.

	Ccom_cleanup_com: STRING is "ccom_cleanup_com"
			-- Used for code generation.

	Ccom_register_server: STRING is "ccom_register_server"
			-- Used for code generation.

	Ccom_unregister_server: STRING is "ccom_unregister_server"
			-- Used for code generation.

feature -- Basic operations

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		deferred		
		end

end -- class WIZARD_REGISTRATION_GENERATOR

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
