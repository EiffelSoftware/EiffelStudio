indexing 
	description: "Common data used both by the GUI and the business logic"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class 
	WIZARD_SHARED_DATA

feature -- Access

	shared_wizard_environment: WIZARD_ENVIRONMENT is
			-- Data used to generate code
		do
			Result := Shared_environment_cell.item
		end

	Generated_iid_file_name: STRING is "$ecom_iid_temp.c"
			-- Midl generated iid file name
	
	Generated_header_file_name: STRING is "$ecom_header_temp.h"
			-- Midl generated header file name
	
	Generated_dlldata_file_name: STRING is "$ecom_data_temp.c"
			-- Midl generated dlldata file name

	Generated_ps_file_name: STRING is "$ecom_ps_temp.c"
			-- Midl generated proxy/stub file name

	Def_file_name: STRING is "$ecom.def"
			-- Path to definition file

	Wizard_extension: STRING is ".ewz"
			-- Wizard file extension

	Clib_name: STRING is "ecom"
			-- Libray file name

	Wizard_wild_card: STRING is
			-- Wizard project file wild card
		once
			Result := "*"
			Result.append (Wizard_extension)
		end

	Wizard_filter: STRING is
			-- Wizard open/save file dialog filter title
		once
			Result := "EiffelCOM Wizard Project"
			Result.append_character ('(')
			Result.append (Wizard_wild_card)
			Result.append_character (')')
		end

	concurrency_model: STRING is "COINIT_APARTMENTTHREADED"

	Standard_abort_value: INTEGER is -100
			-- Standard abort value

	Eiffel_compilation_error: INTEGER is -101
			-- Eiffel compilation error

	Idl_generation_error: INTEGER is -102
			-- Eiffel generation error

	Generated_files_file_name: STRING is "generated.txt"
			-- File including list of generated files

feature -- Element Change

	set_shared_wizard_environment (an_environment: WIZARD_ENVIRONMENT) is
			-- Set `shared_wizard_environment' with `an_environment'.
		require
			non_void_environment: an_environment /= Void
		do
			Shared_environment_cell.replace (an_environment)
		ensure
			environment_set: shared_wizard_environment = an_environment
		end

feature {NONE} -- Implementation

	Shared_environment_cell: CELL [WIZARD_ENVIRONMENT] is
			-- Wizard environment shell
		once
			create Result.put (create {WIZARD_ENVIRONMENT}.make)
		end

end -- class SHARED_DATA

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
