indexing
	description: "Error messages for EiffelCOM wizard."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERRORS

feature -- Error Codes

	No_ise_eiffel: INTEGER is 1
			-- ISE Eiffel not installed

	User_stop: INTEGER is 2
			-- User stopped generation

	Exception_raised: INTEGER is 3
			-- An exception was raised

	Eiffel_compilation_error: INTEGER is 4
			-- Eiffel compilation error

	Idl_generation_error: INTEGER is 5
			-- IDL generation error

	External_program_failed: INTEGER is 6
			-- External program (C compiler) failed

	Makefile_write_error: INTEGER is 7
			-- Makefile could not be written to disk

	File_write_error: INTEGER is 8
			-- File could not be written to disk

	No_type_library: INTEGER is 9
			-- No type library

	No_c_compiler: INTEGER is 10
			-- C compiler not found

	Class_not_in_project: INTEGER is 11
			-- Facade class not in Eiffel project

	C_compilation_failed: INTEGER is 12
			-- C compilation failed

	Idl_compilation_failed: INTEGER is 13
			-- IDL compilation failed

	Link_failed: INTEGER is 14
			-- C link failed

	Destination_folder_cleanup_error: INTEGER is 15
			-- Destination folder cleanup error

	No_midl_compiler: INTEGER is 16
			-- No MIDL compiler but using IDL

feature -- Access

	error_title (a_error: INTEGER): STRING is
			-- Error title associated with `a_error'
		require
			valid_error_code: is_valid_error_code (a_error)
		do
			Result := Error_table.item (a_error)
		ensure
			non_void_message: Result /= Void
		end

feature -- Status Report

	is_valid_error_code (a_error: INTEGER): BOOLEAN is
			-- Is `a_error' a valid error code?
		do
			Result := a_error >= 0 and a_error <= Error_table.count
		end
	
feature {NONE} -- Implementation

	Error_table: ARRAY [STRING] is
			-- Error table
		once
			create Result.make (1, 16)
			Result.put ("Could not find EiffelStudio installation", No_ise_eiffel)
			Result.put ("Generation stopped by user", User_stop)
			Result.put ("An exception was raised", Exception_raised)
			Result.put ("Eiffel compilation failed", Eiffel_compilation_error)
			Result.put ("IDL generation failed", Idl_generation_error)
			Result.put ("Execution of external utility failed", External_program_failed)
			Result.put ("Makefile could not be written to disk", Makefile_write_error)
			Result.put ("File could not be written to disk", File_write_error)
			Result.put ("Type library was not found (IDL compilation failed?)", No_type_library)
			Result.put ("Could not find C compiler installation", No_c_compiler)
			Result.put ("Eiffel Facade class not found in project", Class_not_in_project)
			Result.put ("C compilation failed", C_compilation_failed)
			Result.put ("IDL compilation failed", IDL_compilation_failed)
			Result.put ("C link failed", Link_failed)
			Result.put ("Could not cleanup destination folder, check for locked files", Destination_folder_cleanup_error)
			Result.put ("Could not find MIDL compiler, do not use IDL file for COM definition", No_midl_compiler)
		end
		
end -- class WIZARD_ERRORS

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

