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

	WIZARD_SPECIAL_TYPE_LIBRARIES
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

